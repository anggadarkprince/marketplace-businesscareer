package sketchproject.states
{
	import flash.geom.Point;

	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.core.Game;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.objects.dialog.AgentDialog;
	import sketchproject.objects.dialog.ReportDialog;
	import sketchproject.objects.dialog.TrendDialog;
	import sketchproject.objects.world.Clock;
	import sketchproject.objects.world.Map;
	import sketchproject.utilities.DayCounter;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Simulation marketplace.
	 *
	 * @author Angga
	 */
	public class Gameworld extends Sprite implements IState
	{
		// game component
		private var game:Game;
		private var map:Map;

		// map drag and drop property
		private var _startXPos:int = 0;
		private var _startYPos:int = 0;
		private var currentXPos:int = 0;
		private var currentYPos:int = 0;
		private var newXPos:int = 0;
		private var newYPos:int = 0;
		private var minX:int = -300 * Config.zoom;
		private var maxX:int = 1450 * Config.zoom;
		private var minY:int = -831 * Config.zoom;
		private var maxY:int = 13 * Config.zoom;
		private var globalPosition:Point = new Point();
		private var touch:Touch;
		private var target:DisplayObject;
		private var position:Point;

		private var isSimulationStarted:Boolean;

		private var buttonStop:Button;
		private var buttonViewAgent:Button;
		private var buttonSimulationReport:Button;

		private var report:ReportDialog;
		private var view:AgentDialog;
		private var trend:TrendDialog;

		private var statsBar:Image;

		private var clock:Clock = new Clock(6, 0, 0);
		private var opening:int = 6;
		private var closing:int = 18;
		private var checkOpen:Boolean = false;
		private var checkClose:Boolean = false;

		private var delayClockTick:int = 0;
		private var delayGraph:int = 0;

		private var label:TextField;
		private var time:TextField;
		private var linkEvent:TextField;

		/**
		 * Constructor of Gameworld.
		 *
		 * @param game container
		 */
		public function Gameworld(game:Game)
		{
			super();
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		/**
		 * Init sprite function
		 */
		public function init():void
		{
			initialize();
			trace("[STATE] GAMEWORLD");
		}

		/**
		 * Initialize the sprites.
		 */
		public function initialize():void
		{
			map = new Map();
			map.x = 500;
			map.y = -300;
			addChild(map);

			statsBar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("bar"));
			statsBar.y = 490;
			addChild(statsBar);

			buttonStop = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonStop"));
			buttonStop.pivotX = buttonStop.width * 0.5;
			buttonStop.pivotY = buttonStop.height * 0.5;
			buttonStop.x = 887;
			buttonStop.y = 525;
			addChild(buttonStop);

			buttonViewAgent = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonSmallAgent"));
			buttonViewAgent.x = 30;
			buttonViewAgent.y = 500;
			addChild(buttonViewAgent);

			buttonSimulationReport = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonSmallReport"));
			buttonSimulationReport.x = 95;
			buttonSimulationReport.y = 500;
			addChild(buttonSimulationReport);

			label = new TextField(150, 30, "Day", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 18, 0xFFFFFF);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 159.85;
			label.y = 500.9;
			addChild(label);

			label = new TextField(150, 30, DayCounter.today() + " | " + DayCounter.dayCounting() + ", Year " + DayCounter.yearCounting(), Assets.getFont(Assets.FONT_SSREGULAR).fontName, 18, 0x00CCFF);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 199.85;
			label.y = 500.9;
			addChild(label);

			label = new TextField(150, 30, "Clock", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 18, 0xFFFFFF);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 349.85;
			label.y = 500.9;
			addChild(label);

			time = new TextField(150, 30, clock.hour + " : " + clock.minute, Assets.getFont(Assets.FONT_SSREGULAR).fontName, 18, 0x00CCFF);
			time.hAlign = HAlign.LEFT;
			time.vAlign = VAlign.TOP;
			time.x = 400;
			time.y = 500.9;
			addChild(time);

			label = new TextField(150, 30, "Weather", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0xFFFFFF);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 159.85;
			label.y = 525.9;
			addChild(label);

			label = new TextField(150, 30, Data.weather[Data.weather.length-1][1] + " Degree " + Data.weather[Data.weather.length-1][2], Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x00CCFF);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 219.85;
			label.y = 525.9;
			addChild(label);

			label = new TextField(150, 30, "Event", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0xFFFFFF);
			label.hAlign = HAlign.LEFT;
			label.vAlign = VAlign.TOP;
			label.x = 350;
			label.y = 525.9;
			addChild(label);

			linkEvent = new TextField(150, 30, "Click Details", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 14, 0x00CCFF);
			linkEvent.hAlign = HAlign.LEFT;
			linkEvent.vAlign = VAlign.TOP;
			linkEvent.x = 390;
			linkEvent.y = 525.9;
			linkEvent.useHandCursor = true;
			addChild(linkEvent);

			report = ReportDialog.getInstance();
			report.x = stage.stageWidth * 0.5;
			report.y = stage.stageHeight * 0.5;
			addChild(report);

			view = new AgentDialog();
			view.x = stage.stageWidth * 0.5;
			view.y = stage.stageHeight * 0.5;
			view.selectRandomAgent();
			addChild(view);

			trend = new TrendDialog();
			trend.x = stage.stageWidth * 0.5;
			trend.y = stage.stageHeight * 0.5;
			addChild(trend);

			addEventListener(TouchEvent.TOUCH, onMenuTouched);

			map.addEventListener(TouchEvent.TOUCH, onWorldTouched);

			isSimulationStarted = true;
		}

		private function onMenuTouched(touch:TouchEvent):void
		{
			if (touch.getTouch(buttonStop, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				game.changeState(Game.MENU_STATE);
			}
			if (touch.getTouch(buttonViewAgent, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				view.openDialog();
			}
			if (touch.getTouch(buttonSimulationReport, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				report.openDialog();
			}
			if (touch.getTouch(linkEvent, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				trend.openDialog();
			}
		}

		private function onShopClose():void
		{
			//trace("shop open-----closing the simulation");
		}

		private function onShopOpen():void
		{
			//trace("shop open-----prepare the simulation");
		}

		private function onWorldTouched(e:TouchEvent):void
		{
			touch = e.getTouch(stage);
			target = e.currentTarget as DisplayObject;

			if (touch == null)
			{
				return;
			}

			position = touch.getLocation(stage);

			if (touch.phase == TouchPhase.BEGAN)
			{
				// store start of drag x pos
				globalPosition.x = touch.globalX;
				globalPosition.y = touch.globalY;

				_startXPos = target.globalToLocal(globalPosition).x;
				_startYPos = target.globalToLocal(globalPosition).y;
			}
			else if (touch.phase == TouchPhase.MOVED)
			{
				// calculate new x based on touch's global coordinates
				globalPosition.x = touch.globalX;
				globalPosition.y = touch.globalY;

				currentXPos = target.globalToLocal(globalPosition).x;
				currentYPos = target.globalToLocal(globalPosition).y;

				newXPos = target.x + currentXPos - _startXPos;
				newYPos = target.y + currentYPos - _startYPos;

				if (newXPos <= maxX && newXPos >= minX) // set target's x if it falls within limits
					target.x = newXPos;

				if (newYPos <= maxY && newYPos >= minY) // set target's y if it falls within limits
					target.y = newYPos;
			}

			return;
		}

		/**
		 * Update the game world.
		 */
		public function update():void
		{
			if (isSimulationStarted)
			{
				map.update(clock.hour, clock.minute);
				clockUpdate();
			}
		}

		/**
		 * Update timer.
		 */
		public function clockUpdate():void
		{
			delayClockTick++;
			delayGraph++;

			if (delayClockTick == 20)
			{
				view.update();
				clock.update();

				time.text = clock.hour + " : " + clock.minute;
				
				// open all shop
				if (!checkOpen && clock.hour == opening)
				{
					checkOpen = true;
					onShopOpen();
				}

				// close all shop
				if (!checkClose && clock.hour == closing)
				{
					checkClose = true;
					onShopClose();
				}

				delayClockTick = 0;
			}
			
			if (delayGraph == 50)
			{
				report.update(WorldManager.instance.listShop[0], WorldManager.instance.listShop[1], WorldManager.instance.listShop[2]);
				delayGraph = 0;
			}
		}

		/**
		 * Remove state.
		 */
		public function destroy():void
		{
			view.removeFromParent(false);
			trend.removeFromParent(false);
			report.removeFromParent(false);
			map.removeFromParent(false);
			removeFromParent(true);
		}

		/**
		 * Return name of state.
		 * 
		 * @return
		 */
		public function toString():String
		{
			return "sketchproject.states.GameworldState";
		}
	}
}
