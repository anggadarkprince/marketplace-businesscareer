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
	
	public class PlayingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var playCoordinate:Point;
		
		public function PlayingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "playing";
		}
		
		public function initialize():void
		{
			//trace(agent.agentId+" : onEnter playing transition execute");
						
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_walk"));
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
			
			if(agent.role == "student")
			{
				gameCenterProbability = 25;
				theaterProbability = 20;
				playgroundProbability = 20;
				bookstoreProbability = 20;
				mallProbability = 15;
			}
			else if(agent.role == "worker")
			{
				gameCenterProbability = 10;
				theaterProbability = 20;
				playgroundProbability = 30;
				bookstoreProbability = 10;
				mallProbability = 30;
			}
			else if(agent.role == "trader")
			{
				gameCenterProbability = 10;
				theaterProbability = 20;
				playgroundProbability = 20;
				bookstoreProbability = 20;
				mallProbability = 30;
			}
			
			if(index > (100-gameCenterProbability))
			{
				index = GameUtils.randomFor(Config.gameCenterCoordinate.length-1);
				playCoordinate.x = Config.gameCenterCoordinate[index].x;
				playCoordinate.y = Config.gameCenterCoordinate[index].y;
			}
			else if(index > (100-(gameCenterProbability+theaterProbability)))
			{
				index = GameUtils.randomFor(Config.theaterCoordinate.length-1);
				playCoordinate.x = Config.theaterCoordinate[index].x;
				playCoordinate.y = Config.theaterCoordinate[index].y;
			}
			else if(index > (100-(gameCenterProbability+theaterProbability+playgroundProbability)))
			{
				index = GameUtils.randomFor(Config.playgroundCoordinate.length-1);
				playCoordinate.x = Config.playgroundCoordinate[index].x;
				playCoordinate.y = Config.playgroundCoordinate[index].y;
			}
			else if(index > (100-(gameCenterProbability+theaterProbability+playgroundProbability+bookstoreProbability)))
			{
				index = GameUtils.randomFor(Config.bookStoreCoordinate.length-1);
				playCoordinate.x = Config.bookStoreCoordinate[index].x;
				playCoordinate.y = Config.bookStoreCoordinate[index].y;
			}
			else if(index > (100-(gameCenterProbability+theaterProbability+playgroundProbability+bookstoreProbability+mallProbability)))
			{
				index = GameUtils.randomFor(Config.mallCoordinate.length-1);
				playCoordinate.x = Config.mallCoordinate[index].x;
				playCoordinate.y = Config.mallCoordinate[index].y;
			}
			
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, playCoordinate.x, playCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(playCoordinate);
			//trace("agent from "+agent.coordinate+" to "+playCoordinate+" walk path "+agent.path);
			agent.isMoving = true;
			
			agent.stress = GameUtils.randomFor(3);
			agent.emotion = GameUtils.randomFor(5) + 5;
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate playing transition execute");
			
			if(agent.isMoving)
			{
				agent.moving();					
			}
			else
			{
				agent.alpha = 0.3;
				agent.action.pushState(agent.idleAction);
			}
		}
		
		public function destroy():void
		{
			//trace(agent.agentId+" : onExit playing transition execute");
			
			//agent.alpha = 1;
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.PlayingState";
		}
	}
}