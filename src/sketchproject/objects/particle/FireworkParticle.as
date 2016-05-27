package sketchproject.objects.particle
{
	import sketchproject.core.Assets;
	
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class FireworkParticle extends PDParticleSystem
	{
		public function FireworkParticle()
		{
			super(XML(new Assets.ParticleFireworksXML()), Assets.getTexture("ParticleFireworks"));
		}
	}
}