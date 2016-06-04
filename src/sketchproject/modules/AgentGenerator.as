package sketchproject.modules
{
	import flash.geom.Point;

	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.objects.dialog.MarketDialog;
	import sketchproject.objects.dialog.ShopDialog;
	import sketchproject.objects.world.Map;
	import sketchproject.utilities.DayCounter;
	import sketchproject.utilities.GameUtils;
	import sketchproject.utilities.IsoHelper;

	/**
	 * Generate agent and world behavior.
	 *
	 * @author Angga
	 */
	public class AgentGenerator
	{
		/**
		 * Default constructor of AgentGenerator.
		 */
		public function AgentGenerator()
		{
			trace("[Agent Generator] ---------------");
			trace("-- valuePopulation", Data.valuePopulation);
			trace("-- valueWeather", Data.valueWeather);
			trace("-- valueEvent", Data.valueEvent);
			trace("-- valueCompetitor", Data.valueCompetitor);
			trace("-- valueVariant", Data.valueVariant);
			trace("-- valueAddicted", Data.valueAddicted);
			trace("-- valueBuying", Data.valueBuying);
			trace("-- valueEmotion", Data.valueEmotion);
			trace("Day :", Data.playtime, "(", (Data.playtime % 6 == 0) || (Data.playtime % 7 == 0) ? "Weekend" : "Regular Day", ")");
			trace("Is Holiday :", DayCounter.holiday);
			trace("---------------------------------\n");
		}

		/**
		 * Generate agent's behavior.
		 *
		 * @param listConsumer
		 * @param listShop
		 * @param map
		 */
		public function generateAgent(listConsumer:Array, listShop:Array, map:Map):void
		{
			// game world parameter
			generatePopulation(listConsumer, Data.valuePopulation, map);
			generateWeather(Data.valueWeather, map);
			generateEvent(Data.valueEvent);
			generateCompetitor(listShop, Data.valueCompetitor, map);

			// consumer parameter
			generateSocialVariant(listConsumer, Data.valueVariant);
			generateAddictedLevel(listConsumer, Data.valueAddicted);
			generateBuyingPower(listConsumer, Data.valueBuying);
			generateEmotion(listConsumer, Data.valueEmotion);

			generateFreeman(listConsumer, Data.valuePopulation, map);
		}

		/**
		 * Generate population, distribute by districts,
		 * 30% (villager) : 20% (murbawisma) : 30% (madyawisma) : 20% (adiwisma).
		 *
		 * @param listConsumer agents
		 * @param generate global population setting
		 * @param map container of agents
		 */
		public function generatePopulation(agentList:Array, population:int, map:Map = null):void
		{
			if (agentList == null)
			{
				throw new ArgumentError("Agent list has null value");
			}

			var index:int;
			var location:Point;
			var agent:Agent;
			var district:String;

			// distribute agent by ratio city ideal
			var villager:int = Math.floor(0.3 / 1 * population);
			var murbawisma:int = Math.floor(0.2 / 1 * population);
			var madyawisma:int = Math.floor(0.3 / 1 * population);
			var adiwisma:int = Math.floor(0.2 / 1 * population);

			var totalGeneratedPopulation:int = villager + murbawisma + madyawisma + adiwisma;

			if ((population - totalGeneratedPopulation) > 0)
			{
				adiwisma += (population - totalGeneratedPopulation);
			}

			// set district location
			for (var i:int = 0; i < population; i++)
			{
				location = new Point();
				if (i < villager)
				{
					district = "village";
					index = GameUtils.randomFor(Config.villageCoordinate.length - 1);
					location.x = Config.villageCoordinate[index].x;
					location.y = Config.villageCoordinate[index].y;
				}
				else if (i < (villager + murbawisma))
				{
					district = "murbawisma";
					index = GameUtils.randomFor(Config.murbawismaCoordinate.length - 1);
					location.x = Config.murbawismaCoordinate[index].x;
					location.y = Config.murbawismaCoordinate[index].y;
				}
				else if (i < (villager + murbawisma + madyawisma))
				{
					district = "madyawisma";
					index = GameUtils.randomFor(Config.madyawismaCoordinate.length - 1);
					location.x = Config.madyawismaCoordinate[index].x;
					location.y = Config.madyawismaCoordinate[index].y;
				}
				else if (i < (villager + murbawisma + madyawisma + adiwisma))
				{
					district = "adiwisma";
					index = GameUtils.randomFor(Config.adiwismaCoordinate.length - 1);
					location.x = Config.adiwismaCoordinate[index].x;
					location.y = Config.adiwismaCoordinate[index].y;
				}

				agent = new Agent(location);
				agent.agentId = (i + 1);
				agent.district = district;

				// add default behavior
				agent.action.pushState(agent.wanderingAction);
				agent.action.pushState(agent.idleAction);
				agent.alpha = 0.3; // idle from home

				// push into collection and put it on game world
				agentList.push(agent);
				if (map != null)
				{
					map.levelMap.addChild(agent);
				}
			}
		}

		/**
		 * Set weather list by chaos parameter.
		 *
		 * @param generate global weather setting
		 */
		public function generateWeather(weatherRange:int, map:Map = null):void
		{
			// find range of weather will take, middle number is good weather, 
			// first group (1-3 rain) and last group (8-10 heat) are bad
			var difference:int = 10 - weatherRange;
			var range:int = Math.ceil(difference / 2);

			// attempt to fetch middle of weather value, if generate setting is 6 then try to produce 3-8
			var forecast:int = Math.ceil((Math.random() * weatherRange)) + range; // weather
			var tempratureMin:int = int(Config.weather[forecast - 1][2]); // index 2 is min temp
			var tempratureMax:int = int(Config.weather[forecast - 1][3]); // index 3 is min max
			var temprature:int = Math.ceil(Math.random() * (tempratureMax - tempratureMin)) + tempratureMin;

			// add weather into list
			var atlas:String = "weather_" + String(Config.weather[forecast - 1][1]).toLowerCase().replace(" ", "_");
			Data.weather.push(new Array(forecast, // 0 index of weather
				temprature, // 1 current temprature
				String(Config.weather[forecast - 1][1]), // 2 weather name
				atlas, // 3 atlas
				String(Config.weather[forecast - 1][5]), // 4 status
				String(Config.weather[forecast - 1][4])) // 5 probability
				);

			// add blue or red atmosphere depend on generated weather index
			if (map != null)
			{
				if (forecast <= 3)
				{
					map.atmosphere.color = 0x64bcff;
					map.atmosphere.visible = true;
				}
				else if (forecast >= 8)
				{
					map.atmosphere.color = 0xffc26b;
					map.atmosphere.visible = true;
				}
				else
				{
					map.atmosphere.visible = false;
				}
			}
		}

		/**
		 * Generate events total.
		 *
		 * @param generate
		 */
		public function generateEvent(eventRange:int):void
		{
			Data.event = new Array();

			var probability:int = GameUtils.randomFor(10);

			if (probability <= eventRange)
			{
				var totalEvent:int;

				// range 8 - 10 will produce 1 - 3 events chance
				if (eventRange >= 8)
				{
					totalEvent = GameUtils.randomFor(3);
				}
				// range 6 - 7 will produce 1 or 2 event chance
				else if (eventRange >= 6)
				{
					totalEvent = GameUtils.randomFor(2);
				}
				// range 4 - 5 will produce exact 1 event
				else if (eventRange >= 4)
				{
					totalEvent = 1;
				}
				// range 1 - 3 will produce zero or 1 event by 50 : 50 chance
				else
				{
					totalEvent = (Math.random() < 0.5) ? 1 : 0;
				}

				// generate event by total of chances
				for (var i:int = 0; i < totalEvent; i++)
				{
					var trafficDay:int; // high traffic will more notify agents
					var location:Array; // location of event
					var eventIndex:int; // event ID

					// generate new event
					while (true)
					{
						// fetch random event
						eventIndex = Math.floor(Math.random() * Config.event.length);
						var exist:Boolean = false;
						for (var j:int = 0; j < Data.event.length; j++)
						{
							// check generated event exist on data event list
							if (Config.event[eventIndex][0] == Data.event[j][0])
							{
								exist = true;
								break;
							}
						}
						if (!exist)
						{
							break;
						}
					}

					// match traffic by day
					if (DayCounter.isWeekend())
					{
						trafficDay = 1;
					}
					else if (DayCounter.isFreeday())
					{
						trafficDay = 1;
					}
					else if (DayCounter.isHoliday())
					{
						trafficDay = 2;
					}
					else
					{
						trafficDay = 0;
					}

					// populate location of event
					for (var k:int = 0; k < Config.districtCollection.length; k++)
					{
						if (Config.event[eventIndex][2] == Config.districtCollection[k].name)
						{
							location = Config.districtCollection[k].location;
						}
					}

					// add new event
					var event:Array = [int(Config.event[eventIndex][0]), // 0 event id
						String(Config.event[eventIndex][1]), // 1 event name
						int(Config.event[eventIndex][5][0]), // 2 time start
						int(Config.event[eventIndex][5][1]), // 3 time finish
						String(Config.event[eventIndex][3][trafficDay]), // 4 traffic (low, avg, high)
						location, // 5 location set coordinate
						Config.event[eventIndex][4], // 6 event characteristic education,art,athletic
						Config.event[eventIndex][2] // 7 district name
						];
					Data.event.push(event);
				}
			}
		}

		/**
		 * Generate competitors shops and attributes.
		 *
		 * @param listShop
		 * @param generate
		 * @param map
		 */
		public function generateCompetitor(shopList:Array, generate:int, map:Map):void
		{
			if (shopList == null)
			{
				throw new ArgumentError("Shop list has null value");
			}

			var twoDCoordinate:Point;
			var isoPosition:Point;
			var district:int;
			var tile:int;

			for (var j:uint = 0; j < 3; j++)
			{
				var shop:Shop;

				// create player's shop
				if (j == 0)
				{
					shop = new Shop(j + 1, Data.district);
					tile = 97;
					setShopAttribute(shop, MarketDialog.shopPlayer);
				}
				// create competitor 1 shop
				else if (j == 1)
				{
					// make sure competitor 1 district is placed in different location from players
					do
					{
						district = GameUtils.randomFor(Config.district.length) - 1;
						shop = new Shop(j + 1, Config.district[district][1]); // index 1 is district name
					} while (Config.district[district][1] == Data.district);

					tile = 98;
					setShopAttribute(shop, MarketDialog.shopCompetitor1);
				}
				// create competitor 2 shop
				else if (j == 2)
				{
					// make sure competitor 2 district location different from player and competitor 2
					do
					{
						district = GameUtils.randomFor(Config.district.length) - 1;
						shop = new Shop(j + 1, Config.district[district][1]); // index 1 is district name
					} while (Config.district[district][1] == Data.district || Config.district[district][1] == shopList[1].district); // listShop[1] is competitor 1 shop

					tile = 99;
					setShopAttribute(shop, MarketDialog.shopCompetitor2);
				}

				twoDCoordinate = IsoHelper.get2dFromTileCoordinates(shop.districtCoordinate, map.tileHeight);
				isoPosition = IsoHelper.twoDToIso(twoDCoordinate);
				map.placeTile(tile, isoPosition, map.levelMap);

				shopList.push(shop);
			}
		}

		/**
		 * Generate variant of agent traits.
		 *
		 * @param agent
		 * @param generate
		 */
		public function generateSocialVariant(agentList:Array, variation:int):void
		{
			for (var i:int = 0; i < agentList.length; i++)
			{
				var range:int = Math.ceil((10 - variation) / 2);
				var agent:Agent = agentList[i] as Agent;

				// knowledge
				agent.education = GameUtils.randomFor(variation) + range;
				agent.art = GameUtils.randomFor(variation) + range;
				agent.athletic = GameUtils.randomFor(variation) + range;

				// decoration taste
				agent.decorationMatch = new Object();
				agent.decorationMatch.modern = GameUtils.randomFor(variation) + range;
				agent.decorationMatch.colorfull = GameUtils.randomFor(variation) + range;
				agent.decorationMatch.vintage = GameUtils.randomFor(variation) + range;

				// cleaness taste
				agent.cleanessMatch = new Object();
				agent.cleanessMatch.product = GameUtils.randomFor(variation) + range;
				agent.cleanessMatch.place = GameUtils.randomFor(variation) + range;

				// scent taste
				agent.scentMatch = new Object();
				agent.scentMatch.ginger = GameUtils.randomFor(variation) + range;
				agent.scentMatch.jasmine = GameUtils.randomFor(variation) + range;
				agent.scentMatch.rosemary = GameUtils.randomFor(variation) + range;

				// adver consumption
				agent.adverContactRate = new Object();
				agent.adverContactRate.tv = GameUtils.randomFor(variation) + range;
				agent.adverContactRate.radio = GameUtils.randomFor(variation) + range;
				agent.adverContactRate.newspaper = GameUtils.randomFor(variation) + range;
				agent.adverContactRate.internet = GameUtils.randomFor(variation) + range;
				agent.adverContactRate.event = GameUtils.randomFor(variation) + range;
				agent.adverContactRate.billboard = GameUtils.randomFor(variation) + range;

				// product quality assesment
				agent.productQualityAssesment = new Object();
				agent.productQualityAssesment.food1 = [generateAssesment(), generateAssesment(), generateAssesment()];
				agent.productQualityAssesment.food2 = [generateAssesment(), generateAssesment()];
				agent.productQualityAssesment.food3 = [generateAssesment(), generateAssesment()];
				agent.productQualityAssesment.drink1 = [generateAssesment(), generateAssesment(), generateAssesment()];
				agent.productQualityAssesment.drink2 = [generateAssesment(), generateAssesment()];

				// service assessment		
				agent.serviceResponseAssesment = new Object();
				agent.serviceResponseAssesment.morale = generateAssesment();
				agent.serviceResponseAssesment.services = generateAssesment();
				agent.serviceResponseAssesment.productivity = generateAssesment();

				// influence
				agent.shopInfluence = new Object();
				agent.shopInfluence.shopPlayer = {recommendation: 0, disqualification: 0};
				agent.shopInfluence.shopCompetitor1 = {recommendation: 0, disqualification: 0};
				agent.shopInfluence.shopCompetitor2 = {recommendation: 0, disqualification: 0};

				function generateAssesment():Number
				{
					return Math.ceil(Math.random() * variation) + (10 - variation);
				}

				// distribute role and action will
				if (agent.role == null)
				{
					var role:int = Math.ceil(Math.random() * 3);
					agent.actionWill = GameUtils.randomFor(variation) + range;
					switch (role)
					{
						case 1:
							agent.role = Agent.ROLE_TRADER;
							if (agent.actionWill < 5)
							{
								agent.actionWill += GameUtils.randomFor(3) - 1;
							}
							break;
						case 2:
							agent.role = Agent.ROLE_WORKER;
							if (agent.actionWill < 6)
							{
								agent.actionWill += GameUtils.randomFor(3) - 1;
							}
							break;
						case 3:
							agent.role = Agent.ROLE_STUDENT;
							if (GameUtils.randomFor(10) < 5)
							{
								agent.actionWill += GameUtils.randomFor(3);
							}
							break;
					}
				}

				// prefer to give a recommendation or disqualification
				// sensitivity distribution
				var priceSensitivity:int;
				var qualitySensitivity:int;
				var priceThreshold:int;
				var qualityThreshold:int;
				switch (agent.district)
				{
					case Agent.DISTRICT_VILLAGE:
						priceSensitivity = ((Math.random() * 20) + 20) * -1;
						qualitySensitivity = (Math.random() * 20) + 20;
						agent.acceptance = variation * 0.6;
						agent.rejection = 1 - agent.acceptance;
						break;
					case Agent.DISTRICT_MURBAWISMA:
						priceSensitivity = ((Math.random() * 20) + 40) * -1;
						qualitySensitivity = (Math.random() * 20) + 40;
						agent.acceptance = variation * 0.4;
						agent.rejection = 1 - agent.acceptance;
						break;
					case Agent.DISTRICT_MADYAWISMA:
						priceSensitivity = ((Math.random() * 20) + 60) * -1;
						qualitySensitivity = (Math.random() * 20) + 60;
						agent.acceptance = variation * 0.8;
						agent.rejection = 1 - agent.acceptance;
						break;
					case Agent.DISTRICT_ADIWISMA:
						priceSensitivity = ((Math.random() * 20) + 80) * -1;
						qualitySensitivity = (Math.random() * 20) + 80;
						agent.acceptance = variation * 1;
						agent.rejection = 1 - agent.acceptance;
						break
				}

				// assign trait into agent
				agent.income = Math.random() * 75 + 600;
				agent.priceSensitivity = priceSensitivity;
				agent.qualitySensitivity = qualitySensitivity;
				agent.susceptibility = Math.random() * 20 + 55;
				agent.followerTendency = Math.random() * 20 + 55;

				// add some stats
				agent.stress = GameUtils.randomFor(3);
				agent.health = GameUtils.randomFor(3) + 7;
			}
		}


		/**
		 * Generate number of consumption probability.
		 *
		 * @param agent
		 * @param generate
		 */
		public function generateAddictedLevel(agentList:Array, generate:int):void
		{
			for (var i:int = 0; i < agentList.length; i++)
			{
				var agent:Agent = agentList[i] as Agent;

				// agent at least has one consumption time and max 
				agent.consumption = Math.round(GameUtils.randomFor(generate) * 3 / 10) + 1;

				agent.consumptionTime = [];
				var part:Number = 15 / agent.consumption; // max agent complete consumptions are 15 hours

				// 5 hours range each consumption
				for (var j:int = 0; j < agent.consumption; j++)
				{
					var timegen:int = GameUtils.randomFor(part) - 1; // worst case scenario at least delay 1 hour to the next consumption
					agent.consumptionTime.push({"hour": Math.round(part * j + timegen) + 6, "minute": GameUtils.randomFor(6) * 10});
				}
			}
		}

		/**
		 * Generate level of buying ability by socio-econimic trait.
		 *
		 * @param agent
		 * @param generate
		 */
		public function generateBuyingPower(agentList:Array, generate:int):void
		{
			// depend on socio-economic status
			for (var i:int = 0; i < agentList.length; i++)
			{
				var agent:Agent = agentList[i] as Agent;

				if (agent.district == Agent.DISTRICT_VILLAGE)
				{
					agent.buyingPower = Math.floor(Math.random() * 3) + 2;
				}
				else if (agent.district == Agent.DISTRICT_MURBAWISMA)
				{
					agent.buyingPower = Math.floor(Math.random() * 3) + 3;
				}
				else if (agent.district == Agent.DISTRICT_MADYAWISMA)
				{
					agent.buyingPower = Math.floor(Math.random() * 3) + 4;
				}
				else if (agent.district == Agent.DISTRICT_ADIWISMA)
				{
					agent.buyingPower = Math.floor(Math.random() * 3) + 5;
				}

				if (agent.role == Agent.ROLE_STUDENT)
				{
					agent.buyingPower += GameUtils.randomFor(2);
				}
				else if (agent.role == Agent.ROLE_WORKER)
				{
					agent.buyingPower += GameUtils.randomFor(3);
				}
				else if (agent.role == Agent.ROLE_TRADER)
				{
					agent.buyingPower += GameUtils.randomFor(4);
				}

				if (agent.buyingPower > 10)
				{
					agent.buyingPower = 10;
				}
			}
		}

		/**
		 * Generate initial emotion, affecting action will.
		 *
		 * @param agent
		 * @param generate
		 */
		public function generateEmotion(agentList:Array, generate:int):void
		{
			var emotion:int;
			for (var i:int = 0; i < agentList.length; i++)
			{
				emotion = GameUtils.randomFor(generate) + (10 - generate);
				agentList[i].emotion = emotion;
			}
		}

		/**
		 * Generate uncertainity agent.
		 *
		 * @param agent
		 * @param population
		 * @param map
		 */
		public function generateFreeman(agentList:Array, population:int, map:Map):void
		{
			// generate 20% of total population for freeman
			var generate:int = Math.round(20 / 100 * population);
			var freeman:Agent;
			var i:int = agentList.length;
			var limit:int = agentList.length + generate;

			for (i; i < limit; i++)
			{
				var location:Point = map.generateWalkableCoordinate();
				freeman = new Agent(location);
				freeman.agentId = (i + 1);
				freeman.role = Agent.ROLE_FREEMAN;
				freeman.isFlocking = true;
				freeman.buyingPower = 5;
				freeman.acceptance = 0.5;
				freeman.rejection = 0.5;
				freeman.actionWill = 5;
				freeman.emotion = 5;
				freeman.consumption = 1;
				freeman.choice = GameUtils.randomFor(3);
				freeman.unselected = GameUtils.randomFor(3);
				freeman.consumption = 2;
				freeman.consumptionTime = [{"hour": GameUtils.randomFor(5) + 6, "minute": GameUtils.randomFor(6) * 10}, {"hour": GameUtils.randomFor(5) + 12, "minute": GameUtils.randomFor(6) * 10}];
				freeman.action.pushState(freeman.wanderingAction); // default state is wandering
				agentList.push(freeman);
				map.levelMap.addChild(freeman);
			}

			generateSocialVariant(agentList, Data.valueVariant);
		}

		/**
		 * Move variable setting into shop.
		 *
		 * @param shop
		 * @param shopMarketSetting
		 */
		public function setShopAttribute(shop:Shop, shopMarketSetting:ShopDialog):void
		{
			shop.shopName = shopMarketSetting.name;
			shop.advertising = shopMarketSetting.advertisement;
			shop.price = shopMarketSetting.price;
			shop.quality = shopMarketSetting.quality;

			shop.decoration = shopMarketSetting.decoration;
			shop.cleaness = shopMarketSetting.cleaness;
			shop.scent = shopMarketSetting.scent;

			shop.productivity = shopMarketSetting.productivity;
			shop.morale = shopMarketSetting.morale;
			shop.service = shopMarketSetting.service;

			shop.businessResearch = shopMarketSetting.research;
			shop.employeeBenefit = shopMarketSetting.benefit;
			shop.booster = shopMarketSetting.booster;

			shop.getShopData();
		}

		/**
		 * Print agent data.
		 *
		 * @param agent
		 */
		public static function getAgentData(agent:Agent):void
		{
			trace("[Agent] --------------------------");
			trace("----------------------------------");
			trace("-- personality -------------------");
			trace("---- id", agent.agentId);
			trace("---- role", agent.role);
			trace("---- district", agent.district);
			trace("---- buying power", agent.buyingPower);
			trace("---- emotion", agent.emotion);
			trace("---- education", agent.education);
			trace("---- athletic", agent.athletic);
			trace("---- art", agent.art);
			trace("---- action will", agent.actionWill);
			trace("---- stress", agent.stress);
			trace("---- health", agent.health);

			trace("-- motivation --------------------");
			trace("---- price", agent.priceSensitivity);
			trace("---- price threshold", agent.priceSensitivity - (GameUtils.randomFor(10, false) + 5));
			trace("---- quality", agent.qualitySensitivity);
			trace("---- quality threshold", agent.qualitySensitivity - (GameUtils.randomFor(10, false) + 5));
			trace("---- acceptance", agent.acceptance);
			trace("---- rejection", agent.rejection);
			trace("---- choice", agent.choice);
			trace("---- consumption", agent.consumption);
			trace("---- consumption time", agent.consumptionTime);

			trace("-- environment -------------------");
			trace("---- decoration", agent.decorationMatch.modern, agent.decorationMatch.colorfull, agent.decorationMatch.vintage);
			trace("---- cleaness", agent.cleanessMatch.product, agent.cleanessMatch.place);
			trace("---- scent", agent.scentMatch.ginger, agent.scentMatch.jasmine, agent.scentMatch.rosemary);

			trace("-- advertisment ------------------");
			trace("---- adver tv", agent.adverContactRate.tv);
			trace("---- adver radio", agent.adverContactRate.radio);
			trace("---- adver newspapaer", agent.adverContactRate.newspaper);
			trace("---- adver internet", agent.adverContactRate.internet);
			trace("---- adver event", agent.adverContactRate.event);
			trace("---- adver billboard", agent.adverContactRate.billboard);

			trace("-- quality ----------------------");
			trace("---- quality food 1", agent.productQualityAssesment.food1);
			trace("---- quality food 2", agent.productQualityAssesment.food2);
			trace("---- quality food 3", agent.productQualityAssesment.food3);
			trace("---- quality drink 1", agent.productQualityAssesment.drink1);
			trace("---- quality drink 2", agent.productQualityAssesment.drink2);

			trace("-- service ----------------------");
			trace("---- morale", agent.serviceResponseAssesment.morale);
			trace("---- services", agent.serviceResponseAssesment.services);
			trace("---- productivity", agent.serviceResponseAssesment.productivity);

			trace("-- influence --------------------");
			trace("---- shop player", agent.serviceResponseAssesment.shopPlayer);
			trace("---- shop competitor1", agent.serviceResponseAssesment.shopCompetitor1);
			trace("---- shop competitor2", agent.serviceResponseAssesment.shopCompetitor2);
			trace("---------------------------------\n");
		}

		/**
		 * Print shop data.
		 *
		 * @param shop
		 */
		public static function getShopData(shop:Shop):void
		{
			trace("[Shop] --------------------------");
			trace("---------------------------------");
			trace("-- basic ------------------------");
			trace("---- id", shop.shopId);
			trace("---- name", shop.shopName);
			trace("---- district", shop.district);

			trace("-- advertisment -----------------");
			trace("---- adver tv", shop.advertising.tv);
			trace("---- adver radio", shop.advertising.radio);
			trace("---- adver newspapaer", shop.advertising.newspaper);
			trace("---- adver internet", shop.advertising.internet);
			trace("---- adver event", shop.advertising.event);
			trace("---- adver billboard", shop.advertising.billboard);

			trace("-- price ------------------------");
			trace("---- price food 1", shop.price.food1);
			trace("---- price food 2", shop.price.food2);
			trace("---- price food 3", shop.price.food3);
			trace("---- price drink 1", shop.price.drink1);
			trace("---- price drink 2", shop.price.drink2);

			trace("-- quality ----------------------");
			trace("---- quality food 1", shop.quality.food1);
			trace("---- quality food 2", shop.quality.food2);
			trace("---- quality food 3", shop.quality.food3);
			trace("---- quality drink 1", shop.quality.drink1);
			trace("---- quality drink 2", shop.quality.drink2);

			trace("-- environment ------------------");
			trace("---- decoration", shop.decoration.modern, shop.decoration.colorfull, shop.decoration.vintage);
			trace("---- cleaness", shop.cleaness.product, shop.cleaness.place);
			trace("---- scent", shop.scent.ginger, shop.scent.jasmine, shop.scent.rosemary);

			trace("-- employee ---------------------");
			trace("---- productivity", shop.productivity);
			trace("---- morale", shop.morale);
			trace("---- service", shop.service);

			trace("-- booster ----------------------");
			trace("---- shop", shop.booster.shop);
			trace("---- product", shop.booster.product);
			trace("---- employee", shop.booster.employee);
			trace("---- lucky", shop.booster.lucky);

			trace("-- research ---------------------");
			trace("---- marketing", shop.businessResearch.marketing);
			trace("---- service", shop.businessResearch.service);
			trace("---- pos", shop.businessResearch.pos);
			trace("---- product", shop.businessResearch.product);
			trace("---- facility", shop.businessResearch.facility);

			trace("-- incentive --------------------");
			trace("---- reward", shop.employeeBenefit.reward);
			trace("---- career", shop.employeeBenefit.career);
			trace("---- culture", shop.employeeBenefit.culture);
			trace("---- personalization", shop.employeeBenefit.personalization);
			trace("---- management", shop.employeeBenefit.management);

			trace("-- benefit ----------------------");
			trace("---- health", shop.employeeBenefit.health);
			trace("---- education", shop.employeeBenefit.education);
			trace("---- additional financial", shop.employeeBenefit.financial);
			trace("---- police practice", shop.employeeBenefit.practice);

			trace("-- statistic --------------------");
			trace("---- marketshare", shop.marketshare);
			trace("---- profit", shop.grossProfit);
			trace("---- transaction", shop.transactionTotal);
			trace("---------------------------------\n");
		}
	}
}
