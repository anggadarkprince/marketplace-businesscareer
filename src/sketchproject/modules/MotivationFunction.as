package sketchproject.modules
{
	import sketchproject.managers.WorldManager;
	import sketchproject.states.Gameworld;

	/**
	 * ...
	 * @author Angga Ari Wijaya
	 */
	public class MotivationFunction 
	{
		public var M:Number;
		
		public var PS:Number;
		public var P:Number;
		public var QS:Number;
		public var Q:Number;
		public var SUS:Number;
		public var AD:Number;
		public var FT:Number;
		public var INFL:Number;
		
		public var MList:Array = [];
		
		public var shop:Array = [];
		public var agent:Agent;
				
		public function MotivationFunction() 
		{
			
		}	
		
		public function get m():Number
		{
			return this.M;
		}
		public function set m(Mi:Number):void
		{
			this.M = Mi;
		}
		
		public function get ps():Number
		{
			return this.PS;
		}
		public function set ps(PSi:Number):void
		{
			this.PS = PSi;
		}
		
		public function get p():Number
		{
			return this.P;
		}
		public function set p(Pi:Number):void
		{
			this.P = Pi;
		}
		
		public function get qs():Number
		{
			return this.QS;
		}
		public function set qs(QSi:Number):void
		{
			this.QS = QSi;
		}
		
		public function get q():Number
		{
			return this.Q;
		}
		public function set q(Qi:Number):void
		{
			this.Q = Qi;
		}
		
		public function get sus():Number
		{
			return this.SUS;
		}
		public function set sus(susi:Number):void
		{
			this.SUS = susi;
		}
		
		public function get ad():Number
		{
			return this.AD;
		}
		public function set ad(adi:Number):void
		{
			this.AD = adi;
		}
		
		public function get ft():Number
		{
			return this.FT;
		}
		public function set ft(fti:Number):void
		{
			this.FT = fti;
		}
		
		public function get infl():Number
		{
			return this.INFL;
		}
		public function set infl(infli:Number):void
		{
			this.INFL = infli;
		}
		
		
		/* motivation */
		
		public function motivation(shop:Array, agent:Agent, product:String):void
		{
			this.shop = shop;
			this.agent = agent;
			MList = [];
			for (var i:int = 0; i < shop.length; i++) 
			{
				
				// find Pi
				p = calculateProductPrice(shop[i], product);
				
				// find Pave
				var pave:Number = calaculatePriceAvarage(shop, product);
				
				// find PSi
				ps = calculatePriceSensitivity(agent, P, pave);
				
				// find Qi
				q = calculateProductQuality(shop[i], agent, product);
				
				// find Qave
				var qave:Number = calculateQualityAverage(shop, agent, product);
				
				// find QSi
				qs = calculateQualitySensitivity(agent, Q, qave);
						
				// find sus
				sus = susceptibility(agent);
				
				// find ad
				ad = advertising(shop[i], agent);
				
				// find ft
				ft = followerTendency(agent);
				
				// find infl
				infl = influence(agent, i);
								
				m = (ps * p) + (qs * q) + (sus * ad) + (ft * infl);
				
				MList.push(m);
				
				/*
				trace("price "+product+" : " + shop[i].priceA);
				trace("price "+product+" average : " + pave);
				trace("price sensitivity : " + ps);
				
				trace("quality " + product + " : " + q);
				trace("quality "+product+" average : " + qave);
				
				trace("quality sensitivity : " + qs);
				trace("sus : " + sus);
				trace("ad : " + ad);
				trace("ft : " + ft);
				trace("infl : " + infl);
				trace("m : " + m);
				trace("------------------------------");
				*/
			}
			
			trace(agent.agentId, "choice shop",shop[maxM(MList)].shopId);
			
			agent.choice = maxM(MList) + 1;
			shop[agent.choice-1].transactionTotal+=1;
			shop[agent.choice-1].grossProfit+=calculateProductPrice;
						
			if(agent.choice == 1){				
				agent.choiceReaction("player");
			}
			else if(agent.choice == 2){
				agent.choiceReaction("competitor1");
			}
			else if(agent.choice == 3){
				agent.choiceReaction("competitor2");
			}
		}
		
		/* find max of motivation against product */
		
		public function maxM(data:Array):int
		{
			var max:Number = data[0];
			for (var i:int = 0; i < data.length; i++) 
			{
				if (data[i] > max)
				{
					max = data[i];
				}
			}
			
			return MList.indexOf(max);
		}
		
					
		
		/* price function */
		
		public function calculatePriceSensitivity(agent:Agent, pi:Number, pavei:Number):Number
		{
			return Math.pow(agent.priceSensitivity, ((pi - pavei) * -1)) + agent.buyingPower;
		}
		
		public function calculateProductPrice(shop:Shop, product:String):Number
		{
			switch(product) {
				case "A":
					return shop.price.food1;
					break;
				case "B":
					return shop.price.food2;
					break;
				case "C":
					return shop.price.food3;
					break;
				case "D":
					return shop.price.drink1;
					break;
				case "E":
					return shop.price.drink2;
					break;
			}
			return 0;
		}
		
		public function calaculatePriceAvarage(shop:Array, product:String):Number
		{
			var total:Number = 0;
			for (var i:int = 0; i < shop.length; i++) 
			{
				total += calculateProductPrice(shop[i] as Shop, product);
			}
			return total / shop.length;
		}
		
		
		/* quality function */
		
		public function calculateQualitySensitivity(agent:Agent, qi:Number, qavei:Number):Number
		{
			return Math.pow(agent.qualitySensitivity, Math.abs(qi - qavei)) + agent.buyingPower;
		}
		
		public function calculateProductQuality(shop:Shop, agent:Agent, product:String):Number
		{
			var total:Number = 0;
			var j:int = 0;
			switch(product) {
				case "A":	
					for (j = 0; j < shop.quality.food1.length; j++) 
					{
						total += shop.quality.food1[j] * agent.productQualityAssesment.food1[j];
					}
					return total / shop.quality.food1.length;
					break;
				case "B":
					for (j = 0; j < shop.quality.food2.length; j++) 
					{
						total += shop.quality.food2[j] * agent.productQualityAssesment.food2[j];
					}
					return total / shop.quality.food2.length;
					break;
				case "C":
					for (j = 0; j < shop.quality.food3.length; j++) 
					{
						total += shop.quality.food3[j] * agent.productQualityAssesment.food3[j];
					}
					return total / shop.quality.food3.length;
					break;
				case "D":
					for (j = 0; j < shop.quality.drink1.length; j++) 
					{
						total += shop.quality.drink1[j] * agent.productQualityAssesment.drink1[j];
					}
					return total / shop.quality.drink1.length;
					break;
				case "E":
					for (j = 0; j < shop.quality.drink2.length; j++) 
					{
						total += shop.quality.drink2[j] * agent.productQualityAssesment.drink2[j];
					}
					return total / shop.quality.drink2.length;
					break;
			}
			return 0;
		}
		
		public function calculateQualityAverage(shop:Array, agent:Agent, product:String) :Number
		{
			var total:Number = 0;
			for (var i:int = 0; i < shop.length; i++) 
			{
				total += calculateProductQuality(shop[i] as Shop, agent, product);				
			}
			return total/shop.length;
		}
		
		
		
		/* susceptibility */
		
		public function susceptibility(agent:Agent):Number 
		{
			// theta value 9
			return agent.rejection;
		}
		
		
		
		/* advertising function */
		
		public function advertising(shop:Shop, agent:Agent):Number
		{
			var total:Number = 0;
			var ads:Number = 0;
			for (var ad:String in shop.advertising) {
				if (shop.advertising[ad] != 0)
				{
					total += shop.advertising[ad] * agent.adverContactRate[ad];
					ads++;
				}
			}
			if (ads != 0) {
				return total / ads;			
			}
			return 0;
		}
		
		
		
		/* follower function */
		
		public function followerTendency(agent:Agent):Number
		{
			// lambda value 30
			return agent.acceptance;
		}
		
		
		
		/* influence function */
		
		public function influence(agent:Agent, shopn:int):Number
		{
			switch(shopn){
				case 1:
					return agent.shopInfluence.shop1;
					break;
				case 2:
					return agent.shopInfluence.shop2;
					break;
				case 3:
					return agent.shopInfluence.shop3;
					break;
			}
			return 0;
		}
		
		
				
		public function service(shop:Shop, agent:Agent):Number
		{
			var serv:Number = agent.serviceResponseAssesment.service*shop.service;
			serv+=agent.serviceResponseAssesment.morale*shop.morale;
			serv+=agent.serviceResponseAssesment.productivity*shop.productivity;
			return serv;
		}
		
	}

}