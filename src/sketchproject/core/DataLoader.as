package sketchproject.core
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import sketchproject.managers.ServerManager;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * Load XML data.
	 *
	 * @author Angga
	 */
	public class DataLoader extends EventDispatcher
	{
		public static const DATA_LOADED:String = "dataLoaded";

		private var mapLoaded:Boolean = false;
		private var weatherLoaded:Boolean = false;
		private var eventLoaded:Boolean = false;
		private var tipsLoaded:Boolean = false;
		private var districtLoaded:Boolean = false;
		private var researchLoaded:Boolean = false;
		private var transactionLoaded:Boolean = false;
		private var advertisementLoaded:Boolean = false;
		private var gameData:Boolean = false;
		
		private var root:String;

		/**
		 * Default constructor of DataLoader
		 */
		public function DataLoader()
		{
			root = "../";
		}

		/**
		 * Load isometric XML
		 */
		public function loadMapData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingMapData);
			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "assets/graphics/IsometricAtlas.xml"));
		}

		private function initializingMapData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.levelPivot = new Array();
			for each (var item:XML in xmlData.children())
			{
				var mapInfo:Object = {name: item.attribute("name"), pivotX: item.attribute("pivotX"), pivotY: item.attribute("pivotY")};
				Config.levelPivot.push(mapInfo);
			}

			mapLoaded = true;
			gameDataLoaded();
		}

		/**
		 * Load weather XML
		 */
		public function loadWeatherData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingWeatherData);

			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "assets/data/weather.xml"));
		}

		private function initializingWeatherData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.weather = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [item.attribute("id"), item.name, item.min, item.max, item.probability, item.status]

				Config.weather.push(row);
			}

			weatherLoaded = true;
			gameDataLoaded();
		}


		/**
		 * Load event XML data
		 */
		public function loadEventData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingEventData);

			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "assets/data/event.xml"));
		}

		private function initializingEventData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.event = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [item.attribute("id"), item.name, item.district, new Array(item.traffic.normal, item.traffic.weekend, item.traffic.holiday), new Array(int(item.profile.education), int(item.profile.art), int(item.profile.athletic)), new Array(item.time.start, item.time.finish)]

				Config.event.push(row);
			}

			eventLoaded = true;
			gameDataLoaded();
		}



		/**
		 * Load tips XML data
		 */
		public function loadTipsData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingTipsData);

			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "assets/data/tipsoftheday.xml"));
		}

		private function initializingTipsData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.tipsOfTheDay = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [item.attribute("id"), item.title, item.content]

				Config.tipsOfTheDay.push(row);
			}

			tipsLoaded = true;
			gameDataLoaded();
		}



		/**
		 * Load district XML data.
		 */
		public function loadDistrict():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingDistrictData);

			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "assets/data/district.xml"));
		}

		private function initializingDistrictData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.district = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [item.attribute("id"), item.name, item.atlas, item.description, item.priority, new Array(item.population.low, item.population.normal, item.population.high), new Array(item.marker.atlas, item.marker.x, item.marker.y), item.cost, new Point(item.shop.x, item.shop.y)]
				Config.district.push(row);
			}

			Config.location = new Array();
			for (var i:uint = 0; i < Config.district.length; i++)
			{
				var data:Object = {id: Config.district[i][0], text: Config.district[i][1]};
				Config.location.push(data);
			}

			districtLoaded = true;
			gameDataLoaded();
		}


		/**
		 * Load research XML data.
		 */
		public function loadResearchData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingResearchData);

			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "assets/data/research.xml"));
		}

		private function initializingResearchData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.research = new Array();
			Data.research = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [item.attribute("id"), item.name, item.cost]

				Config.research.push(row);
				Data.research.push(0);
			}

			researchLoaded = true;
			gameDataLoaded();
		}



		/**
		 * load transaction XML data.
		 */
		public function loadTransactionData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingTransactionData);

			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "assets/data/transaction.xml"));
		}

		private function initializingTransactionData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.transaction = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [item.attribute("id"), item.type, item.name, item.hint, item.debit, item.credit, item.description,]
				Config.transaction.push(row);
			}

			transactionLoaded = true;
			gameDataLoaded();
		}


		/**
		 * Load advertisement XML data.
		 */
		public function loadAdvertisementData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(flash.events.Event.COMPLETE, initializingAdvertisementData);

			xmlLoader.load(new URLRequest(ServerManager.SERVER_HOST + "assets/data/advertisement.xml"));
		}

		private function initializingAdvertisementData(e:flash.events.Event):void
		{
			var xmlData:XML = new XML(e.target.data);

			Config.advertisement = new Array();
			Data.advertising = new Array();
			for each (var item:XML in xmlData.children())
			{
				var row:Array = [item.attribute("id"), item.name, item.atlas, new Array(item.visibility.none, item.visibility.low, item.visibility.average, item.visibility.high)]
				Config.advertisement.push(row);
				Data.advertising.push(new Array(int(row[0]), 0, 0));

			}
			advertisementLoaded = true;
			gameDataLoaded();
		}

		/**
		 * Check if all data has been loaded.
		 */
		private function gameDataLoaded():void
		{
			if (mapLoaded && weatherLoaded && eventLoaded && tipsLoaded && districtLoaded && eventLoaded && transactionLoaded && advertisementLoaded)
			{
				dispatchEvent(new starling.events.Event(DATA_LOADED));
			}
		}
	}
}
