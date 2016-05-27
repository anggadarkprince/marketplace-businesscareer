package sketchproject.managers
{
	import com.leebrimelow.starling.StarlingPool;
	
	import sketchproject.interfaces.IParticle;
	import sketchproject.objects.particle.FireworkParticle;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class FireworkParticleManager implements IParticle
	{
		private static var instance:FireworkParticleManager;
		
		private var pool:StarlingPool;
		private var container:Sprite;
		
		public function FireworkParticleManager(parent:Sprite) {
			pool = new StarlingPool(FireworkParticle, 25);
			container = parent;
		}
		
		public static function getInstance(parent:Sprite):FireworkParticleManager {
			if(instance == null){
				instance = new FireworkParticleManager(parent);
			}
			return instance;
		}
		
		public function spawn(x:int, y:int):void
		{
			var firestar:FireworkParticle = pool.getSprite() as FireworkParticle;
			firestar.emitterX = x;
			firestar.emitterY = y;
			firestar.start(0.1);
			container.addChild(firestar);
			Starling.juggler.add(firestar);
			firestar.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(event:Event):void
		{
			var firestar:FireworkParticle = event.currentTarget as FireworkParticle;
			Starling.juggler.remove(firestar);
			
			if(pool != null)
				pool.returnSprite(firestar);
		}
		
		public function destroy():void
		{
			for(var i:int=0; i<pool.items.length; i++)
			{
				var firestar:FireworkParticle = pool.items[i];
				firestar.dispose();
				firestar = null;
			}
			pool.destroy();
			pool = null;
		}
	}
}