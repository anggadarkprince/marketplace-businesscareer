package sketchproject.objects.particle
{
	import sketchproject.core.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
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
		
		public function RainParticle()
		{
			super();
			

			rain = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("particle_rain"));			
			rain.pivotX = rain.width * 0.5;
			rain.pivotY = rain.height * 0.5;
			addChild(rain);
		}
		
		public function set rainType(type:String):void
		{
			this.type = type;
			if(type == RainParticle.LIGHT_RAIN){
				rain.texture = Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("particle_rain");				
			}
			else if(type == RainParticle.HEAVY_RAIN){
				rain.texture = Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("particle_heavy_rain");
			}
			else{
				rain.texture = Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("particle_storm");
			}
			rain.readjustSize();
		}
		
		public function get rainType():String
		{
			return this.type;
		}
		
		public function set dropSpeed(speed:Number):void
		{
			this.speed = speed;
		}
		
		public function get dropSpeed():Number
		{
			return speed;
		}
		
		public function set windSpeed(wind:Number):void
		{
			this.wind = wind;
		}
		
		public function get windSpeed():Number
		{
			return wind;
		}
		
		public function set dropPosition(yPos:Number):void
		{
			this.yDest = yPos;
		}
		
		public function get dropPosition():Number
		{
			return yDest;
		}
	}
}