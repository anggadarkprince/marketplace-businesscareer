package sketchproject.modules
{
	import sketchproject.utilities.GameUtils;

	/**
	 * Decision maker to select a product.
	 *
	 * @author Angga
	 */
	public class DecisionFunction
	{
		/**
		 * Default controller of DecisionFunction
		 */
		public function DecisionFunction()
		{
		}

		/**
		 * Select shop by the most influenced agent.
		 *
		 * @param shopList shop collection
		 * @param agent that evaluate the influence
		 * @return most influencing agent
		 */
		public function influenceSelection(shopList:Array, agent:Agent):Shop
		{
			var inflShopPlayer:int = agent.shopInfluence.shopPlayer.recommendation - agent.shopInfluence.shopPlayer.disqualification;
			var inflShopCompetitor1:int = agent.shopInfluence.shopCompetitor1.recommendation - agent.shopInfluence.shopCompetitor1.disqualification;
			var inflShopCompetitor2:int = agent.shopInfluence.shopCompetitor2.recommendation - agent.shopInfluence.shopCompetitor2.disqualification;

			if (inflShopPlayer > inflShopCompetitor1)
			{
				if (inflShopPlayer > inflShopCompetitor2)
				{
					return shopList[0];
				}
				else
				{
					return shopList[2];
				}
			}
			else
			{
				if (inflShopCompetitor1 > inflShopCompetitor2)
				{
					return shopList[1];
				}
				else
				{
					return shopList[2];
				}
			}
		}

		/**
		 * Select shop for neutral agent.
		 *
		 * @param shopList collection
		 * @param agent that evaluate the selection
		 * @return accidental selection
		 */
		public function accidentalSelection(shopList:Array, agent:Agent):Shop
		{
			var selectedShop:Shop;
			var probability:int = GameUtils.randomFor(100);

			// 25% random choice
			if (probability <= 25)
			{
				probability = GameUtils.randomFor(100);
				// 50% uniform random
				if (probability <= 50)
				{
					selectedShop = selectRandomShop(shopList);
				}
				// 50% lucky random supported by booster feature
				else
				{
					selectedShop = selectRandomLucky(shopList);
				}

				agent.perceptReaction("satisfaction");
			}
			// 50% consumer basic
			else if (probability <= 75)
			{
				probability = GameUtils.randomFor(100);
				// 30% nearest location
				if (probability <= 30)
				{
					selectedShop = selectNearestShop(shopList, agent);
					agent.perceptReaction("satisfaction");
				}
				// 10% top seller
				else if (probability <= 40)
				{
					selectedShop = selectMostPopularShop(shopList);
					agent.perceptReaction("satisfaction");
				}
				// 25% lowest price
				else if (probability <= 65)
				{
					selectedShop = selectCheapestShop(shopList);
					agent.perceptReaction("price");
				}
				// 20% best quality
				else if (probability <= 85)
				{
					selectedShop = selectFinestShop(shopList, agent);
					agent.perceptReaction("quality");
				}
				// 15% best all features
				else
				{
					selectedShop = selectBestShop(shopList, agent);
					agent.perceptReaction("satisfaction");
				}
			}
			// 25% shop feature
			else
			{
				probability = GameUtils.randomFor(100);
				// 25% good service according agent trait
				if (probability <= 25)
				{
					selectedShop = selectGoodService(shopList, agent);
				}
				// 25% comfort environment according agent trait
				else if (probability <= 50)
				{
					selectedShop = selectGoodEnvironment(shopList, agent);
				}
				// 25% intense advertising according agent trait
				else if (probability <= 75)
				{
					selectedShop = selectIntenseAdvertising(shopList, agent);
				}
				// 25% most active feature
				else
				{
					selectedShop = selectAdvancedShop(shopList);
				}
			}

			agent.perceptReaction("service");

			return selectedShop;
		}

		/**
		 * Select a shop randomly.
		 *
		 * @param shopList shop collection
		 * @return random shop
		 */
		public function selectRandomShop(shopList:Array):Shop
		{
			return shopList[GameUtils.randomFor(shopList.length) - 1];
		}

		/**
		 * Select random affecting by booster lucky.
		 *
		 * @param shopList collection
		 * @return lucky shop
		 */
		public function selectRandomLucky(shopList:Array):Shop
		{
			var total:Number = 0;
			var luckyShop:Shop;

			// get total lucky of all shops
			for (var i:int = 0; i < shopList.length; i++)
			{
				var shop:Shop = shopList[i] as Shop;
				total += shop.booster.lucky;
			}

			// if no shop use lucky booster, just call uniform random
			if (total == 0)
			{
				return selectRandomShop(shopList);
			}

			// distribute into percent
			var luckyShop1:Number = shopList[0].booster.lucky / total * 100;
			var luckyShop2:Number = shopList[1].booster.lucky / total * 100;
			var luckyShop3:Number = shopList[2].booster.lucky / total * 100;

			// produce probability event by the precentage of lucky shop
			var random:Number = GameUtils.randomFor(100);
			if (random <= luckyShop1)
			{
				luckyShop = shopList[0];
			}
			else if (random <= (luckyShop1 + luckyShop2))
			{
				luckyShop = shopList[1];
			}
			else
			{
				luckyShop = shopList[2];
			}

			return luckyShop;
		}

		/**
		 * Select the nearest shop from agent location.
		 *
		 * @param shopList shop collection
		 * @param agent that makes decision
		 * @return selected shop
		 */
		public function selectNearestShop(shopList:Array, agent:Agent):Shop
		{
			var nearest:int = int.MAX_VALUE;
			var nearestShop:Shop;
			for (var i:uint = 0; i < shopList.length; i++)
			{
				var shop:Shop = shopList[i] as Shop;

				// get delta x and delta y from two point
				var dx:int = agent.coordinate.x - shop.districtCoordinate.x;
				var dy:int = agent.coordinate.y - shop.districtCoordinate.y;

				// calculate distance delta x and delta y
				var distance:Number = GameUtils.getDistance(dx, dy);
				if (distance < nearest)
				{
					nearest = distance;
					nearestShop = shop;
				}
			}

			return nearestShop;
		}

		/**
		 * Select the most popular shop by total product selling.
		 *
		 * @param shopList shop collection
		 * @return popular shop
		 */
		public function selectMostPopularShop(shopList:Array):Shop
		{
			var mostPopular:int = -1000000;
			var popularShop:Shop;
			for (var i:uint = 0; i < shopList.length; i++)
			{
				var shop:Shop = shopList[i] as Shop;

				if (shop.transactionTotal > mostPopular)
				{
					mostPopular = shop.transactionTotal;
					popularShop = shop;
				}
			}

			return popularShop;
		}

		/**
		 * Select cheapest shop by calculate average all products.
		 *
		 * @param shopList collection
		 * @return cheapest shop
		 */
		public function selectCheapestShop(shopList:Array):Shop
		{
			var cheapest:Number = Number.MAX_VALUE;
			var cheapestShop:Shop;
			var priceAvg:Number;

			var motivation:MotivationFunction = new MotivationFunction();

			for (var i:int = 0; i < shopList.length; i++)
			{
				var shop:Shop = shopList[i] as Shop;
				var food1:Number = motivation.calculateProductPrice(shop, Shop.PRODUCT_FOOD_1);
				var food2:Number = motivation.calculateProductPrice(shop, Shop.PRODUCT_FOOD_2);
				var food3:Number = motivation.calculateProductPrice(shop, Shop.PRODUCT_FOOD_3);
				var drink1:Number = motivation.calculateProductPrice(shop, Shop.PRODUCT_DRINK_1);
				var drink2:Number = motivation.calculateProductPrice(shop, Shop.PRODUCT_DRINK_2);

				priceAvg = (food1 + food2 + food3 + drink1 + drink2) / 5;
				if (priceAvg < cheapest)
				{
					cheapest = priceAvg;
					cheapestShop = shop;
				}
			}

			return cheapestShop;
		}

		/**
		 * Select finest quallity of product in all shop.
		 *
		 * @param shopList collection
		 * @param agent that evaluate the quality
		 * @return finest shop
		 */
		public function selectFinestShop(shopList:Array, agent:Agent):Shop
		{
			var finest:Number = -1000000;
			var finestShop:Shop;
			var finestAvg:Number;

			var motivation:MotivationFunction = new MotivationFunction();

			for (var i:int = 0; i < shopList.length; i++)
			{
				var shop:Shop = shopList[i] as Shop;

				// retrieve quality and agent assessment
				var food1:Number = motivation.calculateProductQuality(shop, agent, Shop.PRODUCT_FOOD_1);
				var food2:Number = motivation.calculateProductQuality(shop, agent, Shop.PRODUCT_FOOD_2);
				var food3:Number = motivation.calculateProductQuality(shop, agent, Shop.PRODUCT_FOOD_3);
				var drink1:Number = motivation.calculateProductQuality(shop, agent, Shop.PRODUCT_DRINK_1);
				var drink2:Number = motivation.calculateProductQuality(shop, agent, Shop.PRODUCT_DRINK_2);

				finestAvg = (food1 + food2 + food3 + drink1 + drink2) / 5;

				// calculate product booster
				var productBooster:Number = 1 + (shop.booster.product * 0.25 / 10);

				// add booster to multiple the quality of product
				finestAvg *= productBooster;

				if (finestAvg > finest)
				{
					finest = finestAvg;
					finestShop = shop;
				}
			}

			return finestShop;
		}

		/**
		 * Select shop by services average.
		 *
		 * @param shopList collection
		 * @param agent that evaluate the services
		 * @return shop
		 */
		public function selectGoodService(shopList:Array, agent:Agent):Shop
		{
			var service:Number = -1000000;
			var serviceShop:Shop;
			var serviceAvg:Number;

			for (var i:int = 0; i < shopList.length; i++)
			{
				var shop:Shop = shopList[i] as Shop;

				var productivityEval:Number = 0;
				var moraleEval:Number = 0;
				var serviceEval:Number = 0;

				for (var j:int = 0; j < shop.productivity; j++)
				{
					productivityEval += shop.productivity[j] * agent.serviceResponseAssesment.productivity;
					moraleEval += shop.productivity[j] * agent.serviceResponseAssesment.morale;
					serviceEval += shop.productivity[j] * agent.serviceResponseAssesment.services;
				}

				serviceAvg = (productivityEval + moraleEval + serviceEval) / 3;

				// calculate employee booster
				var employeeBooster:Number = 1 + (shop.booster.employee * 0.25 / 10);

				// add booster to multiple the services of employee
				serviceAvg *= employeeBooster;

				if (serviceAvg > service)
				{
					service = serviceAvg;
					serviceShop = shop;
				}
			}

			return serviceShop;
		}

		/**
		 * Select shop by max environment assessment.
		 *
		 * @param shopList collection
		 * @param agent that evaluate the environment
		 * @return shop with ideal environment by agent
		 */
		public function selectGoodEnvironment(shopList:Array, agent:Agent):Shop
		{
			var environment:Number = -1000000;
			var environmentShop:Shop;
			var environmentAvg:Number;

			for (var i:int = 0; i < shopList.length; i++)
			{
				var shop:Shop = shopList[i] as Shop;

				// calculate decoration and agent assessment
				var decorationTotal:Number = 0;
				for (var decoration:String in shop.decoration)
				{
					decorationTotal += shop.decoration[decoration] * agent.decorationMatch[decoration];
				}

				// calculate cleaness and agent assessment
				var cleanessTotal:Number = 0;
				for (var cleaness:String in shop.cleaness)
				{
					cleanessTotal += shop.cleaness[cleaness] * agent.cleanessMatch[cleaness];
				}

				// calculate scent and agent assessment
				var scentTotal:Number = 0;
				for (var scent:String in shop.scent)
				{
					scentTotal += shop.scent[scent] * agent.scentMatch[scent];
				}

				environmentAvg = (decorationTotal + cleanessTotal + scentTotal) / 3;

				// calculate shop booster
				var shopBooster:Number = 1 + (shop.booster.shop * 0.25 / 10);

				// add booster to multiple the shop environment
				environmentAvg *= shopBooster;

				if (environmentAvg > environment)
				{
					environment = environmentAvg;
					environmentShop = shop;
				}
			}

			return environmentShop;
		}

		/**
		 * Select shop by max agent interest about shop advertisement.
		 *
		 * @param shopList collection
		 * @param agent that evaluate the advertisement
		 * @return most intense shop
		 */
		public function selectIntenseAdvertising(shopList:Array, agent:Agent):Shop
		{
			var intenseAdvertisement:Number = -1000000;
			var intenseShop:Shop;

			var motivation:MotivationFunction = new MotivationFunction();

			for (var i:int = 0; i < shopList.length; i++)
			{
				var shop:Shop = shopList[i] as Shop;
				var adver:Number = motivation.advertising(shop, agent);
				if (adver > intenseAdvertisement)
				{
					intenseAdvertisement = adver;
					intenseShop = shop;
				}
			}

			return intenseShop;
		}

		/**
		 * Select shop by total of active feature.
		 *
		 * @param shopList collection
		 * @return advanced shop
		 */
		public function selectAdvancedShop(shopList:Array):Shop
		{
			var advancedShop:Shop;
			var advanced:Number = -1000000;

			for (var i:int = 0; i < shopList.length; i++)
			{
				var shop:Shop = shopList[i] as Shop;
				var total:Number = 0;
				for (var research:String in shop.businessResearch)
				{
					total += shop.businessResearch[research];
				}
				for (var benefit:String in shop.employeeBenefit)
				{
					total += shop.employeeBenefit[benefit];
				}

				if (total > advanced)
				{
					advanced = total;
					advancedShop = shop;
				}
			}

			return advancedShop;
		}

		/**
		 * Select most advanced shop by evaluating all aspects.
		 *
		 * @param shopList collection
		 * @param agent that evaluate the aspect
		 * @return advanced shop
		 */
		public function selectBestShop(shopList:Array, agent:Agent):Shop
		{
			var bestShops:Array = new Array(0, 0, 0);
			var bestShop:Shop;

			var nearestShop:Shop = selectNearestShop(shopList, agent);
			bestShops[nearestShop.shopId - 1]++;

			var mostPopular:Shop = selectMostPopularShop(shopList);
			bestShops[mostPopular.shopId - 1]++;

			var cheapestShop:Shop = selectCheapestShop(shopList);
			bestShops[cheapestShop.shopId - 1]++;

			var finestShop:Shop = selectFinestShop(shopList, agent);
			bestShops[finestShop.shopId - 1]++;

			var goodServices:Shop = selectGoodService(shopList, agent);
			bestShops[goodServices.shopId - 1]++;

			var goodEnvironment:Shop = selectGoodEnvironment(shopList, agent);
			bestShops[goodEnvironment.shopId - 1]++;

			var intenseAdvertising:Shop = selectIntenseAdvertising(shopList, agent);
			bestShops[intenseAdvertising.shopId - 1]++;

			var advanceShop:Shop = selectAdvancedShop(shopList);
			bestShops[advanceShop.shopId - 1]++;

			if (bestShops[0] > bestShops[1])
			{
				if (bestShops[0] > bestShops[2])
				{
					bestShop = shopList[0];
				}
				else
				{
					bestShop = shopList[2];
				}
			}
			else
			{
				if (bestShops[1] > bestShops[2])
				{
					bestShop = shopList[1];
				}
				else
				{
					bestShop = shopList[2];
				}
			}

			// if results are equal pick random shop
			if (bestShops[0] == bestShops[1] && bestShops[0] == bestShops[2])
			{
				bestShop = selectRandomShop(shopList);
			}

			// if result shop id 1 and shop id 2 are equal, they have equal chance to be picked
			if ((bestShop.shopId == 1 || bestShop.shopId == 2) && bestShops[0] == bestShops[1])
			{
				if (GameUtils.probability(0.5))
				{
					bestShop = shopList[0];
				}
				else
				{
					bestShop = shopList[1];
				}
			}
			// if result shop id 1 and shop id 3 are equal, they have equal chance to be picked
			else if ((bestShop.shopId == 1 || bestShop.shopId == 3) && bestShops[0] == bestShops[2])
			{
				if (GameUtils.probability(0.5))
				{
					bestShop = shopList[0];
				}
				else
				{
					bestShop = shopList[2];
				}
			}
			// if result shop id 2 and shop id 3 are equal, they have equal chance to be picked
			else if ((bestShop.shopId == 2 || bestShop.shopId == 3) && bestShops[1] == bestShops[2])
			{
				if (GameUtils.probability(0.5))
				{
					bestShop = shopList[1];
				}
				else
				{
					bestShop = shopList[2];
				}
			}

			return bestShop;
		}
	}
}
