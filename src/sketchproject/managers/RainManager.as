package sketchproject.managers
{
	import com.leebrimelow.starling.StarlingPool;

	import sketchproject.interfaces.IParticle;
	import sketchproject.objects.particle.RainParticle;

	import starling.core.Starling;
	import starling.display.Sprite;

	/**
	 * Rain particle controller.
	 *
	 * @author Angga
	 */
	public class RainManager implements IParticle
	{
		/**
		 * width of rain will be spawned.
		 *
		 * @default
		 */
		public var spawnWidth:int;

		/**
		 * height of rain will be spawned
		 * @default
		 */
		public var spawnHeight:int;

		private var rainContainer:Sprite;
		private var rainPool:StarlingPool;
		private var rains:Array;
		private var rain:RainParticle;
		private var rainType:String;
		private var generate:Number;

		/**
		 * Default constructor of RainManager.
		 * 
		 * @param rainContainer
		 * @param rainType
		 */
		public function RainManager(rainContainer:Sprite, rainType:String)
		{
			this.rainContainer = rainContainer;
			this.rainType = rainType;
			rains = new Array();
			rainPool = new StarlingPool(RainParticle, 200);

			spawnWidth = Starling.current.stage.stageWidth;
			spawnHeight = Starling.current.stage.stageHeight;

			for (var i:int = 0; i < rainPool.items.length; i++)
			{
				RainParticle(rainPool.items[i]).rainType = rainType;
			}
		}

		/**
		 * Update drop rain, gives different space each particle type.
		 */
		public function update():void
		{
			generate = Math.random();
			if (generate < 0.4 && rainType == RainParticle.LIGHT_RAIN)
			{
				spawn(Math.random() * spawnWidth, 0 - Math.random() * 300);
			}
			else if (generate < 0.6 && rainType == RainParticle.HEAVY_RAIN)
			{
				spawn(Math.random() * spawnWidth, 0 - Math.random() * 300);
			}
			else if (rainType == RainParticle.STORM_RAIN)
			{
				spawn(Math.random() * spawnWidth, 0 - Math.random() * 300);
			}

			for (var i:int = rains.length - 1; i > 0; i--)
			{
				rain = rains[i] as RainParticle;
				rain.y += rain.dropSpeed;
				rain.x -= rain.windSpeed;

				if (rain.y > rain.dropPosition)
				{
					destroyRain(rain);
				}
			}
		}

		/**
		 * Spawn new rain at the top, generate variation of size and speed.
		 *
		 * @param x spawn position
		 * @param y spawn position
		 */
		public function spawn(x:int, y:int):void
		{
			var rain:RainParticle = rainPool.getSprite() as RainParticle;

			if (rain.rainType == RainParticle.LIGHT_RAIN)
			{
				rain.dropSpeed = Math.random() + 8;
				rain.windSpeed = Math.random();
				rain.scaleX = (Math.random() * 1 + 9) / 10;
				rain.scaleY = (Math.random() * 1 + 9) / 10;
				rain.alpha = (Math.random() * 4 + 7) / 10;
			}
			else if (rain.rainType == RainParticle.HEAVY_RAIN)
			{
				rain.dropSpeed = Math.random() + 12;
				rain.windSpeed = Math.random() + 1;
				rain.scaleX = (Math.random() * 2 + 8) / 10;
				rain.scaleY = (Math.random() * 2 + 8) / 10;
				rain.alpha = (Math.random() * 2 + 8) / 10;
			}
			else
			{
				rain.dropSpeed = Math.random() + 13;
				rain.windSpeed = Math.random() * 2;
				rain.scaleX = (Math.random() * 3 + 7) / 10;
				rain.scaleY = (Math.random() * 3 + 7) / 10;
			}
			rain.dropPosition = y + spawnHeight;

			rains.push(rain);
			rain.x = x;
			rain.y = y;
			rainContainer.addChild(rain);
		}

		/**
		 * Destroy single rain particle. and return into Starling object pooling.
		 *
		 * @params rain particle to be destroyed when condition meets
		 * @return void
		 */
		private function destroyRain(rain:RainParticle):void
		{
			for (var i:int = rains.length - 1; i >= 0; i--)
			{
				if (rain == rains[i])
				{
					rains.splice(i, 1);
					rain.removeFromParent(true);
					rainPool.returnSprite(rain);
				}
			}
		}

		/**
		 * Destroy all rains and this manager.
		 *
		 * @return void
		 */
		public function destroy():void
		{
			for (var i:int = rains.length - 1; i >= 0; i--)
			{
				destroyRain(RainParticle(rains[i]));
			}
			rainPool.destroy();
			rainPool = null;
			rains = null;
		}
	}
}
