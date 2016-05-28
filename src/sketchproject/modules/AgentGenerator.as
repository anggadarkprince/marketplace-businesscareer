package sketchproject.modules
{
	import flash.geom.Point;
	
	import sketchproject.core.Config;
	import sketchproject.core.Data;
	import sketchproject.objects.world.Map;
	import sketchproject.utilities.DayCounter;
	import sketchproject.utilities.GameUtils;
	import sketchproject.utilities.IsoHelper;
	

	public class AgentGenerator
	{
		public function AgentGenerator()
		{			
			//trace("valuePopulation",Data.valuePopulation);
			//trace("valueWeather",Data.valueWeather);
			//trace("valueEvent",Data.valueEvent);
			//trace("valueCompetitor",Data.valueCompetitor);
			//trace("valueVariant",Data.valueVariant);
			//trace("valueAddicted",Data.valueAddicted);
			//trace("valueBuying",Data.valueBuying);
			//trace("valueEmotion",Data.valueEmotion);			
		}
		
		public function generateAgent(listConsumer:Array, listShop:Array, map:Map):void
		{
			// game world parameter
			generatePopulation(listConsumer, Data.valuePopulation, map);
			generateWeather(Data.valueWeather);
			generateEvent(Data.valueEvent);
			generateCompetitor(listShop, Data.valueCompetitor, map);
			
			// consumer parameter
			generateSocialVariant(listConsumer, Data.valueVariant);
			generateAddictedLevel(listConsumer, Data.valueAddicted);
			generateBuyingPower(listConsumer, Data.valueBuying);
			generateEmotion(listConsumer, Data.valueEmotion);
			
			generateFreeman(listConsumer, Data.valuePopulation, map);
		}
				
		public function generatePopulation(listConsumer:Array, generate:int, map:Map = null):void
		{
			var index:int;
			var location:Point;
			var agent:Agent;
			var district:String;
			
			var villager:int = Math.floor(0.3 / 1 * generate);
			var murbawisma:int = Math.floor(0.2 / 1 * generate);
			var madyawisma:int = Math.floor(0.3 / 1 * generate);
			var adiwisma:int = Math.floor(0.2 / 1 * generate);
			
			var total:int = villager + murbawisma + madyawisma + adiwisma;
			
			if ((generate - total) > 0) {
				adiwisma += (generate-total);
			}
			
			for (var i:int = 0; i < generate; i++) 
			{		
				location = new Point();
				if (i < villager) {
					district = "village";				
					index = GameUtils.randomFor(Config.villageCoordinate.length-1);
					location.x = Config.villageCoordinate[index].x;
					location.y = Config.villageCoordinate[index].y;
				}
				else if (i < (villager + murbawisma)) {
					district = "murbawisma";
					index = GameUtils.randomFor(Config.murbawismaCoordinate.length-1);
					location.x = Config.murbawismaCoordinate[index].x;
					location.y = Config.murbawismaCoordinate[index].y;
				}
				else if (i < (villager + murbawisma + madyawisma)) {
					district = "madyawisma";										
					index = GameUtils.randomFor(Config.madyawismaCoordinate.length-1);
					location.x = Config.madyawismaCoordinate[index].x;
					location.y = Config.madyawismaCoordinate[index].y;
				}
				else if (i < (villager + murbawisma + madyawisma + adiwisma)) {
					district = "adiwisma";
					index = GameUtils.randomFor(Config.adiwismaCoordinate.length-1);
					location.x = Config.adiwismaCoordinate[index].x;
					location.y = Config.adiwismaCoordinate[index].y;
				}				
				
				agent = new Agent(location);
				agent.agentId = (i+1);
				agent.district = district;	
				
				agent.action.pushState(agent.wanderingAction);
				agent.action.pushState(agent.idleAction);
				agent.alpha = 0.3;
				
				listConsumer.push(agent);
				if(map!=null){
					map.levelMap.addChild(agent);						
				}
			}
		}
		
		public function generateWeather(generate:int):void
		{
			var difference:int = 10 - generate;
			var range:int = Math.ceil(difference / 2);
			
			var forecast:int = Math.ceil((Math.random() * generate)) + range;
			var tempratureMin:int = int(Config.weather[forecast-1][2]);
			var tempratureMax:int = int(Config.weather[forecast-1][3]);
			var temprature:int = Math.ceil(Math.random() * (tempratureMax-tempratureMin)) + tempratureMin;
			
			trace(forecast,Config.weather[forecast-1][1],temprature,"Degree","weather_"+String(Config.weather[forecast-1][1]).toLowerCase().replace(" ","_"));
								
			Data.weather.push(new Array(
				forecast,
				temprature,
				String(Config.weather[forecast-1][1]),
				"weather_"+String(Config.weather[forecast-1][1]).toLowerCase().replace(" ","_"),
				String(Config.weather[forecast-1][5]),
				String(Config.weather[forecast-1][4])
			));
			/*
			Data.weather[0] = new Array(
				forecast,
				temprature,
				Config.weather[forecast-1][1],
				"weather_"+String(Config.weather[forecast-1][1]).toLowerCase(),
				String(Config.weather[forecast-1][5]),
				String(Config.weather[forecast-1][4])
			);
							
			if(forecast<=3){
				map.atmosphere.color = 0x64bcff;
				map.atmosphere.visible = true;
			}
			else if(forecast>=8){
				map.atmosphere.color = 0xffc26b;
				map.atmosphere.visible = true;
			}
			else
			{
				map.atmosphere.visible = false;
			}
			*/
		}
		
		public function generateEvent(generate:int):void {
			Data.event = new Array();
			
			var probability:int = Math.floor(Math.random() * 10);
			
			if (probability < generate) {
				
				var totalEvent:int = Math.floor(Math.random() * (generate/3));
				
				if(generate >= 8){
					totalEvent = GameUtils.randomFor(3);
				}
				else if(generate >= 6){
					totalEvent = GameUtils.randomFor(2);
				}
				else if(generate >= 4){
					totalEvent = 1;
				}				
				else{
					totalEvent = (Math.random() < 0.5)?1:0;
				}
				
				for(var i:int = 0; i < totalEvent;i++)
				{
					var trafficDay:int;
					var location:Array;
					var eventIndex:int;
					
					while(true){
						eventIndex = Math.floor(Math.random() * Config.event.length);
						var exist:Boolean = false;
						for(var j:int = 0; j < Data.event.length; j++)
						{
							if(Config.event[eventIndex][0] == Data.event[j][0]){
								exist = true;
								break;
							}
						}	
						if(!exist)
						{
							break;
						}
					}
					
					if(DayCounter.isWeekend() || DayCounter.isFreeday()){
						trafficDay = 1;
					}
					else if(DayCounter.isHoliday()){
						trafficDay = 2;
					}
					else{
						trafficDay = 0;
					}
					
					
					if(Config.event[eventIndex][2] == "Sport Center")
					{
						location = Config.sportCenterCoordinate;
					}
					else if(Config.event[eventIndex][2] == "Town Hall")
					{
						location = Config.townHallCoordinate;
					}
					else if(Config.event[eventIndex][2] == "Play Ground")
					{
						location = Config.playgroundCoordinate;
					}
					else if(Config.event[eventIndex][2] == "School Center")
					{
						location = Config.schoolCoordinate;
					}
					else if(Config.event[eventIndex][2] == "Times Square")
					{
						location = Config.timesSquareCoordinate;
					}
					else if(Config.event[eventIndex][2] == "Factory")
					{
						location = Config.factoryCoordinate;
					}
					else if(Config.event[eventIndex][2] == "Wonderland")
					{
						location = Config.wonderlandCoordinate;
					}
					else if(Config.event[eventIndex][2] == "Green Ville")
					{
						location = Config.murbawismaCoordinate;
					}
					
					var event:Array = [
						int(Config.event[eventIndex][0]),
						String(Config.event[eventIndex][1]),
						int(Config.event[eventIndex][5][0]),
						int(Config.event[eventIndex][5][1]),
						String(Config.event[eventIndex][3][trafficDay]),
						location,
						Config.event[eventIndex][4]
					];
					Data.event.push(event);					
					GameUtils.log(event);
				}			
			}
		}
		
		public function generateCompetitor(listShop:Array, generate:int, map:Map):void 
		{
			var twoDCoordinate:Point;
			var isoPosition:Point;
			var dist:int;
			
			for(var j:uint=0; j<3; j++){
				var shop:Shop;
				if(j==0){
					shop = new Shop(j+1, Data.district);
					twoDCoordinate = IsoHelper.get2dFromTileCoordinates(shop.districtCoordinate, map.tileHeight);
					isoPosition = IsoHelper.twoDToIso(twoDCoordinate);
					if(Data.asset[0].ast_level == 1)
					{
						map.placeTile(97, isoPosition, map.levelMap);
					}
					else if(Data.asset[0].ast_level == 1)
					{
						map.placeTile(98, isoPosition, map.levelMap);
					}
					else if(Data.asset[0].ast_level == 1)
					{
						map.placeTile(99, isoPosition, map.levelMap);
					}
				}
				if(j==1){					
					do{
						dist = Math.floor(Math.random() * Config.district.length);
						shop = new Shop(j+1, Config.district[dist][1]);
					}
					while(Config.district[dist][1] == Data.district);
					
					twoDCoordinate = IsoHelper.get2dFromTileCoordinates(shop.districtCoordinate, map.tileHeight);
					isoPosition = IsoHelper.twoDToIso(twoDCoordinate);
					map.placeTile(96+GameUtils.randomFor(3), isoPosition, map.levelMap);
				}
				if(j==2){
					do{
						dist = Math.floor(Math.random() * Config.district.length);
						shop = new Shop(j+1, Config.district[dist][1]);
					}
					while(Config.district[dist][1] == Data.district || Config.district[dist][1] == listShop[1].district);
					
					twoDCoordinate = IsoHelper.get2dFromTileCoordinates(shop.districtCoordinate, map.tileHeight);
					isoPosition = IsoHelper.twoDToIso(twoDCoordinate);
					map.placeTile(96+GameUtils.randomFor(3), isoPosition, map.levelMap);
				}
				listShop.push(shop);
			}
			
			/*var gameObject:Object 			= new Object();
			gameObject.token 				= Data.key;
			var server:ServerManager = new ServerManager("gameserver/get_simulation_avatar");
			server.addEventListener(ServerManager.READY, function(event:Event):void{
				var avatar:Object = JSON.parse(server.received.avatar_var) as Object;
				
				twoDCoordinate = IsoHelper.get2dFromTileCoordinates(listShop[0].districtCoordinate, map.tileHeight);
				isoPosition = IsoHelper.twoDToIso(twoDCoordinate);
				//map.avatarTexture(ServerManager.SERVER_HOST+"assets/images/avatar/"+avatar.player,isoPosition);
				
				twoDCoordinate = IsoHelper.get2dFromTileCoordinates(listShop[1].districtCoordinate, map.tileHeight);
				isoPosition = IsoHelper.twoDToIso(twoDCoordinate);
				//map.avatarTexture(ServerManager.SERVER_HOST+"assets/images/avatar/"+avatar.competitor1,isoPosition);
				
				twoDCoordinate = IsoHelper.get2dFromTileCoordinates(listShop[2].districtCoordinate, map.tileHeight);
				isoPosition = IsoHelper.twoDToIso(twoDCoordinate);
				//map.avatarTexture(ServerManager.SERVER_HOST+"assets/images/avatar/"+avatar.competitor2,isoPosition);
			});*/
			//server.sendRequest();
		}		
		
		public function generateSocialVariant(agent:Array, generate:int):void {
			for (var i:int = 0; i < agent.length; i++) 
			{				
				var range:int = Math.ceil((10-generate) / 2);
				
				agent[i].education = GameUtils.randomFor(generate) + range;
				agent[i].art = GameUtils.randomFor(generate) + range;
				agent[i].athletic = GameUtils.randomFor(generate) + range;
				
				agent[i].decorationMatch = new Object();
				agent[i].decorationMatch.modern = GameUtils.randomFor(generate) + range;
				agent[i].decorationMatch.colorfull = GameUtils.randomFor(generate) + range;
				agent[i].decorationMatch.vintage = GameUtils.randomFor(generate) + range;
				
				agent[i].cleanessMatch = new Object();
				agent[i].cleanessMatch.product = GameUtils.randomFor(generate) + range;
				agent[i].cleanessMatch.place = GameUtils.randomFor(generate) + range;
				
				agent[i].scentMatch = new Object();
				agent[i].scentMatch.ginger = GameUtils.randomFor(generate) + range;
				agent[i].scentMatch.jasmine = GameUtils.randomFor(generate) + range;
				agent[i].scentMatch.rosemary = GameUtils.randomFor(generate) + range;
				
				agent[i].adverContactRate = new Object();
				agent[i].adverContactRate.tv = GameUtils.randomFor(generate) + range;
				agent[i].adverContactRate.radio = GameUtils.randomFor(generate) + range;
				agent[i].adverContactRate.newspaper = GameUtils.randomFor(generate) + range;
				agent[i].adverContactRate.internet = GameUtils.randomFor(generate) + range;
				agent[i].adverContactRate.event = GameUtils.randomFor(generate) + range;
				agent[i].adverContactRate.billboard = GameUtils.randomFor(generate) + range;
				
				//trace("character ",agent[i].education,agent[i].art,agent[i].athletic);
				
				var role:int = Math.ceil(Math.random() * 3);
				switch(role)
				{
					case 1:
						agent[i].role = Agent.ROLE_TRADER;
						agent[i].actionWill = GameUtils.randomFor(generate) + range;
						if(agent[i].actionWill < 5){
							agent[i].actionWill += Math.floor(Math.random() * 3);
						}
						break;
					case 2:
						agent[i].role = Agent.ROLE_WORKER;
						agent[i].actionWill = GameUtils.randomFor(generate) + range;
						if(agent[i].actionWill < 6){
							agent[i].actionWill += Math.floor(Math.random() * 3);
						}
						break;
					case 3:
						agent[i].role = Agent.ROLE_STUDENT;
						agent[i].actionWill = GameUtils.randomFor(generate) + range;
						if(GameUtils.randomFor(10) < 5){
							agent[i].actionWill += GameUtils.randomFor(3);
						}
						break;
				}
				//trace("role ",agent[i].role, agent[i].actionWill);
				
				var priceSensitivity:int;
				var qualitySensitivity:int;
				var priceThreshold:int;
				var qualityThreshold:int;
				switch(agent[i].district)
				{
					case "village":
						priceSensitivity = ((Math.random() * 5) + 5);
						qualitySensitivity = (Math.random() * 2) + 2;
						break;
					case "murbawisma":
						priceSensitivity = ((Math.random() * 5) + 4);
						qualitySensitivity = (Math.random() * 2) + 4;
						break;
					case "madyawisma":
						priceSensitivity = ((Math.random() * 5) + 3);
						qualitySensitivity = (Math.random() * 2) + 6;
						break;
					case "adiwisma":
						priceSensitivity = ((Math.random() * 4) + 2);
						qualitySensitivity = (Math.random() * 2) + 8;
						break
				}
				
				priceThreshold = priceSensitivity + (Math.random() * 3);
				qualityThreshold = qualitySensitivity - (Math.random() * 3);
				
				if(priceThreshold > 10)
				{
					priceThreshold = 10;
				}
				if(qualityThreshold < 1)
				{
					qualityThreshold = 1;
				}
				
				agent[i].priceSensitivity = priceSensitivity;
				agent[i].qualitySensitivity = qualitySensitivity;
				agent[i].priceThreshold = priceThreshold;
				agent[i].qualityThreshold = qualityThreshold;
				agent[i].choice = 0;
				agent[i].stress = GameUtils.randomFor(3);
				
			}
		}
		
		
		public function generateAddictedLevel(agent:Array, generate:int):void {
			for (var i:int = 0; i < agent.length; i++) 
			{
				if (agent[i].district == "village") {
					agent[i].acceptance = generate * 0.6;
					agent[i].rejection = 1 - agent[i].acceptance;
				}
				else if (agent[i].district == "murbawisma") {
					agent[i].acceptance = generate * 0.4;
					agent[i].rejection = 1 - agent[i].acceptance;
				}
				else if (agent[i].district == "madyawisma") {
					agent[i].acceptance = generate * 0.8;
					agent[i].rejection = 1 - agent[i].acceptance;
				}
				else if (agent[i].district == "adiwisma") {
					agent[i].acceptance = generate * 1;
					agent[i].rejection = 1 - agent[i].acceptance;
				}
				
				agent[i].consumption = Math.round(GameUtils.randomFor(generate) * 3 / 10) + 1;
				
				agent[i].consumptionTime = [];			
				var part:Number = 15 / agent[i].consumption;
				
				for (var j:int = 0; j < agent[i].consumption; j++) 
				{				
					var timegen:int = GameUtils.randomFor(part);					
					agent[i].consumptionTime.push({"hour":Math.round(part * j + timegen) + 6,"minute":GameUtils.randomFor(6)*10});
					//trace("agent",agent[i].agentId, agent[i].consumptionTime[j].hour,agent[i].consumptionTime[j].minute);
				}				
			}
		}
		
		public function generateBuyingPower(agent:Array, generate:int):void {
			for (var i:int = 0; i < agent.length; i++) 
			{
				if (agent[i].district == "village") {
					agent[i].buyingPower = Math.floor(Math.random() * 3) + 4;
				}
				else if (agent[i].district == "murbawisma") {
					agent[i].buyingPower = Math.floor(Math.random() * 3) + 5;
				}
				else if (agent[i].district == "madyawisma") {
					agent[i].buyingPower = Math.floor(Math.random() * 3) + 6;
				}
				else if (agent[i].district == "adiwisma") {
					agent[i].buyingPower = Math.floor(Math.random() * 3) + 7;
				}
			}
		}
		
		public function generateEmotion(agent:Array, generate:int):void {
			var emotion:int;
			for (var i:int = 0; i < agent.length; i++) 
			{
				emotion = GameUtils.randomFor(generate) + (10 - generate);
				agent[i].emotion = emotion;
				//trace("emotion",emotion);
			}
		}
		
		public function generateFreeman(agent:Array, population:int, map:Map):void
		{
			var generate:int = Math.round(20/100 * population);
			var freeman:Agent;
			var i:int = agent.length; 
			var limit:int = agent.length + generate;
			
			for (i; i < limit; i++) 
			{
				var location:Point = map.generateWalkableCoordinate();
				freeman = new Agent(location);
				freeman.agentId = (i+1);
				freeman.role = Agent.ROLE_FREEMAN;
				freeman.isFlocking = true;
				freeman.action.pushState(freeman.wanderingAction);
				agent.push(freeman);
				map.levelMap.addChild(freeman);
			}
		}
		
		public function getAgentData(agent:Agent):void
		{
			trace("---------------------------------");
			trace("personality----------------------");
			trace("id",agent.agentId);
			trace("npc",agent.npc);
			trace("role",agent.role);
			trace("district",agent.district);
			trace("buying power",agent.buyingPower);
			trace("emotion",agent.emotion);
			trace("education",agent.education);
			trace("athletic",agent.athletic);
			trace("art",agent.art);
			trace("action",agent.actionWill);
			trace("stress",agent.stress);
			
			trace("motivation----------------------");
			trace("price",agent.priceSensitivity);
			trace("price threshold",agent.priceThreshold);
			trace("quality",agent.qualitySensitivity);
			trace("quality threshold",agent.qualityThreshold);
			trace("acceptance",agent.acceptance);
			trace("rejection",agent.rejection);
			trace("choice",agent.choice);
			trace("consumption",agent.consumption);
			trace("consumption time",agent.consumptionTime);
			trace("adver contact",agent.adverContactRate);
			trace("quality assesment",agent.productQualityAssesment);
			trace("-------------------------------\n");
		}
		
		public function getShopData(agent:Shop):void
		{
			trace("---------------------------------");
			trace("shop-----------------------------");
			trace("id",agent.shopId);
			trace("district",agent.district);
			trace("adver",agent.advertising);
			trace("price",agent.price);
			trace("quality",agent.quality);
			
			trace("environment----------------------\n");
			trace("decoration",agent.decoration);
			trace("cleaness",agent.cleaness);
			trace("scent",agent.scent);
			
			trace("employee------------------------\n");
			trace("productivity",agent.productivity);
			trace("morale",agent.morale);
			trace("service",agent.service);
			
			trace("additional---------------------\n");
			trace("booster",agent.booster);
			trace("openingDiscount",agent.openingDiscount);
			trace("closingDiscount",agent.closingDiscount);
			trace("research",agent.businessResearch);
			trace("benefit",agent.employeeBenefit);
			trace("-------------------------------\n");
		}
		
	}
}