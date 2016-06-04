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
	 * State to push agent visit school district and combine with idle state to generate stress and sickness.
	 *
	 * @author Angga
	 */
	public class StudyingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var schoolCoordinate:Point;

		/**
		 * Default constructor of StudyingState.
		 *
		 * @param agent
		 */
		public function StudyingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "studying";
		}

		/**
		 * Initialize studying state.
		 */
		public function initialize():void
		{
			trace("          |-- [state:studying] agent id", agent.agentId, ": onEnter");
			
			updated = false;

			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_walk"));
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			agent.baseCharacter.loop = true;

			// fetch random location of school district
			var index:int = GameUtils.randomFor(Config.schoolCoordinate.length - 1);
			schoolCoordinate = new Point();
			schoolCoordinate.x = Config.schoolCoordinate[index].x;
			schoolCoordinate.y = Config.schoolCoordinate[index].y;

			// find the way to go there
			agent.destination = agent.coordinate;
			agent.path.splice(0, agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, schoolCoordinate.x, schoolCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(schoolCoordinate);
			
			trace("            |-- [state:studying] destination", schoolCoordinate);
			trace("            |-- [state:studying] path", agent.path);

			agent.isMoving = true;
		}

		/**
		 * Update state of studying.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("          |-- [state:studying] agent id", agent.agentId, ": onUpdate");
				updated = true;
			}

			if (agent.isMoving)
			{
				agent.moving();
			}
			else
			{
				trace("            |-- [state:studying] agent id", agent.agentId, "arrived in school district");
				agent.alpha = 0.3;
				agent.action.pushState(agent.idleAction);
			}
		}

		/**
		 * Destroy studying state resources.
		 */
		public function destroy():void
		{
			trace("          |-- [state:studying] agent id", agent.agentId, ": onExit");

			agent.mainRoleDone = true;
			agent.alpha = 1;
			updated = false;
		}

		/**
		 * Print class name.
		 *
		 * @return class name
		 */
		public function toString():String
		{
			return "sketchproject.modules.states.StudiyingState";
		}
	}
}
