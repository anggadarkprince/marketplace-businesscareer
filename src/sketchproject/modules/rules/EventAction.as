package sketchproject.modules.rules
{
	import sketchproject.modules.Agent;

	public class EventAction extends Atomic
	{
		public function EventAction(priority:uint=0, parent:Atomic=null)
		{
			super(priority, parent);
		}
		
		public override function rule(agent:Agent, agentList:Array):Boolean
		{
			return true;
		}
	}
}