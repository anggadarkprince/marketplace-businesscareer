package sketchproject.objects.particle
{
	import sketchproject.core.Assets;

	import starling.extensions.PDParticleSystem;

	/**
	 * Firework particle texture.
	 * 
	 * @author Angga
	 */
	public class FireworkParticle extends PDParticleSystem
	{
		/**
		 * Default constructor of FireworkParticle.
		 */
		public function FireworkParticle()
		{
			super(XML(new Assets.ParticleFireworksXML()), Assets.getTexture("ParticleFireworks"));
		}
	}
}
