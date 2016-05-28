package sketchproject.objects.world
{
	import flash.geom.Point;
	import flash.ui.Keyboard;

	import sketchproject.core.Assets;
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.managers.FireworkManager;
	import sketchproject.managers.RainManager;
	import sketchproject.managers.RewardManager;
	import sketchproject.managers.WorldManager;
	import sketchproject.objects.particle.RainParticle;
	import sketchproject.utilities.GameUtils;
	import sketchproject.utilities.IsoHelper;
	import sketchproject.utilities.KeyObject;
	import sketchproject.utilities.MapCreator;
	import sketchproject.utilities.TweenInitiator;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Game world map and all content of simulation,
	 * contains map -> radiance -> atmosphere -> particle
	 *
	 * @author Angga
	 */
	public class Map extends Sprite
	{
		private var key:KeyObject = new KeyObject(Starling.current.stage);

		// the canvas
		public var levelBackground:Sprite; // terrains
		public var levelMap:Sprite; // buildings
		public var levelOverlay:Sprite; // overlay such as event text, flying object, avatar, firework
		public var levelWorld:Sprite; // container all of level
		public var particleContainer:Sprite; // rain container
		public var radiance:Quad;
		public var atmosphere:Quad;

		// data
		public var backgroundData:Array = [[20, 20, 19, 20, 21, 18, 18, 18, 21, 18, 21, 18, 18, 20, 20, 18, 3, 20, 21, 20, 8, 18, 23, 22, 22], [18, 20, 19, 18, 18, 18, 20, 3, 18, 3, 18, 3, 18, 3, 3, 3, 8, 3, 3, 3, 8, 20, 23, 22, 22], [20, 19, 19, 19, 18, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 8, 3, 3, 3, 8, 21, 23, 22, 22], [20, 21, 19, 18, 3, 7, 13, 13, 13, 13, 13, 13, 13, 13, 17, 13, 15, 3, 3, 3, 8, 3, 23, 22, 22], [20, 18, 20, 3, 3, 8, 3, 3, 3, 3, 3, 3, 3, 3, 8, 3, 8, 3, 3, 3, 8, 3, 23, 22, 22], [18, 21, 3, 3, 3, 8, 3, 3, 3, 7, 13, 6, 3, 3, 8, 3, 4, 17, 13, 13, 15, 3, 23, 22, 22], [21, 18, 3, 3, 3, 8, 3, 3, 3, 8, 3, 8, 3, 3, 8, 3, 3, 8, 3, 3, 8, 3, 23, 22, 22], [18, 3, 3, 3, 3, 8, 3, 3, 3, 4, 17, 5, 3, 3, 8, 3, 3, 8, 3, 3, 8, 3, 23, 22, 22], [18, 3, 3, 3, 3, 8, 3, 3, 3, 3, 8, 3, 3, 3, 8, 3, 3, 8, 3, 3, 8, 3, 23, 22, 22], [18, 3, 3, 3, 3, 16, 13, 10, 3, 3, 8, 3, 3, 3, 8, 3, 3, 8, 3, 3, 8, 3, 23, 22, 22], [20, 3, 3, 3, 3, 8, 3, 3, 3, 3, 8, 3, 3, 3, 8, 3, 3, 16, 13, 13, 15, 3, 23, 22, 22], [18, 3, 3, 3, 3, 8, 3, 3, 3, 3, 8, 3, 3, 3, 8, 3, 3, 8, 3, 3, 8, 3, 23, 22, 22], [20, 11, 13, 13, 13, 1, 13, 13, 13, 13, 14, 13, 13, 13, 1, 13, 13, 15, 3, 3, 8, 3, 23, 22, 22], [18, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 3, 3, 3, 8, 3, 3, 8, 3, 3, 8, 3, 23, 22, 22], [20, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 3, 3, 3, 8, 3, 3, 8, 3, 3, 8, 3, 23, 22, 22], [21, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 3, 3, 3, 8, 3, 3, 4, 13, 13, 15, 3, 23, 22, 22], [18, 3, 3, 3, 3, 16, 13, 13, 13, 17, 13, 13, 13, 13, 15, 3, 3, 3, 3, 3, 8, 3, 23, 22, 22], [18, 3, 3, 3, 3, 8, 3, 3, 3, 8, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 8, 3, 23, 22, 22], [20, 3, 3, 3, 3, 8, 3, 3, 3, 8, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 8, 3, 23, 22, 22], [18, 3, 3, 3, 3, 8, 3, 3, 3, 8, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 8, 3, 23, 22, 22], [18, 3, 3, 3, 3, 8, 3, 3, 3, 8, 3, 3, 3, 7, 14, 6, 3, 3, 3, 3, 8, 3, 23, 22, 22], [21, 18, 3, 3, 3, 4, 13, 17, 13, 14, 13, 13, 13, 15, 3, 16, 13, 13, 13, 13, 15, 3, 23, 22, 22], [18, 18, 3, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 4, 17, 5, 3, 3, 3, 3, 8, 3, 23, 22, 22], [18, 18, 3, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 8, 3, 23, 22, 22], [20, 18, 18, 18, 3, 3, 3, 8, 3, 3, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 8, 3, 23, 22, 22], [18, 20, 18, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 3, 8, 3, 3, 3, 3, 3, 8, 3, 23, 22, 22], [18, 18, 21, 3, 3, 3, 3, 8, 3, 3, 3, 3, 12, 3, 8, 3, 3, 3, 3, 3, 8, 3, 23, 22, 22], [18, 21, 18, 21, 20, 3, 3, 4, 13, 13, 13, 13, 5, 3, 8, 3, 3, 3, 3, 3, 8, 21, 23, 22, 22], [21, 18, 18, 18, 18, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9, 3, 3, 3, 3, 20, 8, 18, 23, 90, 22], [21, 18, 18, 18, 20, 18, 21, 18, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 21, 19, 8, 20, 23, 22, 22]];
		public var levelData:Array = [[78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 0, 78, 78, 78, 78], [78, 78, 78, 78, 0, 0, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 0, 0, 0, 0, 0, 78, 78, 78, 78], [78, 78, 78, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 78, 78], [78, 78, 78, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 78, 0, 0, 0, 78, 78, 78], [78, 0, 0, 0, 0, 0, 64, 78, 66, 34, 33, 0, 31, 78, 0, 73, 0, 60, 78, 85, 0, 0, 78, 78, 78], [78, 78, 78, 78, 78, 0, 48, 0, 0, 0, 0, 0, 35, 30, 0, 0, 0, 0, 0, 0, 0, 0, 78, 78, 78], [78, 69, 78, 78, 78, 0, 29, 65, 78, 0, 52, 0, 0, 70, 0, 78, 78, 0, 51, 51, 0, 0, 78, 78, 78], [78, 0, 78, 78, 78, 0, 0, 78, 78, 0, 0, 0, 78, 78, 0, 59, 78, 0, 51, 51, 0, 76, 78, 78, 78], [78, 0, 92, 56, 78, 0, 32, 62, 78, 0, 0, 0, 53, 78, 0, 78, 78, 0, 51, 51, 0, 75, 78, 78, 78], [78, 0, 0, 0, 0, 0, 0, 0, 78, 78, 0, 0, 0, 0, 0, 58, 78, 0, 51, 51, 0, 77, 78, 78, 78], [78, 78, 78, 78, 78, 0, 0, 0, 63, 78, 0, 0, 78, 78, 0, 78, 78, 0, 0, 0, 0, 0, 78, 78, 78], [78, 54, 78, 55, 78, 0, 25, 26, 27, 28, 0, 0, 71, 78, 0, 57, 78, 0, 50, 50, 0, 76, 78, 78, 78], [78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 50, 0, 75, 78, 78, 78], [78, 78, 78, 78, 78, 0, 87, 78, 0, 87, 78, 0, 0, 0, 0, 78, 78, 0, 50, 50, 0, 76, 78, 78, 78], [78, 78, 78, 78, 78, 0, 78, 78, 0, 78, 78, 0, 78, 78, 0, 84, 78, 0, 50, 50, 0, 76, 78, 78, 78], [78, 78, 78, 78, 78, 0, 67, 78, 0, 68, 78, 0, 61, 78, 0, 27, 0, 0, 0, 0, 0, 76, 78, 78, 78], [78, 78, 78, 78, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 92, 0, 49, 49, 0, 0, 78, 78, 78], [78, 78, 78, 78, 78, 0, 78, 78, 78, 0, 78, 78, 78, 0, 0, 0, 0, 0, 49, 49, 0, 0, 78, 78, 78], [78, 24, 78, 78, 78, 0, 78, 78, 78, 0, 93, 74, 93, 0, 0, 85, 0, 0, 49, 49, 0, 85, 78, 78, 78], [78, 0, 0, 0, 0, 0, 82, 78, 78, 0, 78, 78, 0, 0, 0, 79, 0, 0, 49, 49, 0, 0, 78, 78, 78], [78, 88, 88, 0, 0, 0, 28, 28, 28, 0, 86, 78, 0, 0, 0, 0, 0, 0, 49, 49, 0, 85, 78, 78, 78], [78, 78, 88, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 91, 0, 0, 0, 0, 0, 0, 0, 78, 78, 78], [78, 78, 88, 0, 0, 0, 47, 0, 36, 78, 42, 39, 39, 0, 0, 0, 0, 0, 78, 78, 0, 0, 78, 78, 78], [78, 78, 88, 88, 0, 0, 0, 0, 37, 37, 44, 47, 0, 45, 0, 0, 0, 0, 78, 78, 0, 0, 78, 78, 78], [78, 78, 78, 88, 0, 0, 47, 0, 40, 40, 78, 78, 0, 0, 0, 0, 0, 0, 72, 78, 0, 89, 78, 78, 78], [78, 78, 78, 88, 0, 78, 78, 0, 47, 47, 81, 78, 0, 0, 0, 78, 78, 0, 0, 0, 0, 47, 78, 78, 78], [78, 78, 78, 88, 0, 46, 78, 0, 38, 78, 43, 41, 0, 0, 0, 83, 78, 0, 78, 78, 0, 89, 78, 78, 78], [78, 78, 78, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 78, 0, 80, 78, 0, 78, 78, 78, 78], [78, 78, 78, 78, 78, 0, 0, 0, 47, 47, 47, 47, 0, 0, 0, 46, 78, 0, 0, 78, 0, 78, 78, 78, 78], [78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 0, 78, 78, 78, 78]];
		public var walkableData:Array;
		public var tileHeight:uint = 50;

		private var depth:int;
		private var indexChild:int;
		private var delayFireworks:uint = 0;

		// isometric property
		private var cartesianCoordinate:Point;
		private var twoDCoordinate:Point;
		private var isoPosition:Point;
		private var tilePivot:Point;
		private var walkableRandom:Point;

		// manager
		private var worldManager:WorldManager;
		private var rainManager:RainManager;
		private var coinManager:RewardManager;
		private var fireworkManager:FireworkManager;

		// overlay sprite
		private var helicopter:MovieClip;
		private var ballonAir:Image;
		private var landingPlane:Image;

		// world info
		public var eventLabels:Array;
		public var isEventExist:Boolean;
		public var hour:int;
		public var minute:int;

		/**
		 * Default constructor of Map.
		 *
		 * @param isSimulation init the map and start the simulation
		 */
		public function Map(isSimulationStarted:Boolean = true)
		{
			super();

			levelWorld = new Sprite();
			addChild(levelWorld);

			levelBackground = new Sprite();
			levelWorld.addChild(levelBackground);

			levelMap = new Sprite();
			levelWorld.addChild(levelMap);

			levelOverlay = new Sprite();
			levelWorld.addChild(levelOverlay);

			walkableData = new Array();
			eventLabels = new Array();

			cartesianCoordinate = new Point();
			twoDCoordinate = new Point();
			isoPosition = new Point();
			tilePivot = new Point();
			walkableRandom = new Point();

			createBackground();
			createLevel();

			worldManager = new WorldManager(this, isSimulationStarted);
			fireworkManager = new FireworkManager(levelOverlay);
			coinManager = new RewardManager(RewardManager.REWARD_COIN, RewardManager.SPAWN_ONCE, false, levelWorld);

			// add color effect
			if (isSimulationStarted)
			{
				radiance = new Quad(3000, 3000, 0x000000);
				radiance.pivotX = radiance.width * 0.5;
				radiance.pivotY = radiance.height * 0.5;
				radiance.alpha = 0.6;
				addChild(radiance);

				atmosphere = new Quad(3000, 3000, 0xffc26b);
				atmosphere.pivotX = radiance.width * 0.5;
				atmosphere.pivotY = radiance.height * 0.5;
				atmosphere.alpha = 0.3;
				addChild(atmosphere);
			}

			// add overlay sprite
			helicopter = new MovieClip(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTextures("heli"), 15);
			helicopter.x = 600;
			helicopter.y = -200;
			helicopter.scaleX = -0.8;
			helicopter.scaleY = 0.8;
			TweenInitiator.helicopterAnimate(helicopter);
			Starling.juggler.add(helicopter);
			levelOverlay.addChild(helicopter);

			ballonAir = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("ballonAir"));
			ballonAir.x = 1600;
			ballonAir.y = 500;
			TweenInitiator.ballonAirAnimate(ballonAir);
			levelOverlay.addChild(ballonAir);

			landingPlane = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("planeLanding"));
			landingPlane.x = 1600;
			landingPlane.y = 900;
			TweenInitiator.planeLandingAnimate(landingPlane);
			levelOverlay.addChild(landingPlane);

			// setup rain particle
			particleContainer = new Sprite();
			particleContainer.x = -levelBackground.width * 0.5;
			addChild(particleContainer);

			if (int(Data.weather[0][0]) <= 3)
			{
				if (int(Data.weather[0][0]) == 1)
				{
					rainManager = new RainManager(particleContainer, RainParticle.STORM_RAIN);
				}
				else if (int(Data.weather[0][0]) == 2)
				{
					rainManager = new RainManager(particleContainer, RainParticle.HEAVY_RAIN);
				}
				else if (int(Data.weather[0][0]) == 3)
				{
					rainManager = new RainManager(particleContainer, RainParticle.LIGHT_RAIN);
				}
				rainManager.spawnWidth = levelBackground.width;
				rainManager.spawnHeight = levelBackground.height;
			}

			addEventLabel(Data.event);

			addShopLabel("Your Shop", worldManager.listShop[0].districtCoordinate, 200, 50);
			addShopLabel("Competitor Shop 1", worldManager.listShop[1].districtCoordinate, 200, 50);
			addShopLabel("Competitor Shop 2", worldManager.listShop[2].districtCoordinate, 200, 50);

			addEventListener(TouchEvent.TOUCH, onWorldTouched);
		}

		/**
		 * Add text in overlay layer.
		 *
		 * @param text of label
		 * @param location coordinate
		 * @param width text container
		 * @param height text container
		 * @param visibility text visibility
		 */
		public function addShopLabel(text:String, location:Point, width:int, height:int, visibility:Boolean = true):void
		{
			var label:TextField = new TextField(width, height, text, Assets.getFont(Assets.FONT_SSBOLD).fontName, 30, 0xFFFFFF);
			var labelPosition:Point = IsoHelper.get2dFromTileCoordinates(location, tileHeight);
			label.pivotX = label.width * 0.5;
			label.pivotY = label.height * 0.5;
			label.x = IsoHelper.twoDToIso(labelPosition).x + 50;
			label.y = IsoHelper.twoDToIso(labelPosition).y - 50;
			label.vAlign = VAlign.TOP;
			label.hAlign = HAlign.CENTER;
			label.visible = visibility;
			TweenInitiator.spriteBounce(label, label.x, label.y);
			levelOverlay.addChild(label);
		}

		/**
		 * Add event label over the district event located.
		 *
		 * @param dataEvents current list
		 */
		public function addEventLabel(dataEvents:Array):void
		{
			isEventExist = (dataEvents.length > 0) ? true : false;
			for (var i:int = 0; i < dataEvents.length; i++)
			{
				var label:TextField = new TextField(300, 300, dataEvents[i][1] + " Event", Assets.getFont(Assets.FONT_SSBOLD).fontName, 30, 0xFFFFFF);
				var index:int = GameUtils.randomFor(dataEvents[i][5].length - 1); // pointing event location in district area
				var labelPosition:Point = IsoHelper.get2dFromTileCoordinates(new Point(Number(dataEvents[i][5][index].x), Number(dataEvents[i][5][index].y)), tileHeight);
				label.pivotX = label.width * 0.5;
				label.pivotY = label.height * 0.5;
				label.x = IsoHelper.twoDToIso(labelPosition).x;
				label.y = IsoHelper.twoDToIso(labelPosition).y;
				label.vAlign = VAlign.TOP;
				label.visible = false;
				TweenInitiator.spriteBounce(label, label.x, label.y);
				levelOverlay.addChild(label);
				eventLabels.push({"id": Config.event[i][0], "label": label});
			}
		}

		/**
		 * Spawn coin when agent buy an item.
		 *
		 * @param location
		 */
		public function spawnCoin(location:Point):void
		{
			coinManager.spawn(location.x, location.y, location.x, location.y - 100);
		}

		/**
		 * Select random location from walkable coordinate list.
		 *
		 * @return
		 */
		public function generateWalkableCoordinate():Point
		{
			walkableRandom = walkableData[Math.floor(Math.random() * walkableData.length)];
			return walkableRandom;
		}

		/**
		 * Put agent location into map by given location.
		 * (+tileHeight/2) to make agent center of the tile
		 *
		 * @param location of agent should be placed
		 * @return
		 */
		public function placeAgentLocation(location:Point):Point
		{
			var point:Point = new Point();
			point.x = location.x * tileHeight + tileHeight / 2;
			point.y = location.y * tileHeight + tileHeight / 2;
			return point;
		}

		/**
		 * Generate terrain level.
		 * loop through background data, get coordinate -> convert 2D -> convert iso
		 * put tile into map by passing tile data, position and container
		 */
		private function createBackground():void
		{
			for (var y:uint = 0; y < backgroundData.length; y++)
			{
				for (var x:uint = 0; x < backgroundData[0].length; x++)
				{
					cartesianCoordinate = new Point(x, y);
					twoDCoordinate = IsoHelper.get2dFromTileCoordinates(cartesianCoordinate, tileHeight);
					isoPosition = IsoHelper.twoDToIso(twoDCoordinate);
					placeTile(backgroundData[y][x], isoPosition, levelBackground);
				}
			}
			levelBackground.flatten();
		}

		/**
		 * Generate building level.
		 * loop through level data, get coordinate -> convert 2D -> convert iso
		 * put tile into map by passing tile data, position and container
		 * add 0 value from tile data as walkable area
		 */
		private function createLevel():void
		{
			for (var y:uint = 0; y < levelData.length; y++)
			{
				for (var x:uint = 0; x < levelData[0].length; x++)
				{
					if (levelData[y][x] != 0)
					{
						cartesianCoordinate = new Point(x, y);
						twoDCoordinate = IsoHelper.get2dFromTileCoordinates(cartesianCoordinate, tileHeight);
						isoPosition = IsoHelper.twoDToIso(twoDCoordinate);
						placeTile(levelData[y][x], isoPosition, levelMap);
					}
					else
					{
						walkableData.push(new Point(x, y));
					}
				}
			}
		}

		/**
		 * Put tile into right position at their container.
		 *
		 * @param tile id
		 * @param isoCoordinate position of tile should be placed
		 * @param container of tile
		 */
		public function placeTile(tile:int, isoCoordinate:Point, container:DisplayObjectContainer):void
		{
			var tileImage:Image = MapCreator.getMapTile(tile);
			getPivotTile(tileImage.name);

			tileImage.pivotX = tilePivot.x;
			tileImage.pivotY = tilePivot.y;

			tileImage.x = isoCoordinate.x;
			tileImage.y = isoCoordinate.y;
			container.addChild(tileImage);
		}

		/**
		 * Make sure pivot of tiles in the right position - left bottom base.
		 *
		 * @param tileId
		 * @return
		 */
		private function getPivotTile(tileId:String):Point
		{
			for (var i:uint = 0; i < Config.levelPivot.length; i++)
			{
				if (Config.levelPivot[i].name == tileId)
				{
					tilePivot.x = Config.levelPivot[i].pivotX;
					tilePivot.y = Config.levelPivot[i].pivotY;
					return tilePivot;
				}
			}
			return new Point(0, 0);
		}

		/**
		 * Sort tiles and agents by z-index (y position)
		 */
		private function depthSort():void
		{
			for (var i:uint = 0; i < levelMap.numChildren; i++)
			{
				depth = levelMap.getChildAt(i).y;
				indexChild = i - 1;
				while (indexChild >= 0 && (levelMap.getChildAt(indexChild).y) > depth)
				{
					levelMap.swapChildrenAt(indexChild + 1, indexChild);
					indexChild--;
				}
			}
		}

		/**
		 * Update map and simulation.
		 *
		 * @param hour of simulation
		 * @param minute of simulation
		 */
		public function update(hour:int, minute:int):void
		{
			this.hour = hour;
			this.minute = minute;

			worldManager.update();
			
			checkRadianceAtmosphere(hour);
			checkEventOperation(hour);

			if (int(Data.weather[0][0]) <= 3)
			{
				rainManager.update();
			}

			depthSort();

			if (key.isDown(Keyboard.SPACE))
			{
				levelMap.visible = false;
			}
			if (key.isDown(Keyboard.CONTROL))
			{
				levelMap.visible = true;
			}
		}

		/**
		 * Radiance gives dark and light,
		 * atmosphere gives color overlay heat and cold effect.
		 *
		 * @param hour
		 */
		public function checkRadianceAtmosphere(hour:int):void
		{
			if (hour >= 3 && hour < 8)
			{
				radiance.alpha = (8 - hour) * 0.04;
				if (int(Data.weather[0][0]) <= 3)
				{
					atmosphere.alpha = (hour - 3) * ((0.4 - (0.1 * int(Data.weather[0][0]))) / 5);
				}
				else if (int(Data.weather[0][0]) >= 8)
				{
					atmosphere.alpha = (hour - 3) * ((0.4 - (0.1 * (11 - int(Data.weather[0][0])))) / 5);
				}
			}
			else if (hour >= 17 || hour < 3)
			{
				if (hour < 21)
				{
					radiance.alpha = (hour - 17) * 0.06;
					if (int(Data.weather[0][0]) <= 3 && hour >= 17)
					{
						atmosphere.alpha = (21 - hour) * ((0.4 - (0.1 * int(Data.weather[0][0]))) / 4);
					}
					else if (int(Data.weather[0][0]) >= 8 && hour >= 17)
					{
						atmosphere.alpha = (21 - hour) * ((0.4 - (0.1 * (11 - int(Data.weather[0][0])))) / 4);
					}
				}
			}
			else
			{
				radiance.alpha = 0;
				atmosphere.alpha = (0.4 - (0.1 * (11 - int(Data.weather[0][0]))));
			}
		}

		/**
		 * Check time of event begin then show or hide the label,
		 * index 2 is start hour, index 3 is finish hour.
		 *
		 * @param hour
		 */
		public function checkEventOperation(hour:int):void
		{
			for (var i:int = 0; i < Data.event.length; i++)
			{
				if (hour >= Data.event[i][2] && hour < Data.event[i][3])
				{
					eventLabels[i].label.visible = true;
					if (delayFireworks++ == 50)
					{
						fireworkManager.spawn(eventLabels[i].label.x, eventLabels[i].label.y);
						delayFireworks = 0;
					}
				}
				else
				{
					eventLabels[i].label.visible = false;
				}
			}
		}

		/**
		 * Unecessary event listener to check the coordinate of game map.
		 *
		 * @param e
		 */
		private function onWorldTouched(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);

			if (touch != null && touch.phase == TouchPhase.ENDED)
			{
				var position:Point = touch.getLocation(levelBackground);

				var clickPt:Point = new Point();
				clickPt.x = position.x;
				clickPt.y = position.y;
				clickPt = IsoHelper.isoTo2D(clickPt);
				clickPt.x -= tileHeight / 2;
				clickPt.y += tileHeight / 2;
				clickPt = IsoHelper.getTileCoordinates(clickPt, tileHeight);

				trace("touch " + position, "coordinate " + clickPt);

				if (clickPt.x < 0 || clickPt.y < 0 || clickPt.x > levelData.length - 1 || clickPt.x > levelData[0].length - 1)
				{
					trace("invalid");
					//we have clicked outside
					return;
				}
				if (levelData[clickPt.y][clickPt.x] != 0)
				{
					trace("wall");
					//we clicked on a wall
					return;
				}
				trace("find ", clickPt);
			}
		}
		
		/**
		 * Destroy all map component
		 */
		public function destroy():void
		{
			levelWorld.removeFromParent();
			radiance.removeFromParent();
			atmosphere.removeFromParent();
			particleContainer.removeFromParent();
			
			rainManager.destroy();
		}
	}
}
