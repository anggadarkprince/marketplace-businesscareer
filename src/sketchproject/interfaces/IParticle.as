package sketchproject.interfaces
{

	/**
	 * Particle contract to spawning and detroying.
	 * 
	 * @author Angga
	 */
	public interface IParticle
	{
		function spawn(x:int, y:int):void;
		function destroy():void;
	}
}
