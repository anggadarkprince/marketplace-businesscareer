package sketchproject.modules
{
	import sketchproject.interfaces.IState;

	/**
	 * Brain controller of agent.
	 *
	 * @author Angga
	 */
	public class StackFSM
	{
		public var stackState:Array;
		public var currentState:IState;

		/**
		 * Default contructor of StackFSM
		 */
		public function StackFSM()
		{
			this.stackState = new Array();
		}

		/**
		 * Updating current state.
		 */
		public function update():void
		{
			currentState = getCurrentState();

			if (currentState != null)
			{
				currentState.update();
			}
		}

		/**
		 * Remove last inserted state / pop current state.
		 *
		 * @return removed state
		 */
		public function popState():IState
		{
			currentState.destroy();
			var lastState:IState = stackState.pop();

			if (getCurrentState() != null)
			{
				currentState = getCurrentState();
				currentState.initialize();
			}

			return lastState;
		}

		/**
		 * Insert new state and initialize immediately.
		 *
		 * @param state new action
		 */
		public function pushState(state:IState):void
		{
			if (getCurrentState() != state)
			{
				if (getCurrentState().toString() == "sketchproject.modules.states.EatingState")
				{
					stackState.splice(stackState.length - 1, 0, state);
				}
				else
				{
					stackState.push(state);
					state.initialize();
				}
			}
		}

		/**
		 * Retrieve current state.
		 *
		 * @return current state
		 */
		public function getCurrentState():IState
		{
			return stackState.length > 0 ? stackState[stackState.length - 1] : null;
		}

		/**
		 * Check if state is given exist and give an option to remove it.
		 *
		 * @param state that will be find
		 * @param remove option if want to destroy
		 * @return status if state is found
		 */
		public function checkState(state:IState, remove:Boolean = false):Boolean
		{
			for (var i:int = 0; i < stackState.length; i++)
			{
				if (stackState[i] == state)
				{
					if (remove)
					{
						state.destroy();
						stackState.splice(i, 1);
					}
					return true;
				}
			}
			return false;
		}

		/**
		 * Remove all states.
		 */
		public function clearState():void
		{
			for (var i:int = stackState.length - 1; i >= 0; i--)
			{
				stackState.splice(i, 1);
			}
		}

		/**
		 * Print current state list of agent.
		 */
		public function logState():void
		{
			trace("\n---------statelist---------");
			for (var i:int = stackState.length - 1; i >= 0; i--)
			{
				trace(IState(stackState[i]).toString());
			}
			trace("---------statelist---------\n");
		}
	}

}
