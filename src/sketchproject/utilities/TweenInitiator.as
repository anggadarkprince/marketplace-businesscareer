package sketchproject.utilities
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import starling.display.DisplayObject;
	import starling.utils.deg2rad;

	/**
	 * Tween for game world overlay.
	 *
	 * @author Angga
	 */
	public class TweenInitiator
	{
		/**
		 * Default constructor.
		 */
		public function TweenInitiator()
		{
		}

		/**
		 * Bouncing sprite animation.
		 *
		 * @param avatar over the shop
		 * @param xPos positon of avatar
		 * @param yPos position of avatar
		 */
		public static function spriteBounce(avatar:DisplayObject, xPos:int, yPos:int):void
		{
			TweenMax.to(avatar, 1, {repeat: -1, x: xPos, y: yPos - 10, yoyo: true});
		}

		/**
		 * Make helicopter moving aroung game world.
		 * @param helicopter
		 */
		public static function helicopterAnimate(helicopter:DisplayObject):void
		{
			TweenMax.to(helicopter, 20, {repeat: 10, x: -1400, y: 1600, yoyo: false, delay: 5});
		}

		/**
		 * Moving around 60x ballon air in game world.
		 *
		 * @param ballonAir
		 */
		public static function ballonAirAnimate(ballonAir:DisplayObject):void
		{
			TweenMax.to(ballonAir, 60, {repeat: 10, x: -1200, y: 100, yoyo: false, delay: 2});
		}

		/**
		 * Landing the plane 15x in airport by steps.
		 *
		 * @param landingPlane
		 */
		public static function planeLandingAnimate(landingPlane:DisplayObject):void
		{
			// enter into map
			TweenMax.to(landingPlane, 15, {ease: Linear.easeOut, x: -200, y: 500, scaleX: 0.9, scaleY: 0.9, onComplete: function():void
			{
				// prepare landing
				TweenMax.to(landingPlane, 5, {ease: Linear.easeIn, x: -720, y: 505, rotation: deg2rad(10), scaleX: 0.6, scaleY: 0.6, onComplete: function():void
				{
					// landing and breaking
					TweenMax.to(landingPlane, 5, {x: -780, y: 485, rotation: deg2rad(-4), onComplete: function():void
					{
						// delay, move and prepare to take off
						TweenMax.to(landingPlane, 2, {delay: 15, ease: Linear.easeIn, x: -825, y: 460, rotation: deg2rad(5), onComplete: function():void
						{
							// take off and fly away
							TweenMax.to(landingPlane, 15, {ease: Linear.easeIn, x: -1600, y: -300, scaleX: 1, scaleY: 1});
						}});
					}});
				}});
			}});
		}
	}
}
