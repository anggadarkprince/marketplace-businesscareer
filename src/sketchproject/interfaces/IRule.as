package sketchproject.interfaces
{
	import sketchproject.modules.Agent;

	public interface IRule
	{
		function rule(agent:Agent, agentList:Array):Boolean;
	}
}