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
	 * State to push agent visit business district and combine with idle state to generate stress and sickness.
	 * 
	 * @author Angga
	 */
	public class TradingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var bcdCoordinate:Point;
		
		/**
		 * Default constructor of TradingState.
		 * 
		 * @param agent
		 */
		public function TradingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "trading";
		}
		
		/**
		 * Initialize trading state.
		 */
		public function initialize():void
		{
			trace("          |-- [state:trading] agent id", agent.agentId, ": onEnter");
			
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			
			// fetch random location of factory district
			var index:int = GameUtils.randomFor(Config.timesSquareCoordinate.length-1);
			bcdCoordinate = new Point();
			bcdCoordinate.x = Config.timesSquareCoordinate[index].x;
			bcdCoordinate.y = Config.timesSquareCoordinate[index].y;
			
			// find the way to go there
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, bcdCoordinate.x, bcdCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(bcdCoordinate);
			
			trace("            |-- [state:trading] destination", bcdCoordinate);
			trace("            |-- [state:trading] path", agent.path);
			
			agent.isMoving = true;
		}
		
		/**
		 * Update state of trading.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("          |-- [state:working] agent id", agent.agentId, ": onUpdate");
				updated = true;
			}
			
			if(agent.isMoving)
			{
				agent.moving();					
			}
			else
			{
				trace("            |-- [state:working] agent id", agent.agentId, "arrived in business center district");
				agent.alpha = 0.3;
				agent.action.pushState(agent.idleAction);
			}
		}
		
		/**
		 * Destroy working state resources.
		 */
		public function destroy():void
		{
			trace("          |-- [state:trading] agent id", agent.agentId, ": onExit");
			
			agent.mainRoleDone = true;
			agent.alpha = 1;
			updated = false;
		}
		
		/**
		 * Print class name.
		 * 
		 * @return 
		 */
		public function toString() : String 
		{
			return "sketchproject.modules.states.TradingState";
		}
	}
}