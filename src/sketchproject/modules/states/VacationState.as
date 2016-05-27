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
	
	public class VacationState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var vacationCoordinate:Point;
		
		public function VacationState(agent:Agent)
		{
			this.agent = agent;
			this.name = "vacation";
		}
		
		public function initialize():void
		{
			//trace(agent.agentId+" : onEnter vacation transition execute");
						
			agent.dX = 0;
			agent.dY = 0;
			agent.isMoving = false;	
			
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			
			vacationCoordinate = new Point();
			var index:int = GameUtils.randomFor(100);
			var beachProbability:int;
			var wonderlandProbability:int;
			
			if(agent.role == "student")
			{
				beachProbability = 40;
				wonderlandProbability = 60;
			}
			else if(agent.role == "worker")
			{
				beachProbability = 50;
				wonderlandProbability = 50;
			}
			else if(agent.role == "trader")
			{
				beachProbability = 60;
				wonderlandProbability = 40;
			}
			
			if(index > (100-beachProbability))
			{
				index = GameUtils.randomFor(Config.beachCoordinate.length-1);
				vacationCoordinate.x = Config.beachCoordinate[index].x;
				vacationCoordinate.y = Config.beachCoordinate[index].y;
			}
			else
			{
				index = GameUtils.randomFor(Config.wonderlandCoordinate.length-1);
				vacationCoordinate.x = Config.wonderlandCoordinate[index].x;
				vacationCoordinate.y = Config.wonderlandCoordinate[index].y;
			}
			
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, vacationCoordinate.x, vacationCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(vacationCoordinate);
			//trace("agent from "+agent.coordinate+" to "+vacationCoordinate+" walk path "+agent.path);
			agent.isMoving = true;
			
			agent.stress = GameUtils.randomFor(4);
			agent.emotion = GameUtils.randomFor(3) + 7;
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate vacation transition execute");
			
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
			//trace(agent.agentId+" : onExit vacation transition execute");
				
			agent.alpha = 1;
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.VacationState";
		}
		
	}
}