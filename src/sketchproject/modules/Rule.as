package sketchproject.modules
{
	public class Rule
	{
		public var database:Array;
		
		public function Rule()
		{
			database = new Array();
		}
		
		public function assert(fact:String):void
		{
			var subject:String = "";
			var value:Array;
			
			for(var i:int = 0; i<fact.length; i++)
			{
				if(fact.charAt(i) == "(")
				{
					value = fact.substring(i+1,fact.length-1).split(",");
					break;
				}
				subject = subject.concat(fact.charAt(i));
			}
						
			for(i = 0; i<value.length; i++)
			{
				if(database[subject] == null)
				{
					database[subject] = new Array(value[i]);
				}
				else
				{
					database[subject].push(value[i]);
				}				
			}
			
			trace("antecendant",subject,value);
		}
		
		public function tracing(wildcard:String):void
		{
			for(var i:int = 0; i<wildcard.length; i++)
			{
				
			}
		}
	}
}