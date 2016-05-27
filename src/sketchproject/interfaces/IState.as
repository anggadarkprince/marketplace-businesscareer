package sketchproject.interfaces
{
	public interface IState
	{						
		function initialize():void;
		function update():void;
		function destroy():void;
		function toString():String;
	}
}