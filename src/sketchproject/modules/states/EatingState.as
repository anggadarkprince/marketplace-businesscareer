package sketchproject.modules.states
{
	import flash.geom.Point;
	
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.modules.PathFinder;
	import sketchproject.utilities.IsoHelper;
		
	public class EatingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		
		private var shopCoordinate:Point;
		private var isBought:Boolean;
		
		public function EatingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "eating";
		}
		
		public function initialize():void
		{
			//trace(agent.agentId+" : onEnter eating transition execute");
						
			shopCoordinate = new Point();
			
			isBought = false;
			
			if(agent.choice == 1)
			{
				shopCoordinate = WorldManager.instance.listShop[0].districtCoordinate;
			}
			else if(agent.choice == 2)
			{
				shopCoordinate = WorldManager.instance.listShop[1].districtCoordinate;
			}
			else if(agent.choice == 3)
			{
				shopCoordinate = WorldManager.instance.listShop[2].districtCoordinate;
			}
			
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, shopCoordinate.x, shopCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(shopCoordinate);
			trace("agent from "+agent.coordinate+" to "+shopCoordinate+" walk path "+agent.path);
			agent.isMoving = true;
		}
		
		public function update():void
		{
			//trace(agent.agentId+" : onUpdate eating transition execute");
			
			if(agent.isMoving)
			{
				agent.moving();					
			}
			else
			{
				var cartesian:Point = IsoHelper.get2dFromTileCoordinates(shopCoordinate, WorldManager.instance.map.tileHeight);
				var isometric:Point = IsoHelper.twoDToIso(cartesian);
				isometric.x = isometric.x+50;
				
				WorldManager.instance.map.spawnCoin(isometric);
				agent.alpha = 0.3;
				agent.action.pushState(agent.idleAction);
			}
		}
		
		public function destroy():void
		{
			//trace(agent.agentId+" : onExit eating transition execute");
			
			agent.alpha = 1;
		}
		
		public function toString() : String 
		{
			return "sketchproject.modules.states.EatingState";
		}
	}
}