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
	
	public class HomewardState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var homeCoordinate:Point;
		
		public function HomewardState(agent:Agent)
		{
			this.agent = agent;
			this.name = "homeward";
		}
		
		public function initialize():void
		{
			//trace(agent.agentId+" : onEnter homeward transition execute");
						
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			
			homeCoordinate = new Point();
			var index:int;
			
			if(agent.district == "village")
			{
				index = GameUtils.randomFor(Config.villageCoordinate.length-1);
				homeCoordinate.x = Config.villageCoordinate[index].x;
				homeCoordinate.y = Config.villageCoordinate[index].y;
			}
			else if(agent.district == "murbawisma")
			{
				index = GameUtils.randomFor(Config.murbawismaCoordinate.length-1);
				homeCoordinate.x = Config.murbawismaCoordinate[index].x;
				homeCoordinate.y = Config.murbawismaCoordinate[index].y;
			}
			else if(agent.district == "madyawisma")
			{
				index = GameUtils.randomFor(Config.murbawismaCoordinate.length-1);
				homeCoordinate.x = Config.murbawismaCoordinate[index].x;
				homeCoordinate.y = Config.murbawismaCoordinate[index].y;
			}
			else if(agent.district == "adiwisma")
			{
				index = GameUtils.randomFor(Config.adiwismaCoordinate.length-1);
				homeCoordinate.x = Config.adiwismaCoordinate[index].x;
				homeCoordinate.y = Config.adiwismaCoordinate[index].y;
			}
			
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, homeCoordinate.x, homeCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(homeCoordinate);
			
			agent.isMoving = true;
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate homeward transition execute");
			
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
			//trace(agent.agentId+" : onExit homeward transition execute");
			
			agent.alpha = 1;
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.HomewardState";
		}
	}
}