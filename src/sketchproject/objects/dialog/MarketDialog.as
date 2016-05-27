package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class MarketDialog extends DialogOverlay
	{
		private var background:Image;
		private var buttonShopPlayer:Button;
		private var buttonShopCompetitor1:Button;
		private var buttonShopCompetitor2:Button;
		
		public static var shopPlayer:ShopDialog;
		public static var shopCompetitor1:ShopDialog;
		public static var shopCompetitor2:ShopDialog;
		
		public static var instance:MarketDialog;
		
		public static function getInstance():MarketDialog{
			if(instance == null){
				instance = new MarketDialog();
			}
			return instance;
		}
				
		public function MarketDialog()
		{			
			super();
			
			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dialogMarketSetting"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);
			
			buttonClose.x = 0;
			buttonClose.y = 152.7;
			
			swapChildren(background, buttonClose);
			
			buttonShopPlayer = new Button(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("buttonShop1"));
			buttonShopPlayer.x = -176.85;
			buttonShopPlayer.y = -72.25;
			addChild(buttonShopPlayer);
			
			buttonShopCompetitor1 = new Button(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("buttonShop2"));
			buttonShopCompetitor1.x = -53.75;
			buttonShopCompetitor1.y = -72.25;
			addChild(buttonShopCompetitor1);
			
			buttonShopCompetitor2 = new Button(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("buttonShop3"));
			buttonShopCompetitor2.x = 88.55;
			buttonShopCompetitor2.y = -72.25;
			addChild(buttonShopCompetitor2);
			
			shopPlayer = new ShopDialog();
			addChild(shopPlayer);
			
			shopCompetitor1 = new ShopDialog();
			addChild(shopCompetitor1);
			
			shopCompetitor2 = new ShopDialog();
			addChild(shopCompetitor2);
			
			addEventListener(TouchEvent.TOUCH, onShopTouched);
			
			update();
			
		}
		
		private function onShopTouched(touch:TouchEvent):void
		{
			if (touch.getTouch(buttonShopPlayer, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				shopPlayer.openDialog();
			}
			if (touch.getTouch(buttonShopCompetitor1, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				shopCompetitor1.openDialog();
			}
			if (touch.getTouch(buttonShopCompetitor2, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				shopCompetitor2.openDialog();
			}
		}
		
		public function update():void
		{
			
		}
		
		
	}
}