package sketchproject.modules.states
{
	import flash.geom.Point;
	
	import sketchproject.core.Assets;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.modules.PathFinder;
	import sketchproject.utilities.GameUtils;
	
	public class WanderingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var delayTillGenerate:uint;
		private var delayTaken:uint;		
		private var wanderingDestination:Point;
				
		public function WanderingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "wandering";
			
			this.delayTaken = 0;
		}
		
		public function initialize():void
		{
			//trace(agent.agentId+" : onEnter wandering transition execute");
					
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			
			this.delayTillGenerate = 200 + GameUtils.randomFor(600);
			
			agent.isFirstStep = true;	
			
			agent.baseCharacter.loop = true;
			
			wanderingDestination = WorldManager.instance.map.generateWalkableCoordinate();
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, wanderingDestination.x, wanderingDestination.y, WorldManager.instance.map.levelData);
			agent.path.unshift(wanderingDestination);
			
			if(agent.path != null && Point(agent.path[agent.path.length-1]).equals(wanderingDestination))
			{
				agent.path.pop();
				agent.path.push(agent.coordinate);
				agent.path.push(agent.coordinate);
			}
			
			//trace("agent from "+agent.coordinate+" to "+wanderingDestination+" walk path "+agent.path);
			
			agent.isMoving = true;
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate wandering transition execute");
			
			if(agent.isMoving)
			{				
				agent.moving();					
			}
			else
			{				
				agent.action.pushState(agent.idleAction);
				
				this.delayTaken++;
				if(this.delayTaken == this.delayTillGenerate)
				{					
					//trace("find new destination");
					this.delayTaken = 0;
					initialize();
				}
			}
			
		}
			
		
		public function destroy():void
		{
			//trace(agent.agentId+" : onExit wandering transition execute");
			delayTaken = 0;
			agent.dX = 0;
			agent.dY = 0;
			agent.isMoving = false;			
			agent.path.splice(0,agent.path.length);
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.WanderingState";
		}
				
	}
}