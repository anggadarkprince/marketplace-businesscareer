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
	 * State to push agent visit factory district and combine with idle state to generate stress and sickness.
	 * 
	 * @author Angga
	 */
	public class WorkingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var factoryCoordinate:Point;
		
		/**
		 * Default constructor of WorkingState.
		 * 
		 * @param agent
		 */
		public function WorkingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "working";
		}
		
		/**
		 * Initialize working state.
		 */
		public function initialize():void
		{
			trace("          |-- [state:working] agent id", agent.agentId, ": onEnter");
			
			updated = false;
			
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(agent.npc+"_walk"));
			agent.baseCharacter.loop = true;
			agent.baseCharacter.play();
			agent.baseCharacter.removeEventListeners();
			
			// fetch random location of factory district
			var index:int = GameUtils.randomFor(Config.factoryCoordinate.length-1);
			factoryCoordinate = new Point();
			factoryCoordinate.x = Config.factoryCoordinate[index].x;
			factoryCoordinate.y = Config.factoryCoordinate[index].y;
			
			// find the way to go there
			agent.destination = agent.coordinate;
			agent.path.splice(0,agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, factoryCoordinate.x, factoryCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(factoryCoordinate);
			
			trace("            |-- [state:working] destination", factoryCoordinate);
			trace("            |-- [state:working] path", agent.path);
			
			agent.isMoving = true;
		}
		
		/**
		 * Update state of working.
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
				trace("            |-- [state:working] agent id", agent.agentId, "arrived in school district");
				agent.alpha = 0.3;
				agent.action.pushState(agent.idleAction);
			}
		}
		
		/**
		 * Destroy working state resources.
		 */
		public function destroy():void
		{
			trace("          |-- [state:working] agent id", agent.agentId, ": onExit");
			
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
			return "sketchproject.modules.states.WorkingState";
		}
	}
}