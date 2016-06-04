package sketchproject.modules.states
{
	import flash.geom.Point;
	
	import sketchproject.core.Assets;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.modules.PathFinder;
	import sketchproject.utilities.GameUtils;
	
	/**
	 * Testing state.
	 * 
	 * @author Angga
	 */
	public class FindingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var homeCoordinate:Point;
		private var delay:int = 0;
		
		/**
		 * Default constructor of FindingState.
		 * 
		 * @param agent
		 */
		public function FindingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "finding";
		}
		
		/**
		 * Initialize homeward state.
		 */
		public function initialize():void
		{
			trace(agent.agentId+" : onEnter finding");
			
			updated = false;
						
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

			agent.isMoving = true;
			
			trace("            |-- [state:finding] destination", agent.district, homeCoordinate);
			trace("            |-- [state:finding] path", agent.path);
		}
		
		/**
		 * Update homeward state.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("          |-- [state:finding] agent id", agent.agentId, ": onUpdate");
				updated = true;
			}
			
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
		
		/**
		 * 
		 */
		public function destroy():void
		{
			trace(agent.agentId+" : onExit finding");
			
			agent.alpha = 1;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function toString() : String 
		{
			return "sketchproject.modules.states.FindingState";
		}
	}
}