package sketchproject.modules.states
{
	import flash.geom.Point;

	import sketchproject.core.Assets;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.modules.PathFinder;
	import sketchproject.utilities.GameUtils;

	/**
	 * State that makes agent moving around the game world randomly.
	 *
	 * @author Angga
	 */
	public class WanderingState implements IState
	{
		private var agent:Agent;
		private var name:String;		
		private var updated:Boolean;
		private var wanderingDestination:Point;

		/**
		 * Default constructor of WanderingState.
		 *
		 * @param agent
		 */
		public function WanderingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "wandering";
		}

		/**
		 * Initialize wandering state.
		 */
		public function initialize():void
		{
			trace("  |-- [state:wandering] agent id", agent.agentId, ": onEnter");

			updated = false;

			// add animation walking
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_walk"));
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			agent.isFirstStep = true;
			agent.baseCharacter.loop = true;
			agent.isFlocking = true;

			// generate path to destination
			wanderingDestination = WorldManager.instance.map.generateWalkableCoordinate();
			agent.destination = agent.coordinate;
			agent.path.splice(0, agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, wanderingDestination.x, wanderingDestination.y, WorldManager.instance.map.levelData);
			agent.path.unshift(wanderingDestination);

			trace("    |-- [state:wandering] destination", wanderingDestination);
			trace("    |-- [state:wandering] path", agent.path);

			if (agent.path != null && Point(agent.path[agent.path.length - 1]).equals(wanderingDestination))
			{
				agent.path.pop();
				agent.path.push(agent.coordinate);
				agent.path.push(agent.coordinate);
			}

			agent.isMoving = true;
		}

		/**
		 * Update state of wandering.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("  |-- [state:wandering] agent id", agent.agentId, ": onUpdate");
				updated = true;
			}

			if (agent.isMoving)
			{
				agent.moving();
			}
			else
			{
				trace("    |-- [state:wandering] agent id", agent.agentId, "arrived in destination");
				agent.action.pushState(agent.idleAction);
			}
		}

		/**
		 * Destroy wandering state resources.
		 */
		public function destroy():void
		{
			trace("  |-- [state:wandering] agent id", agent.agentId, ": onExit");

			updated = false;
			agent.dX = 0;
			agent.dY = 0;
			agent.isMoving = false;
			agent.path.splice(0, agent.path.length);
			agent.isFlocking = false;
		}

		/**
		 * Print class name.
		 *
		 * @return class name
		 */
		public function toString():String
		{
			return "sketchproject.modules.states.WanderingState";
		}
	}
}
