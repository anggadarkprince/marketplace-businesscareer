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
	
	public class WorkingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var factoryCoordinate:Point;
		
		public function WorkingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "working";
		}
		
		public function initialize():void
		{
			//trace(agent.agentId+" : onEnter working transition execute");
			
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			
			var index:int = GameUtils.randomFor(Config.factoryCoordinate.length-1);
			factoryCoordinate = new Point();
			factoryCoordinate.x = Config.factoryCoordinate[index].x;
			factoryCoordinate.y = Config.factoryCoordinate[index].y;
			
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, factoryCoordinate.x, factoryCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(factoryCoordinate);
			
			agent.isMoving = true;
			agent.alpha = 1;
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate working transition execute");
			
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
			//trace(agent.agentId+" : onExit working transition execute");
			agent.mainRoleDone = true;
			agent.alpha = 1;
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.WorkingState";
		}
	}
}