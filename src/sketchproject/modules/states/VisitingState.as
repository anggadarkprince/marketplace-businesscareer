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
	 * State makes agent visit districts.
	 *
	 * @author Angga
	 */
	public class VisitingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var targetVisit:Point;

		/**
		 * Default constructor of VisitingState.
		 *
		 * @param agent
		 */
		public function VisitingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "visiting";
		}

		/**
		 * Initialize new state and preparing destination to visited by agent.
		 */
		public function initialize():void
		{
			trace("          |-- [state:visiting] agent id", agent.agentId, ": onEnter");

			updated = false;

			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();

			// fetch random location of target district
			targetVisit = new Point();
			for (var i:uint = 0; i < Config.districtCollection.length; i++)
			{
				var district:Object = Config.districtCollection[i];
				if (district.name == agent.targetDistrict)
				{
					var index:int = GameUtils.randomFor(district.location.length) - 1;
					targetVisit.x = district.location[index].x;
					targetVisit.y = district.location[index].y;
					break;
				}
			}

			agent.destination = agent.coordinate;
			agent.path.splice(0, agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, targetVisit.x, targetVisit.y, WorldManager.instance.map.levelData);
			agent.path.unshift(targetVisit);

			trace("            |-- [state:visiting] destination", agent.targetDistrict, targetVisit);
			trace("            |-- [state:visiting] path", agent.path);

			agent.isMoving = true;
		}

		/**
		 * Updating agent position to visit district.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("          |-- [state:visiting] agent id", agent.agentId, ": onUpdate");
				updated = true;
			}

			if (agent.isMoving)
			{
				agent.moving();
			}
			else
			{
				trace("            |-- [state:visiting] agent id", agent.agentId, "arrived in", agent.targetDistrict);
				agent.alpha = 0.3;
				agent.action.pushState(agent.idleAction);
			}
		}

		/**
		 * Destroy visiting state resources.
		 */
		public function destroy():void
		{
			trace("          |-- [state:working] agent id", agent.agentId, ": onExit");

			agent.targetDistrict = "";
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
			return "sketchproject.modules.states.VisitState";
		}
	}
}
