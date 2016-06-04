package sketchproject.modules.states
{
	import flash.geom.Point;

	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.modules.PathFinder;
	import sketchproject.utilities.GameUtils;

	/**
	 * State that visited by agent when holiday.
	 *
	 * @author Angga
	 */
	public class VacationState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var vacationCoordinate:Point;

		/**
		 * Default constructor of VacationState.
		 *
		 * @param agent
		 */
		public function VacationState(agent:Agent)
		{
			this.agent = agent;
			this.name = "vacation";
		}

		/**
		 * Initialize vacation state
		 */
		public function initialize():void
		{
			trace("          |-- [state:vacation] agent id", agent.agentId, ": onEnter");

			updated = false;

			agent.dX = 0;
			agent.dY = 0;
			agent.isMoving = false;

			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();

			vacationCoordinate = new Point();
			var index:int = GameUtils.randomFor(100);
			var beachProbability:int;
			var wonderlandProbability:int;

			if (agent.role == Agent.ROLE_STUDENT)
			{
				beachProbability = 40;
				wonderlandProbability = 60;
			}
			else if (agent.role == Agent.ROLE_WORKER)
			{
				beachProbability = 50;
				wonderlandProbability = 50;
			}
			else if (agent.role == Agent.ROLE_TRADER)
			{
				beachProbability = 60;
				wonderlandProbability = 40;
			}

			if (index > (100 - beachProbability))
			{
				index = GameUtils.randomFor(Config.beachCoordinate.length - 1);
				vacationCoordinate.x = Config.beachCoordinate[index].x;
				vacationCoordinate.y = Config.beachCoordinate[index].y;
				agent.targetDistrict = "Horizon Bay";
			}
			else
			{
				index = GameUtils.randomFor(Config.wonderlandCoordinate.length - 1);
				vacationCoordinate.x = Config.wonderlandCoordinate[index].x;
				vacationCoordinate.y = Config.wonderlandCoordinate[index].y;
				agent.targetDistrict = "Wonderland";
			}

			agent.destination = agent.coordinate;
			agent.path.splice(0, agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, vacationCoordinate.x, vacationCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(vacationCoordinate);
			agent.isMoving = true;

			agent.stress = GameUtils.randomFor(4);
			agent.emotion = GameUtils.randomFor(3) + 7;

			trace("            |-- [state:vacation] destination", agent.targetDistrict, vacationCoordinate);
			trace("            |-- [state:vacation] path", agent.path);
		}

		/**
		 * Update playing state.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("          |-- [state:vacation] agent id", agent.agentId, ": onUpdate to", agent.targetDistrict);
				updated = true;
			}

			if (agent.isMoving)
			{
				agent.moving();
			}
			else
			{
				trace("            |-- [state:vacation] agent id", agent.agentId, "arrived in", agent.targetDistrict);
				agent.alpha = 0.3;
				agent.action.pushState(agent.idleAction);
			}
		}

		/**
		 * Destroy playing state resources.
		 */
		public function destroy():void
		{
			trace("          |-- [state:vacation] agent id", agent.agentId, ": onExit from", agent.targetDistrict);

			agent.alpha = 1;
			agent.targetDistrict = "";
			updated = false;
		}

		/**
		 * Print class name.
		 *
		 * @return
		 */
		public function toString():String
		{
			return "sketchproject.modules.states.VacationState";
		}
	}
}
