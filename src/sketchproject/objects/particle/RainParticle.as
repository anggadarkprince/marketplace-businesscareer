package sketchproject.objects.particle
{
	import sketchproject.core.Assets;

	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 * Rain particle object.
	 *
	 * @author Angga
	 */
	public class RainParticle extends Sprite
	{
		public static var LIGHT_RAIN:String = "lightRain";
		public static var HEAVY_RAIN:String = "heavyRain";
		public static var STORM_RAIN:String = "stormRain";

		private var rain:Image;
		private var speed:Number;
		private var wind:Number;
		private var yDest:Number;
		private var type:String;

		/**
		 * Default constructor of RainParticle.
		 */
		public function RainParticle()
		{
			super();

			rain = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("particle_rain"));
			rain.pivotX = rain.width * 0.5;
			rain.pivotY = rain.height * 0.5;
			addChild(rain);
		}

		/**
		 * Set type of rain.
		 *
		 * @param type
		 */
		public function set rainType(type:String):void
		{
			this.type = type;
			if (type == RainParticle.LIGHT_RAIN)
			{
				rain.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("particle_rain");
			}
			else if (type == RainParticle.HEAVY_RAIN)
			{
				rain.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("particle_heavy_rain");
			}
			else
			{
				rain.texture = Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("particle_storm");
			}
			rain.readjustSize();
		}

		/**
		 * Get type of rain.
		 *
		 * @return
		 */
		public function get rainType():String
		{
			return this.type;
		}

		/**
		 * Set speed of rain drop into the ground.
		 *
		 * @param speed
		 */
		public function set dropSpeed(speed:Number):void
		{
			this.speed = speed;
		}

		/**
		 * Get speed of rain drop into the ground.
		 *
		 * @return
		 */
		public function get dropSpeed():Number
		{
			return speed;
		}

		/**
		 * Set speed of wind effecting rain drop.
		 *
		 * @param wind
		 */
		public function set windSpeed(wind:Number):void
		{
			this.wind = wind;
		}

		/**
		 * Get speed of wind affecting rain drop.
		 *
		 * @return
		 */
		public function get windSpeed():Number
		{
			return wind;
		}

		/**
		 * Set y position of rain until reach the bottom before destroyed.
		 *
		 * @param yPos
		 */
		public function set dropPosition(yPos:Number):void
		{
			this.yDest = yPos;
		}

		/**
		 * Get y positon of rain drop.
		 * @return
		 */
		public function get dropPosition():Number
		{
			return yDest;
		}
	}
}
