package sketchproject.utilities
{

	import flash.ui.Keyboard;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	import starling.display.Stage;
	import starling.events.KeyboardEvent;

	/**
	 * The KeyObject class recreates functionality of
	 * Key.isDown of ActionScript 1 and 2
	 *
	 * Usage:
	 * var key:KeyObject = new KeyObject(stage);
	 * if (key.isDown(key.LEFT)) { ... }
	 *
	 * @author Angga
	 */
	dynamic public class KeyObject extends Proxy
	{

		private static var stage:Stage;
		private static var keysDown:Object;

		/**
		 * Constructor of KeyObject.
		 *
		 * @param stage
		 */
		public function KeyObject(stage:Stage)
		{
			construct(stage);
		}

		/**
		 * Custom constructor.
		 *
		 * @param stage
		 */
		public function construct(stage:Stage):void
		{
			KeyObject.stage = stage;
			keysDown = new Object();

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}

		/**
		 * Proxy to catch key from typing.
		 *
		 * @param name
		 * @return
		 */
		flash_proxy override function getProperty(name:*):*
		{
			return (name in Keyboard) ? Keyboard[name] : -1;
		}

		/**
		 * Check if a key is pressed.
		 *
		 * @param keyCode keyboard code
		 * @return status key
		 */
		public function isDown(keyCode:uint):Boolean
		{
			return Boolean(keyCode in keysDown);
		}

		/**
		 * Destroy keyboard listener.
		 */
		public function deconstruct():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleased);
			keysDown = new Object();
			KeyObject.stage = null;
		}

		/**
		 * Handle if a key is pressed.
		 *
		 * @param evt keyboard event handler
		 */
		private function keyPressed(evt:KeyboardEvent):void
		{
			keysDown[evt.keyCode] = true;
		}

		/**
		 * Handle if a key is released.
		 * @param evt
		 */
		private function keyReleased(evt:KeyboardEvent):void
		{
			delete keysDown[evt.keyCode];
		}
	}
}
