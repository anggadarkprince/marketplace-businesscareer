package sketchproject.modules
{

	/**
	 * Calculate motivation agent to make buying decision.
	 *
	 * @author Angga Ari Wijaya
	 */
	public class MotivationFunction
	{
		private var M:Number;
		private var Mmax:int;
		private var Mmin:int;
		private var PS:Number;
		private var P:Number;
		private var QS:Number;
		private var Q:Number;
		private var SUS:Number;
		private var AD:Number;
		private var FT:Number;
		private var INFL:Number;

		private var MList:Array;

		private var shopList:Array;
		private var agent:Agent;

		/**
		 * Default constructor of MotivationFunction.
		 *
		 * @param agent
		 * @param shop
		 */
		public function MotivationFunction(agent:Agent = null, shops:Array = null)
		{
			this.agent = agent;
			this.shopList = shops;
		}

		/**
		 * Getter final agent's motivation of brand i.
		 * @return Mi
		 */
		public function get m():Number
		{
			return this.M;
		}

		/**
		 * Setter final agent's motivation of brand i.
		 * @param Mi
		 */
		public function set m(Mi:Number):void
		{
			this.M = Mi;
		}

		/**
		 * Getter price sensitivity of brand i.
		 * @return PSi
		 */
		public function get ps():Number
		{
			return this.PS;
		}

		/**
		 * Setter price sensitivity of brand i.
		 * @param PSi
		 */
		public function set ps(PSi:Number):void
		{
			this.PS = PSi;
		}

		/**
		 * Getter price of brand i product i.
		 * @return Pi
		 */
		public function get p():Number
		{
			return this.P;
		}

		/**
		 * Setter price of brand i product i.
		 * @param Pi
		 */
		public function set p(Pi:Number):void
		{
			this.P = Pi;
		}

		/**
		 * Getter quality sensitivity of brand i.
		 * @return qsi
		 */
		public function get qs():Number
		{
			return this.QS;
		}

		/**
		 * Setter quality sensitivity of brand i.
		 * @param QSi
		 */
		public function set qs(QSi:Number):void
		{
			this.QS = QSi;
		}

		/**
		 * Getter quality of brand i product i
		 * @return qi
		 */
		public function get q():Number
		{
			return this.Q;
		}

		/**
		 * Setter quality of brand i product i.
		 * @param Qi
		 */
		public function set q(Qi:Number):void
		{
			this.Q = Qi;
		}

		/**
		 * Getter susceptibility agent to brand's advertisement.
		 * @return susi
		 */
		public function get sus():Number
		{
			return this.SUS;
		}

		/**
		 * Setter susceptibility agent to brand's advertisement.
		 * @param susi
		 */
		public function set sus(susi:Number):void
		{
			this.SUS = susi;
		}

		/**
		 * Getter advertising intensity of brand i.
		 * @return adi
		 */
		public function get ad():Number
		{
			return this.AD;
		}

		/**
		 * Setter advertising intensity of brand i.
		 * @param adi
		 */
		public function set ad(adi:Number):void
		{
			this.AD = adi;
		}

		/**
		 * Getter agent's follower tendency of the perceived influence to brand i.
		 * @return fti
		 */
		public function get ft():Number
		{
			return this.FT;
		}

		/**
		 * Setter agent's follower tendency of the perceived influence to brand i.
		 * @param fti
		 */
		public function set ft(fti:Number):void
		{
			this.FT = fti;
		}

		/**
		 * Getter perceived influence exerted by other agents to brand i.
		 * @return
		 */
		public function get infl():Number
		{
			return this.INFL;
		}

		/**
		 * Setter perceived influence exerted by other agents to brand i.
		 * @param infli
		 */
		public function set infl(infli:Number):void
		{
			this.INFL = infli;
		}

		/**
		 * Calculate motivation function of agent to produce decision of product.
		 *
		 * @param shop list collection of shops
		 * @param agent that make decision
		 * @param product selection
		 */
		public function motivation(shops:Array, agent:Agent, product:String):Shop
		{
			MList = [];

			for (var i:int = 0; i < shops.length; i++)
			{
				// calculate price of product
				p = calculateProductPrice(shops[i], product);

				// calculate price average of product in all shops
				var pave:Number = calaculatePriceAvarage(shops, product);

				// calculate agent's product sensitivy against product price
				ps = calculatePriceSensitivity(agent, P, pave);

				// calculate product quality by find out product component 
				q = calculateProductQuality(shops[i], agent, product);

				// calculate quality average of product in all shops
				var qave:Number = calculateQualityAverage(shops, agent, product);

				// calculate agent's quality sensitivity against product quality 
				qs = calculateQualitySensitivity(agent, Q, qave);

				// find susceptibility of brand advertisement to agent
				sus = susceptibility(agent);

				// find advertisement intensity of brand i
				ad = advertising(shops[i], agent);

				// find follower tendency of perceived influence by other agent regarding brand i
				ft = followerTendency(agent);

				// find perceived influence from other agent to brand i
				infl = influence(agent, i + 1);

				// calculate motivation function of brand i
				m = (ps * p) + (qs * q) + (sus * ad) + (ft * infl);

				// save current brand motivation related shop
				MList.push(m);
			}

			Mmax = maxM(MList);

			agent.choice = MList.indexOf(Mmax) + 1;
			agent.unselected = MList.indexOf(Mmin) + 1;
			agent.choiceReaction(agent.choice);

			shops[agent.choice - 1].transactionTotal += 1;
			shops[agent.choice - 1].grossProfit += calculateProductPrice;

			return shops[agent.choice - 1];
		}

		/**
		 * Calculate product by component and material.
		 *
		 * @param shop collection
		 * @param product will be selected
		 * @return product price
		 */
		public function calculateProductPrice(shop:Shop, product:String):Number
		{
			switch (product)
			{
				case Shop.PRODUCT_FOOD_1:
					return shop.price.food1;
					break;
				case Shop.PRODUCT_FOOD_2:
					return shop.price.food2;
					break;
				case Shop.PRODUCT_FOOD_3:
					return shop.price.food3;
					break;
				case Shop.PRODUCT_DRINK_1:
					return shop.price.drink1;
					break;
				case Shop.PRODUCT_DRINK_2:
					return shop.price.drink2;
					break;
				default:
					throw new ArgumentError("One product must be selected");
					break;
			}
			return 0;
		}

		/**
		 * Find out expected price of product.
		 *
		 * @param shop collection of brand
		 * @param product selected
		 * @return price average
		 */
		public function calaculatePriceAvarage(shop:Array, product:String):Number
		{
			var total:Number = 0;
			for (var i:int = 0; i < shop.length; i++)
			{
				total += calculateProductPrice(shop[i] as Shop, product);
			}
			return total / shop.length;
		}

		/**
		 * Calculate price sensitivity agent by product.
		 *
		 * @param agent that evaluate sensitivity
		 * @param pi price product i
		 * @param pavei price average product i in all shops
		 * @return price sensitivity
		 */
		public function calculatePriceSensitivity(agent:Agent, pi:Number, pavei:Number):Number
		{
			return Math.pow(agent.buyingPower, ((pi - pavei) * -1)) + agent.priceSensitivity;
		}

		/**
		 * Calculate quality by product and measure how important
		 * part of quality to an agent.
		 *
		 * @param shop collection
		 * @param agent that evaluate how important the quality
		 * @param product that will be selected
		 * @return product quality
		 */
		public function calculateProductQuality(shop:Shop, agent:Agent, product:String):Number
		{
			var total:Number = 0;
			var j:int = 0;
			switch (product)
			{
				case Shop.PRODUCT_FOOD_1:
					for (j = 0; j < shop.quality.food1.length; j++)
					{
						total += shop.quality.food1[j] * agent.productQualityAssesment.food1[j];
					}
					return total / shop.quality.food1.length;
					break;
				case Shop.PRODUCT_FOOD_2:
					for (j = 0; j < shop.quality.food2.length; j++)
					{
						total += shop.quality.food2[j] * agent.productQualityAssesment.food2[j];
					}
					return total / shop.quality.food2.length;
					break;
				case Shop.PRODUCT_FOOD_3:
					for (j = 0; j < shop.quality.food3.length; j++)
					{
						total += shop.quality.food3[j] * agent.productQualityAssesment.food3[j];
					}
					return total / shop.quality.food3.length;
					break;
				case Shop.PRODUCT_DRINK_1:
					for (j = 0; j < shop.quality.drink1.length; j++)
					{
						total += shop.quality.drink1[j] * agent.productQualityAssesment.drink1[j];
					}
					return total / shop.quality.drink1.length;
					break;
				case Shop.PRODUCT_DRINK_2:
					for (j = 0; j < shop.quality.drink2.length; j++)
					{
						total += shop.quality.drink2[j] * agent.productQualityAssesment.drink2[j];
					}
					return total / shop.quality.drink2.length;
					break;
				default:
					throw new ArgumentError("One product must be selected");
					break;
			}
			return 0;
		}

		/**
		 * Calculate quality average in all shops.
		 *
		 * @param shop collection
		 * @param agent that evaluate the quality
		 * @param product that will be selected
		 * @return quality average
		 */
		public function calculateQualityAverage(shop:Array, agent:Agent, product:String):Number
		{
			var total:Number = 0;
			for (var i:int = 0; i < shop.length; i++)
			{
				total += calculateProductQuality(shop[i] as Shop, agent, product);
			}
			return total / shop.length;
		}

		/**
		 * Calculate quality sensitivity agent by product.
		 *
		 * @param agent that evaluate sensitivity
		 * @param qi quality of product i
		 * @param qavei quality avarage
		 * @return quality sensitivity
		 */
		public function calculateQualitySensitivity(agent:Agent, qi:Number, qavei:Number):Number
		{
			return Math.pow(agent.buyingPower, Math.abs(qi - qavei)) + agent.qualitySensitivity;
		}

		/**
		 * Find out how vulnerable agent against advertisement.
		 *
		 * @param agent that evaluate susceptibility
		 * @return susceptibility
		 */
		public function susceptibility(agent:Agent):Number
		{
			return agent.susceptibility;
		}

		/**
		 * Calculate agent interest about advertisement.
		 * 
		 * @param shop current shop
		 * @param agent that evaluate the advertisement
		 * @return advertisement intensivity
		 */
		public function advertising(shop:Shop, agent:Agent):Number
		{
			var total:Number = 0;	
			for(var advertisement:String in shop.advertising)
			{
				total += shop.advertising[advertisement] * agent.adverContactRate[advertisement];
			}
			return total / 6;
		}


		/**
		 * Find out how vulnerable agent against influence.
		 *
		 * @param agent that evaluate follower tendency
		 * @return follower tendency
		 */
		public function followerTendency(agent:Agent):Number
		{
			return agent.followerTendency;
		}

		/**
		 * Find out how agent receive the influence each shop.
		 *
		 * @param agent that evaluate the influence
		 * @param shop current evaluation
		 * @return influence
		 */
		public function influence(agent:Agent, shop:int):Number
		{
			switch (shop)
			{
				case 1:
					return agent.shopInfluence.shopPlayer.recommendation - agent.shopInfluence.shopPlayer.disqualification;
					break;
				case 2:
					return agent.shopInfluence.shopCompetitor1.recommendation - agent.shopInfluence.shopCompetitor1.disqualification;
					break;
				case 3:
					return agent.shopInfluence.shopCompetitor2.recommendation - agent.shopInfluence.shopCompetitor2.disqualification;
					break;
			}
			return 0;
		}

		/**
		 * Find out max motivation of agent to select one of shops.
		 *
		 * @param data motivation collection
		 * @return max value
		 */
		public function maxM(data:Array):int
		{
			Mmax = data[0];
			Mmin = data[0];

			for (var i:int = 0; i < data.length; i++)
			{
				if (data[i] > Mmax)
				{
					Mmax = data[i];
				}
				if (data[i] < Mmin)
				{
					Mmin = data[i];
				}
			}

			return Mmax;
		}
	}
}
