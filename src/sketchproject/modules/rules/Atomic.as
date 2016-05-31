package sketchproject.modules.rules
{
	import flash.errors.IllegalOperationError;

	public class Atomic
	{
		private var _priority:uint;
		
		private var _parent:Atomic;
		
		public function Atomic(priority:uint = 0, parent:Atomic = null)
		{
			_priority = priority;
			_parent = parent;
		}
		
		public function get parent():Atomic
		{
			return _parent;
		}

		public function set parent(value:Atomic):void
		{
			_parent = value;
		}

		public function get priority():uint
		{
			return _priority;
		}

		public function set priority(value:uint):void
		{
			_priority = value;
		}
		
		public function rule():Boolean {
			throw new IllegalOperationError("Must override concrete class");
			return true;
		}

	}
}