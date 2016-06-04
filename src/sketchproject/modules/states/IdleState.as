package sketchproject.modules.states
{
	import sketchproject.core.Assets;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.utilities.GameUtils;

	import starling.events.Event;

	/**
	 * Flocking inside district, gives influence, produce stress and decrease health.
	 *
	 * @author Angga
	 */
	public class IdleState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;

		private var delay:int;
		private var delayLimit:int;
		private var action:int;
		private var currentHour:int;
		private var lastHour:int;
		private var idleTaken:int;

		private var isDelayWandering:Boolean;
		private var delayWanderingMax:int;
		private var delayWanderingTaken:int;

		/**
		 * Default constructor of IdleState.
		 *
		 * @param agent
		 */
		public function IdleState(agent:Agent)
		{
			this.agent = agent;
			this.name = "idle";

			this.delay = 0;
			this.delayLimit = 50 + GameUtils.randomFor(50);
			this.action = 0;
		}

		/**
		 * Initialize idle state.
		 */
		public function initialize():void
		{
			trace("      |-- [state:idle] agent id", agent.agentId, ": onEnter");

			updated = false;

			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_stand"));
			agent.baseCharacter.loop = false;
			agent.baseCharacter.stop();

			currentHour = WorldManager.instance.map.hour;
			lastHour = currentHour;

			// make sure agent now just standing, do nothing
			agent.baseCharacter.addEventListener(Event.COMPLETE, function(event:Event):void
			{
				GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_stand"));
			});

			// remove idle itself when below this state is wandering
			isDelayWandering = false;
			delayWanderingMax = 0;
			delayWanderingTaken = 0;
			for (var i:int = 0; i < agent.action.stackState.length; i++)
			{
				if (agent.action.stackState[i] == agent.idleAction && i != 0)
				{
					if (agent.action.stackState[i - 1] == agent.wanderingAction && agent.isFlocking)
					{
						isDelayWandering = true;
						delayWanderingMax = 100 + GameUtils.randomFor(400);
						trace("        |-- [state:wandering] agent id", agent.agentId, "idle for", delayWanderingMax, "frames");
						break;
					}
				}
			}

			if (!agent.isStress)
			{
				idleTaken = lastHour + GameUtils.randomFor(4);
			}
		}

		/**
		 * Update state of idle.
		 */
		public function update():void
		{
			if (!updated)
			{
				if (isDelayWandering)
				{
					trace("      |-- [state:idle] agent id", agent.agentId, ": onUpdate");
				}
				else
				{
					trace("            |-- [state:idle] agent id", agent.agentId, ": onUpdate");
				}

				updated = true;
			}

			if (isDelayWandering)
			{
				if (delayWanderingTaken++ > delayWanderingMax)
				{
					agent.action.checkState(agent.idleAction, true);
					if (agent.action.getCurrentState() == agent.wanderingAction)
					{
						agent.action.getCurrentState().initialize();
					}
					delayWanderingTaken = 0;
				}
			}

			// change random expression
			delay++;
			if (delay == delayLimit)
			{
				action = GameUtils.randomFor(10);
				if (action > 6)
				{
					if (GameUtils.probability(0.5))
					{
						agent.perceptReaction("service");
					}
					agent.facing = agent.facing == "right" ? "left" : "right";
					agent.flipFacing();
				}
				else if (action > 4)
				{
					GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_yup"));
					agent.baseCharacter.play();
				}
				else if (action > 2)
				{
					GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_tada"));
					agent.baseCharacter.play();
				}

				delay = 0;
			}

			currentHour = WorldManager.instance.map.hour;
			if (currentHour != lastHour)
			{
				// calculate stress or health, higher determinant more minimum stress effect probability
				// if idle while studying
				if (agent.action.checkState(agent.studyingAction))
				{
					if (agent.stress < 10 && GameUtils.probability((10 - agent.actionWill) / 10))
					{
						agent.stress += GameUtils.randomFor(4, false);
						trace("              |-- [state:idle] agent id", agent.agentId, "stress", agent.stress);
					}
					if (agent.health > 0 && GameUtils.probability(GameUtils.randomFor(0.1)))
					{
						agent.health -= GameUtils.randomFor(2, false);
						trace("              |-- [state:idle] agent id", agent.agentId, "health", agent.health);
					}
				}
				// if idle while trading
				else if (agent.action.checkState(agent.tradingAction))
				{
					if (agent.stress < 10 && GameUtils.probability((10 - agent.actionWill) / 10))
					{
						agent.stress += GameUtils.randomFor(4, false);
						trace("              |-- [state:idle] agent id", agent.agentId, "stress", agent.stress);
					}
					if (agent.health > 0 && GameUtils.probability(GameUtils.randomFor(0.5)))
					{
						agent.health -= GameUtils.randomFor(2, false);
						trace("              |-- [state:idle] agent id", agent.agentId, "health", agent.health);
					}
				}
				// if idle while working
				else if (agent.action.checkState(agent.workingAction))
				{
					if (agent.stress < 10 && GameUtils.probability((10 - agent.actionWill) / 10))
					{
						agent.stress += GameUtils.randomFor(5, false);
						trace("              |-- [state:idle] agent id", agent.agentId, "stress", agent.stress);
					}
					if (agent.health > 0 && GameUtils.probability(GameUtils.randomFor(0.3)))
					{
						agent.health -= GameUtils.randomFor(3, false);
						trace("              |-- [state:idle] agent id", agent.agentId, "health", agent.health);
					}
				}

				// sick or healthy, in home or hospital agent's health rising up and stress is colling down
				var isHomeward:Boolean = agent.action.checkState(agent.homewardAction);
				var isPlaying:Boolean = agent.action.checkState(agent.playingAction);
				var isVacation:Boolean = agent.action.checkState(agent.vacationAction);
				var isVisiting:Boolean = agent.action.checkState(agent.visitingAction);

				if (isHomeward || (isVisiting && agent.targetDistrict == "Hospital"))
				{
					agent.health += GameUtils.randomFor(5, false);
					agent.stress -= GameUtils.randomFor(2, false);

					// limiting health
					if (agent.health > 10)
					{
						agent.health = 10;
						trace("                |-- [state:idle] agent id", agent.agentId, "health reaches maximum", agent.health);
					}
					else if (agent.health < 0)
					{
						agent.health = 0;
						trace("                |-- [state:idle] agent id", agent.agentId, "health reaches minimum", agent.health);
					}

					// limiting stress
					if (agent.stress < 0)
					{
						agent.stress = 0;
						trace("                |-- [state:idle] agent id", agent.agentId, "stress reaches minimum", agent.health);
					}
					else if (agent.stress > 10)
					{
						agent.stress = 10;
						trace("                |-- [state:idle] agent id", agent.agentId, "stress reaches maximum", agent.health);
					}

					// health evaluation
					if (agent.isSick)
					{
						if (agent.health > (8 + GameUtils.randomFor(2)))
						{
							agent.isSick = false;
							agent.action.checkState(agent.idleAction, true);
							agent.action.checkState(agent.homewardAction, true);
							if (agent.targetDistrict == "Hospital")
							{
								agent.action.checkState(agent.visitingAction, true);
							}
							agent.targetDistrict = "";
							trace("                |-- [state:idle] agent id", agent.agentId, "is not sick anymore");
						}
					}

					// stress evaluation
					if (agent.isStress)
					{
						if (agent.stress < (2 - GameUtils.randomFor(2)))
						{
							agent.isStress = false;
							agent.action.checkState(agent.idleAction, true);
							agent.action.checkState(agent.homewardAction, true);
							if (agent.targetDistrict == "Hospital")
							{
								agent.action.checkState(agent.visitingAction, true);
							}
							agent.targetDistrict = "";
							trace("                |-- [state:idle] agent id", agent.agentId, "is not stress anymore");
						}
					}
				}

				// stress or not, playing or vacation make agent happy
				if (isPlaying || isVacation)
				{
					agent.stress -= GameUtils.randomFor(8, false);
					if (agent.stress < GameUtils.randomFor(2))
					{
						trace("                |-- [state:idle] agent id", agent.agentId, "is not stress anymore");
						agent.isStress = false;
						agent.action.checkState(agent.idleAction, true);
						agent.action.checkState(agent.playingAction, true);
						agent.action.checkState(agent.vacationAction, true);
					}

					// check if agent now is playing and they play at will and meet a couple hour until boring
					if (currentHour == idleTaken && !agent.isStress)
					{
						trace("            |-- [state:idle] agent id", agent.agentId, "stop playing because boring");
						agent.action.checkState(agent.idleAction, true);
						agent.action.checkState(agent.playingAction, true);
						agent.action.checkState(agent.vacationAction, true);
					}
				}

				lastHour = currentHour;
			}
		}

		/**
		 * Destroy idle state resources.
		 */
		public function destroy():void
		{
			if (isDelayWandering)
			{
				trace("          |-- [state:idle] agent id", agent.agentId, ": onExit");
			}

			agent.alpha = 1;
			agent.perceptReaction("none");
		}

		/**
		 * Print class name.
		 *
		 * @return
		 */
		public function toString():String
		{
			return "sketchproject.modules.states.IdleState";
		}
	}
}
