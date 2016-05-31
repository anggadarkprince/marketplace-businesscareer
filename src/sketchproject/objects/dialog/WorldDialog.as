package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.utilities.DayCounter;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	/**
	 * Global setting of game world.
	 *
	 * @author Angga
	 */
	public class WorldDialog extends DialogOverlay
	{
		private var background:Image;
		private var buttonPopulationMin:Button;
		private var buttonPopulationPlus:Button;
		private var buttonWeatherMin:Button;
		private var buttonWeatherPlus:Button;
		private var buttonEventMin:Button;
		private var buttonEventPlus:Button;
		private var buttonCompetitiveMin:Button;
		private var buttonCompetitivePlus:Button;
		private var buttonVariantMin:Button;
		private var buttonVariantPlus:Button;
		private var buttonAddictedMin:Button;
		private var buttonAddictedPlus:Button;
		private var buttonBuyingPowerMin:Button;
		private var buttonBuyingPowerPlus:Button;
		private var buttonEmotionMin:Button;
		private var buttonEmotionPlus:Button;

		private var barPopulation:Quad;
		private var barWeather:Quad;
		private var barEvent:Quad;
		private var barCompetitive:Quad;

		private var barVariant:Quad;
		private var barAddicted:Quad;
		private var barBuyingPower:Quad;
		private var barEmotion:Quad;

		private var buttonDayMin:Button;
		private var buttonDayPlus:Button;
		private var textDay:TextField;
		private var barHoliday:Quad;

		/**
		 * Constructor of WorldDialog.
		 */
		public function WorldDialog()
		{
			super();

			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dialogWorldSetting"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);

			buttonClose.x = 162.5;
			buttonClose.y = 201.65;

			swapChildren(background, buttonClose);

			buttonPopulationMin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonMinus"));
			buttonPopulationMin.x = -203.4;
			buttonPopulationMin.y = -59.1;
			addChild(buttonPopulationMin);

			buttonPopulationPlus = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonPlus"));
			buttonPopulationPlus.x = -50.4;
			buttonPopulationPlus.y = -59.1;
			addChild(buttonPopulationPlus);

			buttonWeatherMin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonMinus"));
			buttonWeatherMin.x = -203.4;
			buttonWeatherMin.y = 0.7;
			addChild(buttonWeatherMin);

			buttonWeatherPlus = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonPlus"));
			buttonWeatherPlus.x = -50.4;
			buttonWeatherPlus.y = 0.7;
			addChild(buttonWeatherPlus);

			buttonEventMin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonMinus"));
			buttonEventMin.x = -203.4;
			buttonEventMin.y = 60.5;
			addChild(buttonEventMin);

			buttonEventPlus = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonPlus"));
			buttonEventPlus.x = -50.4;
			buttonEventPlus.y = 60.5;
			addChild(buttonEventPlus);

			buttonCompetitiveMin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonMinus"));
			buttonCompetitiveMin.x = -203.4;
			buttonCompetitiveMin.y = 120.3;
			addChild(buttonCompetitiveMin);

			buttonCompetitivePlus = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonPlus"));
			buttonCompetitivePlus.x = -50.4;
			buttonCompetitivePlus.y = 120.3;
			addChild(buttonCompetitivePlus);



			buttonVariantMin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonMinus"));
			buttonVariantMin.x = 39.25;
			buttonVariantMin.y = -59.1;
			addChild(buttonVariantMin);

			buttonVariantPlus = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonPlus"));
			buttonVariantPlus.x = 192.25;
			buttonVariantPlus.y = -59.1;
			addChild(buttonVariantPlus);

			buttonAddictedMin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonMinus"));
			buttonAddictedMin.x = 39.25;
			buttonAddictedMin.y = 0.7;
			addChild(buttonAddictedMin);

			buttonAddictedPlus = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonPlus"));
			buttonAddictedPlus.x = 192.25;
			buttonAddictedPlus.y = 0.7;
			addChild(buttonAddictedPlus);

			buttonBuyingPowerMin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonMinus"));
			buttonBuyingPowerMin.x = 39.25;
			buttonBuyingPowerMin.y = 60.5;
			addChild(buttonBuyingPowerMin);

			buttonBuyingPowerPlus = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonPlus"));
			buttonBuyingPowerPlus.x = 192.25;
			buttonBuyingPowerPlus.y = 60.5;
			addChild(buttonBuyingPowerPlus);

			buttonEmotionMin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonMinus"));
			buttonEmotionMin.x = 39.25;
			buttonEmotionMin.y = 120.3;
			addChild(buttonEmotionMin);

			buttonEmotionPlus = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonPlus"));
			buttonEmotionPlus.x = 192.25;
			buttonEmotionPlus.y = 120.3;
			addChild(buttonEmotionPlus);


			barPopulation = new Quad(120, 10, 0xFF7979);
			barPopulation.x = -176.9;
			barPopulation.y = -54.1;
			addChild(barPopulation);

			barWeather = new Quad(120, 10, 0xFF7979);
			barWeather.x = -176.9;
			barWeather.y = 5.7;
			addChild(barWeather);

			barEvent = new Quad(120, 10, 0xFF7979);
			barEvent.x = -176.9;
			barEvent.y = 65.5;
			addChild(barEvent);

			barCompetitive = new Quad(120, 10, 0xFF7979);
			barCompetitive.x = -176.9;
			barCompetitive.y = 125.3;
			addChild(barCompetitive);

			barVariant = new Quad(120, 10, 0xFF7979);
			barVariant.x = 65.75;
			barVariant.y = -54.1;
			addChild(barVariant);

			barAddicted = new Quad(120, 10, 0xFF7979);
			barAddicted.x = 65.75;
			barAddicted.y = 5.7;
			addChild(barAddicted);

			barBuyingPower = new Quad(120, 10, 0xFF7979);
			barBuyingPower.x = 65.75;
			barBuyingPower.y = 65.5;
			addChild(barBuyingPower);

			barEmotion = new Quad(120, 10, 0xFF7979);
			barEmotion.x = 65.75;
			barEmotion.y = 125.3;
			addChild(barEmotion);

			textDay = new TextField(50, 30, Data.playtime.toString(), Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x555555);
			textDay.pivotX = textDay.width * 0.5;
			textDay.pivotY = textDay.height * 0.5;
			textDay.x = -124.55;
			textDay.y = 202.35;
			addChild(textDay);

			buttonDayMin = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonMinus"));
			buttonDayMin.x = -168;
			buttonDayMin.y = 192.55;
			addChild(buttonDayMin);

			buttonDayPlus = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonPlus"));
			buttonDayPlus.x = -103.3;
			buttonDayPlus.y = 192.55;
			addChild(buttonDayPlus);

			barHoliday = new Quad(14, 14, 0xFF7979);
			barHoliday.x = 44.7;
			barHoliday.y = 195.55;
			barHoliday.alpha = 0;
			barHoliday.useHandCursor = true;
			addChild(barHoliday);

			addEventListener(TouchEvent.TOUCH, onSettingTouched);

			update();
		}

		/**
		 * Handle touch event, and catch touch event hits buttons.
		 *
		 * @param touch Event touch when user interact with this sprite.
		 */
		private function onSettingTouched(touch:TouchEvent):void
		{
			if (touch.getTouch(buttonPopulationMin, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step down by 20, make sure minimal population are 20 people
				Data.valuePopulation = (Data.valuePopulation - 20 >= 20) ? Data.valuePopulation - 20 : Data.valuePopulation;
				update();
			}
			if (touch.getTouch(buttonPopulationPlus, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step up by 20, make sure the value never over 500
				Data.valuePopulation = (Data.valuePopulation + 20 <= 500) ? Data.valuePopulation + 20 : Data.valuePopulation;
				update();
			}

			if (touch.getTouch(buttonWeatherMin, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step down by 1, make sure minimal weather setting is 1
				Data.valueWeather = (Data.valueWeather - 1 >= 1) ? Data.valueWeather - 1 : Data.valueWeather;
				update();
			}
			if (touch.getTouch(buttonWeatherPlus, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step up by 1, make sure max of weather value is 10
				Data.valueWeather = (Data.valueWeather + 1 <= 10) ? Data.valueWeather + 1 : Data.valueWeather;
				update();
			}

			if (touch.getTouch(buttonEventMin, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step down by 1, make sure minimal event setting is 1
				Data.valueEvent = (Data.valueEvent - 1 >= 1) ? Data.valueEvent - 1 : Data.valueEvent;
				update();
			}
			if (touch.getTouch(buttonEventPlus, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step up by 1, make sure max of event value is 10
				Data.valueEvent = (Data.valueEvent + 1 <= 10) ? Data.valueEvent + 1 : Data.valueEvent;
				update();
			}

			if (touch.getTouch(buttonCompetitiveMin, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step down by 1, make sure minimal competitive setting is 1
				Data.valueCompetitor = (Data.valueCompetitor - 1 >= 1) ? Data.valueCompetitor - 1 : Data.valueCompetitor;
				update();
			}
			if (touch.getTouch(buttonCompetitivePlus, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step up by 1, make sure max of competitive value is 10
				Data.valueCompetitor = (Data.valueCompetitor + 1 <= 10) ? Data.valueCompetitor + 1 : Data.valueCompetitor;
				update();
			}

			if (touch.getTouch(buttonVariantMin, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step down by 1, make sure minimal variant setting is 1
				Data.valueVariant = (Data.valueVariant - 1 >= 1) ? Data.valueVariant - 1 : Data.valueVariant;
				update();
			}
			if (touch.getTouch(buttonVariantPlus, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step up by 1, make sure max of variant value is 10 
				Data.valueVariant = (Data.valueVariant + 1 <= 10) ? Data.valueVariant + 1 : Data.valueVariant;
				update();
			}

			if (touch.getTouch(buttonAddictedMin, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step down by 1, make sure minimal addicted setting is 1
				Data.valueAddicted = (Data.valueAddicted - 1 >= 1) ? Data.valueAddicted - 1 : Data.valueAddicted;
				update();
			}
			if (touch.getTouch(buttonAddictedPlus, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step up by 1, make sure max of addicted value is 10
				Data.valueAddicted = (Data.valueAddicted + 1 <= 10) ? Data.valueAddicted + 1 : Data.valueAddicted;
				update();
			}

			if (touch.getTouch(buttonBuyingPowerMin, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step down by 1, make sure minimal buying power setting is 1
				Data.valueBuying = (Data.valueBuying - 1 >= 1) ? Data.valueBuying - 1 : Data.valueBuying;
				update();
			}
			if (touch.getTouch(buttonBuyingPowerPlus, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step up by 1, make sure max of buting power value is 10
				Data.valueBuying = (Data.valueBuying + 1 <= 10) ? Data.valueBuying + 1 : Data.valueBuying;
				update();
			}

			if (touch.getTouch(buttonEmotionMin, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step down by 1, make sure minimal emotion setting is 1
				Data.valueEmotion = (Data.valueEmotion - 1 >= 1) ? Data.valueEmotion - 1 : Data.valueEmotion;
				update();
			}
			if (touch.getTouch(buttonEmotionPlus, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// step up by 1, make sure max of emotion value is 1
				Data.valueEmotion = (Data.valueEmotion + 1 <= 10) ? Data.valueEmotion + 1 : Data.valueEmotion;
				update();
			}

			if (touch.getTouch(buttonDayMin, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// set day of simulation min day first, multiple 6 and 7 are weekend
				Data.playtime = (Data.playtime - 1 >= 1) ? Data.playtime - 1 : Data.playtime;
				textDay.text = Data.playtime.toString();
			}
			if (touch.getTouch(buttonDayPlus, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// add current day until 999
				Data.playtime = (Data.playtime + 1 <= 999) ? Data.playtime + 1 : Data.playtime;
				textDay.text = Data.playtime.toString();
			}


			if (touch.getTouch(barHoliday, TouchPhase.ENDED))
			{
				Assets.sfxChannel = Assets.sfxClick.play(0, 0, Assets.sfxTransform);
				// toggle holiday for today exclude weekend
				barHoliday.alpha = (barHoliday.alpha == 0) ? barHoliday.alpha = 100 : barHoliday.alpha = 0;
				DayCounter.holiday = (barHoliday.alpha == 0) ? false : true;
			}
		}

		/**
		 * Update bar width by set value
		 */
		public function update():void
		{
			barPopulation.width = 120 * Data.valuePopulation / 500;
			barWeather.width = 120 * Data.valueWeather / 10;
			barEvent.width = 120 * Data.valueEvent / 10;
			barCompetitive.width = 120 * Data.valueCompetitor / 10;
			barVariant.width = 120 * Data.valueVariant / 10;
			barAddicted.width = 120 * Data.valueAddicted / 10;
			barBuyingPower.width = 120 * Data.valueBuying / 10;
			barEmotion.width = 120 * Data.valueEmotion / 10;
		}

		/**
		 * Close dialog and print last setting.
		 */
		public override function closeDialog():void
		{
			super.closeDialog();
			getWorldData();
		}

		/**
		 * Print shop data
		 */
		public function getWorldData():void
		{
			trace("[World Setting] -----------------");
			trace("---------------------------------");
			trace("-- Population :", Data.valuePopulation);
			trace("-- Weather :", Data.valueWeather);
			trace("-- Event :", Data.valueEvent);
			trace("-- Competitor :", Data.valueCompetitor);
			trace("-- Variant :", Data.valueVariant);
			trace("-- Addicted :", Data.valueAddicted);
			trace("-- Buying Power :", Data.valueBuying);
			trace("-- Emotion :", Data.valueEmotion);
			trace("Day :", Data.playtime, "(", (Data.playtime % 6 == 0) || (Data.playtime % 7 == 0) ? "Weekend" : "Regular Day", ")");
			trace("Is Holiday :", DayCounter.holiday);
			trace("---------------------------------\n");
		}
	}
}
