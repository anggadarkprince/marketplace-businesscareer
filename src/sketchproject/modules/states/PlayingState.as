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
	 * State makes agent visit entertainment district.
	 *
	 * @author Angga
	 */
	public class PlayingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var playCoordinate:Point;

		/**
		 * Default constructor of PlayingState.
		 *
		 * @param agent
		 */
		public function PlayingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "playing";
		}

		/**
		 * Initialize new state and preparing destination to visited by agent.
		 */
		public function initialize():void
		{
			trace("          |-- [state:playing] agent id", agent.agentId, ": onEnter");
			
			updated = false;

			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();

			playCoordinate = new Point();
			var index:int = GameUtils.randomFor(100);
			var gameCenterProbability:int;
			var theaterProbability:int;
			var playgroundProbability:int;
			var bookstoreProbability:int;
			var mallProbability:int;

			if (agent.role == Agent.ROLE_STUDENT)
			{
				gameCenterProbability = 20;
				theaterProbability = 20;
				playgroundProbability = 20;
				bookstoreProbability = 25;
				mallProbability = 15;
			}
			else if (agent.role == Agent.ROLE_WORKER)
			{
				gameCenterProbability = 10;
				theaterProbability = 20;
				playgroundProbability = 30;
				bookstoreProbability = 10;
				mallProbability = 30;
			}
			else if (agent.role == Agent.ROLE_TRADER)
			{
				gameCenterProbability = 10;
				theaterProbability = 20;
				playgroundProbability = 20;
				bookstoreProbability = 20;
				mallProbability = 30;
			}

			if (index > (100 - gameCenterProbability))
			{
				index = GameUtils.randomFor(Config.gameCenterCoordinate.length - 1);
				playCoordinate.x = Config.gameCenterCoordinate[index].x;
				playCoordinate.y = Config.gameCenterCoordinate[index].y;
				agent.targetDistrict = "Game Center";
			}
			else if (index > (100 - (gameCenterProbability + theaterProbability)))
			{
				index = GameUtils.randomFor(Config.theaterCoordinate.length - 1);
				playCoordinate.x = Config.theaterCoordinate[index].x;
				playCoordinate.y = Config.theaterCoordinate[index].y;
				agent.targetDistrict = "Theater";
			}
			else if (index > (100 - (gameCenterProbability + theaterProbability + playgroundProbability)))
			{
				index = GameUtils.randomFor(Config.playgroundCoordinate.length - 1);
				playCoordinate.x = Config.playgroundCoordinate[index].x;
				playCoordinate.y = Config.playgroundCoordinate[index].y;
				agent.targetDistrict = "Playground";
			}
			else if (index > (100 - (gameCenterProbability + theaterProbability + playgroundProbability + bookstoreProbability)))
			{
				index = GameUtils.randomFor(Config.bookStoreCoordinate.length - 1);
				playCoordinate.x = Config.bookStoreCoordinate[index].x;
				playCoordinate.y = Config.bookStoreCoordinate[index].y;
				agent.targetDistrict = "Book Store";
			}
			else if (index > (100 - (gameCenterProbability + theaterProbability + playgroundProbability + bookstoreProbability + mallProbability)))
			{
				index = GameUtils.randomFor(Config.mallCoordinate.length - 1);
				playCoordinate.x = Config.mallCoordinate[index].x;
				playCoordinate.y = Config.mallCoordinate[index].y;
				agent.targetDistrict = "Mall";
			}

			agent.destination = agent.coordinate;
			agent.path.splice(0, agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, playCoordinate.x, playCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(playCoordinate);
			agent.isMoving = true;

			agent.stress = GameUtils.randomFor(3);

			trace("            |-- [state:playing] destination", agent.targetDistrict, playCoordinate);
			trace("            |-- [state:playing] path", agent.path);
		}

		/**
		 * Update playing state.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("          |-- [state:playing] agent id", agent.agentId, ": onUpdate to", agent.targetDistrict);
				updated = true;
			}

			if (agent.isMoving)
			{
				agent.moving();
			}
			else
			{
				trace("            |-- [state:playing] agent id", agent.agentId, "arrived in", agent.targetDistrict);
				agent.alpha = 0.3;
				agent.action.pushState(agent.idleAction);
			}
		}

		/**
		 * Destroy playing state resources.
		 */
		public function destroy():void
		{
			trace("          |-- [state:playing] agent id", agent.agentId, ": onExit from", agent.targetDistrict);

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
			return "sketchproject.modules.states.PlayingState";
		}
	}
}
