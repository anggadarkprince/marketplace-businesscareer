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
	
	public class VisitingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var targetVisit:Point;

		public function VisitingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "visiting";
		}
		
		public function initialize():void
		{
			//trace(agent.agentId+" : onEnter studying transition execute");
			
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			
			targetVisit = new Point();
			var index:int;
			if(agent.targetDistrict == "Sport Center"){
				index = GameUtils.randomFor(Config.sportCenterCoordinate.length-1);				
				targetVisit.x = Config.sportCenterCoordinate[index].x;
				targetVisit.y = Config.sportCenterCoordinate[index].y;
			}
			if(agent.targetDistrict == "Town Hall"){
				index = GameUtils.randomFor(Config.townHallCoordinate.length-1);				
				targetVisit.x = Config.townHallCoordinate[index].x;
				targetVisit.y = Config.townHallCoordinate[index].y;
			}
			if(agent.targetDistrict == "Factory"){
				index = GameUtils.randomFor(Config.factoryCoordinate.length-1);				
				targetVisit.x = Config.factoryCoordinate[index].x;
				targetVisit.y = Config.factoryCoordinate[index].y;
			}
			if(agent.targetDistrict == "Playground"){
				index = GameUtils.randomFor(Config.playgroundCoordinate.length-1);				
				targetVisit.x = Config.playgroundCoordinate[index].x;
				targetVisit.y = Config.playgroundCoordinate[index].y;
			}
			if(agent.targetDistrict == "Green Ville"){
				index = GameUtils.randomFor(Config.murbawismaCoordinate.length-1);				
				targetVisit.x = Config.murbawismaCoordinate[index].x;
				targetVisit.y = Config.murbawismaCoordinate[index].y;
			}
			if(agent.targetDistrict == "Wonderland"){
				index = GameUtils.randomFor(Config.wonderlandCoordinate.length-1);				
				targetVisit.x = Config.wonderlandCoordinate[index].x;
				targetVisit.y = Config.wonderlandCoordinate[index].y;				
			}
			if(agent.targetDistrict == "School Center"){
				index = GameUtils.randomFor(Config.schoolCoordinate.length-1);				
				targetVisit.x = Config.schoolCoordinate[index].x;
				targetVisit.y = Config.schoolCoordinate[index].y;
			}
			if(agent.targetDistrict == "Times Square"){
				index = GameUtils.randomFor(Config.timesSquareCoordinate.length-1);				
				targetVisit.x = Config.timesSquareCoordinate[index].x;
				targetVisit.y = Config.timesSquareCoordinate[index].y;
			}
			if(agent.targetDistrict == "Airport"){
				index = GameUtils.randomFor(Config.airportCoordinate.length-1);				
				targetVisit.x = Config.airportCoordinate[index].x;
				targetVisit.y = Config.airportCoordinate[index].y;
			}
			if(agent.targetDistrict == "Horizon Bay"){
				index = GameUtils.randomFor(Config.beachCoordinate.length-1);				
				targetVisit.x = Config.beachCoordinate[index].x;
				targetVisit.y = Config.beachCoordinate[index].y;
			}
			if(agent.targetDistrict == "Hospital"){
				index = GameUtils.randomFor(Config.hospitalCoordinate.length-1);				
				targetVisit.x = Config.hospitalCoordinate[index].x;
				targetVisit.y = Config.hospitalCoordinate[index].y;
			}
						
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, targetVisit.x, targetVisit.y, WorldManager.instance.map.levelData);
			agent.path.unshift(targetVisit);
			
			agent.isMoving = true;
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate studying transition execute");
			
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
			//trace(agent.agentId+" : onExit visiting transition execute");		
			agent.targetDistrict = "";
			agent.alpha = 1;
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.VisitState";
		}
	}
}