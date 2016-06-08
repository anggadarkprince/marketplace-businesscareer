package sketchproject.modules.states
{
	import sketchproject.core.Assets;
	import sketchproject.interfaces.IState;
	import sketchproject.modules.Agent;
	import sketchproject.utilities.GameUtils;
	
	import starling.events.Event;
	
	/**
	 * Influencing people nearest distance.
	 * 
	 * @author Angga
	 */
	public class InfluenceState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		
		/**
		 * Default constructor of InfluenceState.
		 * 
		 * @param agent
		 */
		public function InfluenceState(agent:Agent)
		{
			this.agent = agent;
			this.name = "influencing";
		}
		
		/**
		 * Initializing influence state
		 */
		public function initialize():void
		{
			trace("    |-- [state:influencing] agent id", agent.agentId, ": onEnter");
			
			updated = false;
			
			GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_tada"));
			agent.baseCharacter.play();
			agent.baseCharacter.loop = false;
			agent.baseCharacter.addEventListener(Event.COMPLETE, function(event:Event):void{				
				agent.baseCharacter.removeEventListeners();
				GameUtils.swapTextureFrame(agent.baseCharacter, Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(agent.npc + "_walk"));
				agent.baseCharacter.play();
				agent.baseCharacter.loop = true;
				agent.action.checkState(agent.influenceAction, true);
			});		
			agent.perceptReaction("influence");
		}
		
		/**
		 * Update state of influence.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("    |-- [state:influencing] agent id", agent.agentId, ": onUpdate");
				updated = true;
			}
		}
		
		/**
		 * Destroy influence state resources.
		 */
		public function destroy():void
		{
			trace("    |-- [state:influencing] agent id", agent.agentId, ": onExit");
			
			updated = false;
			agent.perceptReaction("none");
			agent.isInfluencing = false;
		}
		
		/**
		 * Print class name.
		 * 
		 * @return 
		 */
		public function toString():String
		{
			return "sketchproject.modules.states.InfluenceState";
		}
	}
}