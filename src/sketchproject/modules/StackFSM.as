package sketchproject.modules
{
	import sketchproject.interfaces.IState;

	public class StackFSM 
	{
		public var stackState:Array;
		public var currentState:IState;
		
		public function StackFSM() 
		{
			this.stackState = new Array();
		}
		
		public function update() :void 
		{
			currentState = getCurrentState();
			
			if (currentState != null) 
			{
				currentState.update();
			}
		}
		
		public function popState():IState 
		{
			currentState.destroy();
			var lastState:IState = stackState.pop();
			
			if(getCurrentState() != null)
			{
				currentState = getCurrentState();
				currentState.initialize();
			}		
			
			return lastState;
		}
		
		public function pushState(state:IState) :void 
		{
			if (getCurrentState() != state) 
			{				
				stackState.push(state);
				state.initialize();
			}
		}
		
		public function getCurrentState():IState 
		{
			return stackState.length > 0 ? stackState[stackState.length - 1] : null;
		}
		
		public function checkState(state:IState, remove:Boolean = false):Boolean 
		{
			for (var i:int = 0; i < stackState.length; i++) 
			{
				if (stackState[i] == state) 
				{
					if(remove)
					{
						state.destroy();
						stackState.splice(i,1);
					}
					return true;
				}
			}
			return false;
		}
		
		public function clearState():void 
		{
			for (var i:int = stackState.length-1; i >= 0; i--) 
			{
				stackState.splice(i, 1);
			}
		}
		
		public function logState():void
		{
			trace("\n---------statelist---------");
			for (var i:int = stackState.length-1; i >= 0; i--) 
			{				
				trace(IState(stackState[i]).toString());				
			}
			trace("---------statelist---------\n");
		}
	}

}