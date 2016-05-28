package sketchproject.interfaces
{

	/**
	 * State contract to manage FSM for game screen and SFSM for agent behavior.
	 * 
	 * @author Angga
	 */
	public interface IState
	{
		function initialize():void;
		function update():void;
		function destroy():void;
		function toString():String;
	}
}
