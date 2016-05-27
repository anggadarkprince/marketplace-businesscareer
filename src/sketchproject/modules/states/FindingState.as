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
	
	public class FindingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var homeCoordinate:Point;
		private var delay:int = 0;
		public function FindingState(agent:Agent)
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

			homeCoordinate.x = 8;
			homeCoordinate.y = 12;
			
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, homeCoordinate.x, homeCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(homeCoordinate);
			trace("generate path ",agent.path);
			agent.isMoving = true;
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate homeward transition execute");
			
			if(delay++ > 200){
				if(agent.isMoving)
				{
					agent.moving();					
				}
				else
				{
					agent.action.pushState(agent.idleAction);
				}
			}
		}
		
		public function destroy():void
		{
			trace(agent.agentId+" : onExit homeward transition execute");
			
			agent.alpha = 1;
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.HomewardState";
		}
	}
}