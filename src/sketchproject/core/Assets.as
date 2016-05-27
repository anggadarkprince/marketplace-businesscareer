package sketchproject.core
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		// constant variable ---------------------------------------------------------------------------
				
		public static var CONTENT:String = "TextureContent";
		public static var CONTENT_XML:String = "XMLContent";
		
		public static var ISOMERTIC:String = "TextureIsometric";
		public static var ISOMERTIC_XML:String = "XMLIsometric";
		
		public static var NPC:String = "TextureNpc";
		public static var NPC_XML:String = "XMLNpc";
				
		public static var FONT_SSBOLD:String = "FontSSPBold";
		public static var FONT_SSREGULAR:String = "FontSSPRegular";
				
		
		// isometric
		[Embed(source="../../../assets/graphics/IsometricAtlas.png")]
		public static const TextureIsometric:Class;		
		[Embed(source="../../../assets/graphics/IsometricAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLIsometric:Class;
		
		// npc
		[Embed(source="../../../assets/graphics/NpcAtlas.png")]
		public static const TextureNpc:Class;		
		[Embed(source="../../../assets/graphics/NpcAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLNpc:Class;
		
		// content
		[Embed(source="../../../assets/graphics/ContentAtlas.png")]
		public static const TextureContent:Class;		
		[Embed(source="../../../assets/graphics/ContentAtlas.xml", mimeType="application/octet-stream")]
		public static const XMLContent:Class;
				
		// particle assets -----------------------------------------------------------------------------
		// fireworks
		[Embed(source="../../../assets/particles/fireworks.png")]
		private static var ParticleFireworks:Class;		
		[Embed(source="../../../assets/particles/fireworks.pex", mimeType="application/octet-stream")]
		public static var ParticleFireworksXML:Class;
		
		
		
		// font assets ---------------------------------------------------------------------------------
					
		[Embed(source='../../../assets/fonts/SourceSansPro-Regular.ttf', embedAsCFF='false',fontName='SourceSansProRegular')]		
		public static var FontSSPRegular:Class;
		
		[Embed(source='../../../assets/fonts/SourceSansPro-Bold.ttf', embedAsCFF='false',fontName='SourceSansProBold')]		
		public static var FontSSPBold:Class;
		
				
		// sound sfx
		[Embed(source="../../../assets/sounds/sfx/Click.mp3")]
		private static var sfxClickSound:Class;
		public static var sfxClick:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Coin.mp3")]
		private static var sfxCoinSound:Class;
		public static var sfxCoin:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Fireworks.mp3")]
		private static var sfxFireworksSound:Class;
		public static var sfxFireworks:Sound;
				
		[Embed(source="../../../assets/sounds/sfx/City Crickets.mp3")]
		private static var sfxCityCricketsSound:Class;
		public static var sfxCityCrickets:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/City Daylight.mp3")]
		private static var sfxCityDaylightSound:Class;
		public static var sfxCityDaylight:Sound;
		
		[Embed(source="../../../assets/sounds/sfx/Rain.mp3")]
		private static var sfxRainSound:Class;
		public static var sfxRain:Sound;

		
		public static var sfxTransform:SoundTransform = new SoundTransform();
		public static var sfxChannel:SoundChannel = new SoundChannel();
			
		
		// assets loader -------------------------------------------------------------------------------
		private static var gameTexture:Dictionary = new Dictionary();
		private static var gameTextureAtlas:Dictionary = new Dictionary();
		private static var gameVectorFont:Dictionary = new Dictionary();
				
		public static function getAtlas(name:String, map:String):TextureAtlas
		{
			if(gameTextureAtlas[name] == undefined)
			{
				var texture:Texture = getTexture(name);
				var xml:XML = new XML(new Assets[map]());
				gameTextureAtlas[name] = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas[name];
		}
				
		public static function getTexture(name:String):Texture
		{
			if(gameTexture[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTexture[name] = Texture.fromBitmap(bitmap);
			}
			return gameTexture[name];
		}
		
		public static function getFont(name:String):Font
		{
			if(gameVectorFont[name] == undefined)
			{
				var font:Font = new Assets[name]();
				gameVectorFont[name] = font;
			}
			return gameVectorFont[name];
		}
		
		
		public static function init():void
		{			
			sfxClick = new sfxClickSound();
			sfxCoin = new sfxCoinSound();

			sfxCityCrickets = new sfxCityCricketsSound();
			sfxCityDaylight = new sfxCityDaylightSound();
			sfxRain = new sfxRainSound();
						
			setupGameSound();			
		}
		
		public static function setupGameSound():void
		{									
			sfxChannel.soundTransform = sfxTransform;
		}
		
	}
}