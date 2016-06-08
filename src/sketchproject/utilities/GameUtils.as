package sketchproject.utilities
{
	import starling.display.MovieClip;
	import starling.textures.Texture;

	/**
	 * Game utility.
	 *
	 * @author Angga
	 */
	public class GameUtils
	{
		/**
		 * Get probability.
		 *
		 * @param value
		 * @return
		 */
		public static function probability(value:Number = Number.MAX_VALUE):Boolean
		{
			if (Math.random() < value)
			{
				return true;
			}
			return false;
		}

		/**
		 * Random number.
		 *
		 * @param value
		 * @param isCeiled
		 * @return
		 */
		public static function randomFor(value:Number, isCeiled:Boolean = true):Number
		{
			var random:Number = Math.random() * value;
			if (isCeiled)
			{
				return Math.ceil(random);
			}
			return random;
		}

		/**
		 * Get distance with pytagoras.
		 *
		 * @param delta_x
		 * @param delta_y
		 * @return
		 */
		public static function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x * delta_x) + (delta_y * delta_y));
		}

		/**
		 * Get radian angle.
		 *
		 * @param delta_x
		 * @param delta_y
		 * @return
		 */
		public static function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);

			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}

		/**
		 * Convert radiant to degree.
		 *
		 * @param radians
		 * @return
		 */
		public static function getDegrees(radians:Number):Number
		{
			return Math.floor(radians / (Math.PI / 180));
		}

		/**
		 * Swap texture animation for agent.
		 *
		 * @param animation
		 * @param textures
		 */
		public static function swapTextureFrame(animation:MovieClip, textures:Vector.<Texture>):void
		{
			while (animation.numFrames > 1)
			{
				animation.removeFrameAt(0);
			}
			for each (var texture:Texture in textures)
			{
				animation.addFrame(texture);
			}
			if (animation.numFrames != 1)
			{
				animation.removeFrameAt(0);
			}
			animation.stop();
			animation.readjustSize();
		}

		/**
		 * Logging message.
		 *
		 * @param message
		 */
		public static function log(message:*):void
		{
			trace("---------------------------\n", message, "\n---------------------------\n");
		}
	}
}
