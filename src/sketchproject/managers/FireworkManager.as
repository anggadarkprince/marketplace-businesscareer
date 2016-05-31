package sketchproject.managers
{
	import com.leebrimelow.starling.StarlingPool;

	import sketchproject.interfaces.IParticle;
	import sketchproject.objects.particle.FireworkParticle;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * Firework particle generator.
	 *
	 * @author Angga
	 */
	public class FireworkManager implements IParticle
	{
		private static var instance:FireworkManager;

		private var pool:StarlingPool;
		private var container:Sprite;

		/**
		 * Default constructor of FireworkParticle.
		 *
		 * @param parent
		 */
		public function FireworkManager(parent:Sprite)
		{
			pool = new StarlingPool(FireworkParticle, 25);
			container = parent;
		}

		/**
		 * Instance firework staticly.
		 *
		 * @param parent
		 * @return
		 */
		public static function getInstance(parent:Sprite):FireworkManager
		{
			if (instance == null)
			{
				instance = new FireworkManager(parent);
			}
			return instance;
		}

		/**
		 * Spawn firework by given location.
		 *
		 * @param x
		 * @param y
		 */
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

		/**
		 * Callback when firework has finish spawned.
		 *
		 * @param event
		 */
		private function onComplete(event:Event):void
		{
			var firestar:FireworkParticle = event.currentTarget as FireworkParticle;
			Starling.juggler.remove(firestar);

			if (pool != null)
			{
				pool.returnSprite(firestar);
			}
		}

		/**
		 * Destroy the all particles and this manager.
		 */
		public function destroy():void
		{
			for (var i:int = 0; i < pool.items.length; i++)
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
