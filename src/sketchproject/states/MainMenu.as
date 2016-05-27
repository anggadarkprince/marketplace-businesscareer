package sketchproject.states
{
	import sketchproject.core.Assets;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	import sketchproject.modules.Shop;
	import sketchproject.objects.dialog.MarketDialog;
	import sketchproject.objects.dialog.ReportDialog;
	import sketchproject.objects.dialog.WorldDialog;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MainMenu extends Sprite implements IState
	{
		private var game:Game;
		
		private var background:Image;
		
		private var buttonStart:Button;
		private var buttonHelp:Button;
		private var buttonRelease:Button;
		private var buttonWorld:Button;
		private var buttonMarket:Button;
		private var buttonReport:Button;
		
		private var world:WorldDialog;
		private var market:MarketDialog;
		private var report:ReportDialog;		
		
		public function MainMenu(game:Game)
		{			
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * Init sprite function
		 * @return void
		 */
		private function init(event:Event):void
		{
			initialize();			
			trace("[STATE] MENU");
		}
		
		/**
		 * Initializing all main menu component
		 * @return void
		 */
		public function initialize():void
		{
			
			background = new Image(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("front"));
			addChild(background);
			
			buttonStart = new Button(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("buttonStart"));
			buttonStart.pivotX = buttonStart.width * 0.5;
			buttonStart.pivotY = buttonStart.height * 0.5;
			buttonStart.x = 697;
			buttonStart.y = 260;
			addChild(buttonStart);
						
			buttonHelp = new Button(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("buttonHelp"));
			buttonHelp.x = 895;
			buttonHelp.y = 522;
			addChild(buttonHelp);
			
			buttonRelease = new Button(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("buttonRelease"));
			buttonRelease.x = 21;
			buttonRelease.y = 522;
			addChild(buttonRelease);
			
			buttonWorld = new Button(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("buttonWorld"));
			buttonWorld.x = 173;
			buttonWorld.y = 210;
			addChild(buttonWorld);
			
			buttonMarket = new Button(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("buttonMarket"));
			buttonMarket.x = 272;
			buttonMarket.y = 210;
			addChild(buttonMarket);
			
			buttonReport = new Button(Assets.getAtlas(Assets.CONTENT,Assets.CONTENT_XML).getTexture("buttonReport"));
			buttonReport.x = 368;
			buttonReport.y = 210;
			addChild(buttonReport);
			
			world = new WorldDialog();
			world.x = stage.stageWidth * 0.5;
			world.y = stage.stageHeight * 0.5;
			addChild(world);
			
			market = MarketDialog.getInstance();
			market.x = stage.stageWidth * 0.5;
			market.y = stage.stageHeight * 0.5;
			addChild(market);
			
			report = ReportDialog.getInstance();
			report.x = stage.stageWidth * 0.5;
			report.y = stage.stageHeight * 0.5;
			addChild(report);
									
			addEventListener(TouchEvent.TOUCH, onMenuTouched);	
		}
						
		/**
		 * Event when button on main menu touched
		 * @params $touch passing touch event
		 * @return void
		 */
		private function onMenuTouched(touch:TouchEvent):void
		{			
			
			if (touch.getTouch(buttonStart, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				game.changeState(Game.WORLD_STATE);
			}
			if (touch.getTouch(buttonWorld, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				world.openDialog();
			}
			if (touch.getTouch(buttonMarket, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				market.openDialog();
			}
			if (touch.getTouch(buttonReport, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
				report.openDialog();
			}
			if (touch.getTouch(buttonHelp, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
			if (touch.getTouch(buttonRelease, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			}
		}
				
		/**
		 * Update current state
		 * @return void
		 */
		public function update():void
		{
			//report.update(shop1, shop2, shop3);
		}
		
		/**
		 * Garbage collector destroy all compenent and reset varable
		 * @return void
		 */
		public function destroy():void
		{
			removeEventListener(TouchEvent.TOUCH, onMenuTouched);	
			report.removeFromParent(false);
			market.removeFromParent(false);
			report.removeFromParent(false);
			removeFromParent(true);
		}
		
		public function toString() : String 
		{
			return "sketchproject.states.MainMenu";
		}
	}
}