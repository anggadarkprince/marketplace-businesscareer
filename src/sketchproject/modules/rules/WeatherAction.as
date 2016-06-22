package sketchproject.modules.rules
{
	import sketchproject.modules.Agent;

	public class WeatherAction extends Atomic
	{
		public function WeatherAction(priority:uint=0, parent:Atomic=null)
		{
			super(priority, parent);
		}
		
		public override function rule(agent:Agent, agentList:Array):Boolean
		{
			return true;
		}
	}
}