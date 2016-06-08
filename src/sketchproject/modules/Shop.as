package sketchproject.modules
{
	import flash.geom.Point;

	import sketchproject.core.Config;

	/**
	 * Shop entity.
	 *
	 * @author Angga
	 */
	public class Shop
	{
		public static const PRODUCT_FOOD_1:String = "food1";
		public static const PRODUCT_FOOD_2:String = "food2";
		public static const PRODUCT_FOOD_3:String = "food3";
		public static const PRODUCT_DRINK_1:String = "drink1";
		public static const PRODUCT_DRINK_2:String = "drink2";

		public static var productList:Array = new Array(PRODUCT_FOOD_1, PRODUCT_FOOD_2, PRODUCT_FOOD_3, PRODUCT_DRINK_1, PRODUCT_DRINK_2);

		// shop
		public var shopId:int;
		public var shopName:String;
		public var district:String;
		public var districtCoordinate:Point;
		public var advertising:Object;
		public var price:Object;
		public var quality:Object;

		// environment
		public var decoration:Object;
		public var cleaness:Object;
		public var scent:Object;

		// employee
		public var productivity:Array;
		public var morale:Array;
		public var service:Array;

		// research
		public var businessResearch:Object;
		public var employeeBenefit:Object;

		// additional
		public var booster:Object;
		public var openingDiscount:Boolean;
		public var closingDiscount:Boolean;

		public var marketshare:Number;
		public var listshare:Array;
		public var maxshare:Number;
		public var avgshare:Number;

		public var transactionTotal:int;
		public var grossProfit:int;
		public var listprofit:Array;

		/**
		 * Default constructor of Shop.
		 *
		 * @param shopId
		 * @param district
		 */
		public function Shop(shopId:int, district:String)
		{
			this.shopId = shopId;
			this.district = district;

			for (var i:int = 0; i < Config.district.length; i++)
			{
				if (district == Config.district[i][1])
				{
					districtCoordinate = Config.district[i][8] as Point;
				}
			}

			marketshare = maxshare = avgshare = transactionTotal = grossProfit = 0;
			listshare = new Array(marketshare);
			listprofit = new Array(0);
		}

		/**
		 * Take snapshot of current profit.
		 */
		public function updateProfit():void
		{
			this.listprofit.push(grossProfit);
		}

		/**
		 * Take snapshot of current marketshare.
		 *
		 * @param marketshare
		 */
		public function updateMarkershare(marketshare:int):void
		{
			this.marketshare = marketshare;
			this.listshare.push(marketshare);
		}

		/**
		 * Find out max of last market share.
		 *
		 * @return
		 */
		public function updateShareMax():Number
		{
			maxshare = (marketshare > maxshare) ? marketshare : maxshare;
			return maxshare;
		}

		/**
		 * Update average of market share along simulation.
		 *
		 * @return
		 */
		public function updateShareAverage():Number
		{
			avgshare = 0;
			for (var i:int = 0; i < listshare.length; i++)
			{
				avgshare += listshare[i] as int;
			}
			avgshare = Number((avgshare / listshare.length).toFixed(2));
			return avgshare;
		}

		/**
		 * Print shop data
		 */
		public function getShopData():void
		{
			trace("[Shop] --------------------------");
			trace("---------------------------------");
			trace("-- basic ------------------------");
			trace("---- id", shopId);
			trace("---- name", shopName);
			trace("---- district", district);

			trace("-- advertisment -----------------");
			trace("---- adver tv", advertising.tv);
			trace("---- adver radio", advertising.radio);
			trace("---- adver newspaper", advertising.newspaper);
			trace("---- adver internet", advertising.internet);
			trace("---- adver event", advertising.event);
			trace("---- adver billboard", advertising.billboard);

			trace("-- price ------------------------");
			trace("---- price food 1", price.food1);
			trace("---- price food 2", price.food2);
			trace("---- price food 3", price.food3);
			trace("---- price drink 1", price.drink1);
			trace("---- price drink 2", price.drink2);

			trace("-- quality ----------------------");
			trace("---- quality food 1", quality.food1);
			trace("---- quality food 2", quality.food2);
			trace("---- quality food 3", quality.food3);
			trace("---- quality drink 1", quality.drink1);
			trace("---- quality drink 2", quality.drink2);

			trace("-- environment ------------------");
			trace("---- decoration", decoration.modern, decoration.colorfull, decoration.vintage);
			trace("---- cleaness", cleaness.product, cleaness.place);
			trace("---- scent", scent.ginger, scent.jasmine, scent.rosemary);

			trace("-- employee ---------------------");
			trace("---- productivity", productivity);
			trace("---- morale", morale);
			trace("---- service", service);

			trace("-- booster ----------------------");
			trace("---- shop", booster.shop);
			trace("---- product", booster.product);
			trace("---- employee", booster.employee);
			trace("---- lucky", booster.lucky);

			trace("-- research ---------------------");
			trace("---- marketing", businessResearch.marketing);
			trace("---- service", businessResearch.service);
			trace("---- pos", businessResearch.pos);
			trace("---- product", businessResearch.product);
			trace("---- facility", businessResearch.facility);

			trace("-- incentive --------------------");
			trace("---- reward", employeeBenefit.reward);
			trace("---- career", employeeBenefit.career);
			trace("---- culture", employeeBenefit.culture);
			trace("---- personalization", employeeBenefit.personalization);
			trace("---- management", employeeBenefit.management);

			trace("-- benefit ----------------------");
			trace("---- health", employeeBenefit.health);
			trace("---- education", employeeBenefit.education);
			trace("---- additional financial", employeeBenefit.financial);
			trace("---- police practice", employeeBenefit.practice);

			trace("-- statistic --------------------");
			trace("---- marketshare", marketshare);
			trace("---- profit", grossProfit);
			trace("---- transaction", transactionTotal);
			trace("---------------------------------\n");
		}
	}
}
