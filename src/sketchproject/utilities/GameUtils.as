package sketchproject.utilities
{
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	public class GameUtils
	{
		public static function probability(value:Number = Number.MAX_VALUE):Boolean
		{
			if(Math.random() < value){
				return true;
			}
			return false;
		}
		
		public static function randomFor(value:Number, isCeiled:Boolean = true):Number
		{
			var random:Number = Math.random() * value;
			if(isCeiled){
				return Math.ceil(random);
			}
			return random;
		}
		
		public static function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		
		public static function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
			
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		
		public static function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
		
		public static function swapTextureFrame(animation:MovieClip, textures:Vector.<Texture>):void 
		{
			while(animation.numFrames > 1){
				animation.removeFrameAt(0);
			}			
			for each (var texture:Texture in textures){
				animation.addFrame(texture);
			}			
			if(animation.numFrames != 1){
				animation.removeFrameAt(0);
			}			
			animation.stop();
			animation.readjustSize();
		} 
		
		public static function log(message:*):void
		{
			trace("---------------------------\n",message,"\n---------------------------\n");
		}
	}
}