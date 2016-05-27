package sketchproject.modules
{
	import flash.geom.Point;
	
	import sketchproject.core.Config;

	public class Shop
	{		
		// shop
		public var shopId:int;
		public var district:String;
		public var districtCoordinate:Point;
		public var advertising:Array;
		public var price:Array;
		public var quality:Array;
		
		// environment
		public var decoration:Array;
		public var cleaness:Array;
		public var scent:Array;
		
		// employee
		public var productivity:int;
		public var morale:int;
		public var service:int;
		
		// additional
		public var booster:Array;
		public var openingDiscount:Boolean;
		public var closingDiscount:Boolean;
		public var businessResearch:int;
		public var employeeBenefit:int;
		
		public var marketshare:Number;
		public var listshare:Array;
		public var maxshare:Number;
		public var avgshare:Number;
		
		public var transactionTotal:int;
		public var grossProfit:int;
		public var listprofit:Array;
		
		public function Shop(shopId:int, district:String)
		{
			this.shopId = shopId;
			this.district = district;
			
			for (var i:int=0; i<Config.district.length; i++)
			{
				if(district == Config.district[i][1])
				{
					districtCoordinate = Config.district[i][8] as Point;						
				}
			}
			
			marketshare = maxshare = avgshare = transactionTotal = grossProfit = 0;
			listshare = new Array(marketshare);
			listprofit = new Array(0);
		}	
		
		public function updateProfit():void
		{
			this.listprofit.push(grossProfit);
		}
		
		public function updateMarkershare(marketshare:int):void
		{
			this.marketshare = marketshare;
			this.listshare.push(marketshare);
		}
		
		public function updateShareMax():Number{
			maxshare = (marketshare>maxshare)?marketshare:maxshare;
			return maxshare;
		}
		
		public function updateShareAverage():Number
		{			
			avgshare = 0;
			for(var i:int = 0; i<listshare.length; i++)
			{
				avgshare += listshare[i] as int;
			}
			avgshare = Number((avgshare/listshare.length).toFixed(2));
			return avgshare;
		}
	}
}