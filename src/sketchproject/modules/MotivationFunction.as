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
			MList = new Array();

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
				infl = influence(shops[i], agent);

				// calculate motivation function of brand i
				m = (ps * p) + (qs * q) + (sus * ad) + (ft * infl);

				// save current brand motivation related shop index
				MList.push(m);
			}

			// calculate max and min motivation of shops selection
			Mmax = calculateM(MList);

			var indexMax:int = MList.indexOf(Mmax);
			var indexMin:int = MList.indexOf(Mmin);

			var shopMax:Shop = shops[indexMax];
			var shopMin:Shop = shops[indexMin];

			agent.choice = shopMax.shopId;
			agent.unselected = shopMin.shopId;

			return shopMax;
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
			for (var productName:String in shop.price)
			{
				if (productName == product)
				{
					return shop.price[product];
				}
			}

			throw new ArgumentError("One available product price must be selected");
		}

		/**
		 * Find out expected price of product.
		 *
		 * @param shop collection of brand
		 * @param product selected
		 * @return price average
		 */
		public function calaculatePriceAvarage(shops:Array, product:String):Number
		{
			if (shops == null || shops.length == 0)
			{
				throw new ArgumentError("shop data should at least 1 available");
			}

			var total:Number = 0;
			for (var i:int = 0; i < shops.length; i++)
			{
				total += calculateProductPrice(shops[i] as Shop, product);
			}
			return total / shops.length;
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
			return Math.pow(-agent.buyingPower, (pi - pavei)) + agent.priceSensitivity;
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

			for (var quality:String in shop.quality)
			{
				if (quality == product)
				{
					for (j = 0; j < shop.quality[product].length; j++)
					{
						total += shop.quality[product][j] * agent.productQualityAssesment[product][j];
					}
					return total / shop.quality[product].length;
				}
			}

			throw new ArgumentError("One available product quality must be selected");
		}

		/**
		 * Calculate quality average in all shops.
		 *
		 * @param shop collection
		 * @param agent that evaluate the quality
		 * @param product that will be selected
		 * @return quality average
		 */
		public function calculateQualityAverage(shops:Array, agent:Agent, product:String):Number
		{
			if (shops == null || shops.length == 0)
			{
				throw new ArgumentError("shop data should at least 1 available");
			}

			var total:Number = 0;
			for (var i:int = 0; i < shops.length; i++)
			{
				total += calculateProductQuality(shops[i] as Shop, agent, product);
			}
			return total / shops.length;
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
			var totalAdver:uint = 0;
			for (var advertisement:String in shop.advertising)
			{
				total += shop.advertising[advertisement] * agent.adverContactRate[advertisement];
				totalAdver++;
			}
			return total / totalAdver;
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
		public function influence(shop:Shop, agent:Agent):Number
		{
			switch (shop.shopId)
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
				default:
					return 0;
			}
		}

		/**
		 * Find out max motivation of agent to select one of shops.
		 *
		 * @param data motivation collection
		 * @return max value
		 */
		public function calculateM(motivationData:Array):int
		{
			if (motivationData == null || motivationData.length == 0)
			{
				throw new ArgumentError("motivation data cannot be null or empty");
			}

			Mmax = motivationData[0];
			Mmin = motivationData[0];

			for (var i:int = 0; i < motivationData.length; i++)
			{
				if (motivationData[i] > Mmax)
				{
					Mmax = motivationData[i];
				}
				if (motivationData[i] < Mmin)
				{
					Mmin = motivationData[i];
				}
			}

			return Mmax;
		}
	}
}
