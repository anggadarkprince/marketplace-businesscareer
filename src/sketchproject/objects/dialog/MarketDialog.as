package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;

	import starling.display.Button;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * Market dialog contains setting of markets.
	 *
	 * @author Angga
	 */
	public class MarketDialog extends DialogOverlay
	{
		private var background:Image;
		private var buttonShopPlayer:Button;
		private var buttonShopCompetitor1:Button;
		private var buttonShopCompetitor2:Button;

		/**
		 * Player's setting dialog.
		 *
		 * @default
		 */
		public static var shopPlayer:ShopDialog;


		/**
		 * Competitor 1 dialog.
		 *
		 * @default
		 */
		public static var shopCompetitor1:ShopDialog;

		/**
		 * Competitor 2 setting dialog.
		 * @default
		 */
		public static var shopCompetitor2:ShopDialog;

		/**
		 * Singleton instantiator.
		 *
		 * @default
		 */
		public static var instance:MarketDialog;

		/**
		 * Get static instance.
		 * 
		 * @return
		 */
		public static function getInstance():MarketDialog
		{
			if (instance == null)
			{
				instance = new MarketDialog();
			}
			return instance;
		}

		/**
		 * Constructor of MarketDialog, should be private if we implement singleton pattern,
		 * but for now set public.
		 */
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

			buttonShopPlayer = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonShop1"));
			buttonShopPlayer.x = -176.85;
			buttonShopPlayer.y = -72.25;
			addChild(buttonShopPlayer);

			buttonShopCompetitor1 = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonShop2"));
			buttonShopCompetitor1.x = -53.75;
			buttonShopCompetitor1.y = -72.25;
			addChild(buttonShopCompetitor1);

			buttonShopCompetitor2 = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonShop3"));
			buttonShopCompetitor2.x = 88.55;
			buttonShopCompetitor2.y = -72.25;
			addChild(buttonShopCompetitor2);

			if(shopPlayer == null){
				shopPlayer = new ShopDialog("Player");				
			}
			addChild(shopPlayer);
			
			if(shopCompetitor1 == null){
				shopCompetitor1 = new ShopDialog("Competitor 1");
			}			
			addChild(shopCompetitor1);

			if(shopCompetitor2 == null){
				shopCompetitor2 = new ShopDialog("Competitor 2");
			}			
			addChild(shopCompetitor2);

			addEventListener(TouchEvent.TOUCH, onShopTouched);

			update();
		}

		/**
		 * Handle touch event in this dialog.
		 *
		 * @param touch
		 */
		private function onShopTouched(touch:TouchEvent):void
		{
			if (touch.getTouch(buttonShopPlayer, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				shopPlayer.openDialog();
			}
			if (touch.getTouch(buttonShopCompetitor1, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				shopCompetitor1.openDialog();
			}
			if (touch.getTouch(buttonShopCompetitor2, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				shopCompetitor2.openDialog();
			}
		}

		/**
		 * Update content if necessary
		 */
		public function update():void
		{
			// do nothing for now
		}
	}
}
