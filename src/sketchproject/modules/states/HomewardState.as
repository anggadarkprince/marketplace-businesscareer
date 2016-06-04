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
	 * State that makes agent going home.
	 *
	 * @author Angga
	 */
	public class HomewardState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var homeCoordinate:Point;

		/**
		 * Default constructor of HomewardState.
		 *
		 * @param agent
		 */
		public function HomewardState(agent:Agent)
		{
			this.agent = agent;
			this.name = "homeward";
		}

		/**
		 * Initialize homeward state.
		 */
		public function initialize():void
		{
			trace("          |-- [state:homeward] agent id", agent.agentId, ": onEnter");

			updated = false;

			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();

			homeCoordinate = new Point();
			var index:int;

			if (agent.district == Agent.DISTRICT_VILLAGE)
			{
				index = GameUtils.randomFor(Config.villageCoordinate.length - 1);
				homeCoordinate.x = Config.villageCoordinate[index].x;
				homeCoordinate.y = Config.villageCoordinate[index].y;
			}
			else if (agent.district == Agent.DISTRICT_MURBAWISMA)
			{
				index = GameUtils.randomFor(Config.murbawismaCoordinate.length - 1);
				homeCoordinate.x = Config.murbawismaCoordinate[index].x;
				homeCoordinate.y = Config.murbawismaCoordinate[index].y;
			}
			else if (agent.district == Agent.DISTRICT_MADYAWISMA)
			{
				index = GameUtils.randomFor(Config.murbawismaCoordinate.length - 1);
				homeCoordinate.x = Config.murbawismaCoordinate[index].x;
				homeCoordinate.y = Config.murbawismaCoordinate[index].y;
			}
			else if (agent.district == Agent.DISTRICT_ADIWISMA)
			{
				index = GameUtils.randomFor(Config.adiwismaCoordinate.length - 1);
				homeCoordinate.x = Config.adiwismaCoordinate[index].x;
				homeCoordinate.y = Config.adiwismaCoordinate[index].y;
			}

			agent.destination = agent.coordinate;
			agent.path.splice(0, agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, homeCoordinate.x, homeCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(homeCoordinate);

			agent.isMoving = true;

			trace("            |-- [state:homeward] destination", agent.district, homeCoordinate);
			trace("            |-- [state:homeward] path", agent.path);
		}

		/**
		 * Update homeward state.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("          |-- [state:homeward] agent id", agent.agentId, ": onUpdate to", agent.district);
				updated = true;
			}

			if (agent.isMoving)
			{
				agent.moving();
			}
			else
			{
				agent.alpha = 0.3;
				agent.action.pushState(agent.idleAction);
			}
		}

		/**
		 * Destroy homeward state resources.
		 */
		public function destroy():void
		{
			trace("          |-- [state:homeward] agent id", agent.agentId, ": onExit from", agent.district);

			agent.alpha = 1;
			updated = false;
		}

		/**
		 * Print class name.
		 *
		 * @return
		 */
		public function toString():String
		{
			return "sketchproject.modules.states.HomewardState";
		}
	}
}
