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
	
	public class TradingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var bcdCoordinate:Point;
		
		public function TradingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "trading";
		}
		
		public function initialize():void
		{
			//trace(agent.agentId+" : onEnter trading transition execute");
			
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			
			var index:int = GameUtils.randomFor(Config.timesSquareCoordinate.length-1);
			bcdCoordinate = new Point();
			bcdCoordinate.x = Config.timesSquareCoordinate[index].x;
			bcdCoordinate.y = Config.timesSquareCoordinate[index].y;
			
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, bcdCoordinate.x, bcdCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(bcdCoordinate);
			
			agent.isMoving = true;
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate trading transition execute");
			
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
			//trace(agent.agentId+" : onExit trading transition execute");
			agent.mainRoleDone = true;
			agent.alpha = 1;
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.TradingState";
		}
	}
}