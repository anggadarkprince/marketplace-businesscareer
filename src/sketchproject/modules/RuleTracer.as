package sketchproject.modules
{
	import sketchproject.objects.world.Map;

	public class RuleTracer
	{
		private var rule:Rule;
		private var agent:Array;
		private var map:Map;
		
		public function RuleTracer()
		{
			rule = new Rule();
		}
		
		public function initialize(agent:Array, map:Map):void
		{
			this.map = map;
			
			rule.assert("agent(rio)");
			rule.assert("agent(demi)");
			rule.assert("agent(richard)");
			rule.assert("rio(health=40,weapon=magnum)");
			rule.assert("demi(health=50,weapon=m16)");
			rule.assert("richard(health=15)");
			rule.assert("richard(weapon=ak74)");
			
			rule.tracing("(?agent(health>35)(weapon=m16))");
			
		}
		
		public function update():void
		{
			
		}
	}
}