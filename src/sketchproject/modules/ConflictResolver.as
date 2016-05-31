package sketchproject.modules
{
	public class ConflictResolver
	{
		public function ConflictResolver()
		{
		}
		
		public function resolveDuplicate():Boolean{
			return false;
		}
		
		public function comparePriority(ruleFirst:Function, ruleAfter:Function):int{
			return 0;	
		}
		
		public function compareRandom(probability:Number):int{
			return 0;
		}
	}
}