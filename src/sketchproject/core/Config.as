package sketchproject.core
{	
	public class Config
	{
		/** settings **/
		public static var firstOpen:Boolean = true;
		public static var firstPlay:Boolean = false;
		public static var volbgm:uint = 0;
		public static var volsfx:uint = 0;
		public static var mode:String = "window";
		public static var zoom:Number = 1;
		
		/** list of day **/
		public static var days:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		
		/** map **/
		public static var levelPivot:Array;
		
		
		/**
		 * retirieve data from file XML
		 * move to temporary static variables
		 * master data that user cant change, just view and retrieve 
		 * **/
		
		/** 
		 * XML tips of the day 
		 * item.attribute("id"),
		 * item.title,
		 * item.content
		 * **/
		public static var tipsOfTheDay:Array = new Array();
		
		
		/** 
		 * XML weather 
		 * item.attribute("id"),
		 * item.name,
		 * item.min,
		 * item.max,
		 * item.probability,
		 * item.status
		 * **/
		public static var weather:Array = new Array();
		
		
		/** 
		 * XML event 
		 * item.attribute("id"),
		 * item.name,
		 * item.district,
		 * new Array(
		 * 	item.normal,
		 * 	item.weekend,
		 * 	item.holiday
		 * ),
		 * new Array(
		 * 	item.education,
		 * 	item.art,
		 *  item.athletic
		 * ),
		 * new Array(
		 * 	item.start,
		 * 	item.finish
		 * )
		 * **/
		public static var event:Array = new Array();
		
		
		/** 
		 * XML transaction 
		 * item.attribute("id"),
		 * item.type,
		 * item.name,
		 * item.hint,
		 * item.debit,
		 * item.credit,
		 * item.description,
		 * **/
		public static var transaction:Array = new Array();
		
		
		/** 
		 * XML district 
		 * item.attribute("id"),
		 * item.name,
		 * item.atlas,
		 * item.description,
		 * item.priority,
		 * new Array(
		 * 	item.population.low,
		 * 	item.population.normal,
		 * 	item.population.high
		 * ),
		 * new Array(
		 * 	item.marker.atlas,
		 * 	item.marker.x,
		 * 	item.marker.y
		 * ),
		 * item.cost,
		 * new Point(item.shop.x, item.shop.y)
		 * **/
		public static var district:Array = new Array();
			
		/** location district for select **/
		public static var location:Array = new Array();
		
		/** 
		 * XML advertisement 
		 * item.attribute("id"),
		 * item.name,
		 * item.atlas,
		 * new Array(
		 * 	item.none,
		 * 	item.low,
		 * 	item.average,
		 * 	item.high
		 * )
		 * **/
		public static var advertisement:Array = new Array();
		
		
		/** 
		 * XML research 
		 * item.attribute("id"),
		 * item.name,
		 * item.cost
		 * **/
		public static var research:Array = new Array();
		
			
		
		
		/**
		 * retirieve data from database
		 * move to temporary static variables
		 * master data that user cant change, just view and retrieve 
		 * **/
		
		/** account master for select **/
		public static var account:Array = new Array();
		
		/** material master **/
		public static var material:Array = new Array();		
		
		/** upgrade master **/
		public static var asset:Array = new Array();
		
		/** supplier master **/
		public static var supplier:Array = new Array();		
		
		/** candidate master **/
		public static var candidate:Array = new Array();
		
		/** temporary achievement **/
		public static var achieved:Array = new Array();
		
		
		
		/**
		 * daily information
		 * 
		 * **/
		
		/** initial/list pending transaction **/
		public static var transactionList:Array = new Array();
		
		
		/** marketshare information **/
		public static var marketShare:Array = new Array();
		
		public static var profit:Array = new Array();
		
		
		
		/** district coordinate **/
		public static var airportCoordinate:Array = [{"x":1, "y":19},{"x":2, "y":19},{"x":3, "y":19},{"x":4, "y":19},{"x":5, "y":19},{"x":5, "y":18}, {"x":5, "y":17}, {"x":5, "y":16},{"x":5, "y":15},{"x":5, "y":14},{"x":5, "y":13}];
		public static var schoolCoordinate:Array = [{"x":1, "y":12}, {"x":2, "y":12}, {"x":3, "y":12},{"x":4, "y":12},{"x":5, "y":11},{"x":5, "y":11},{"x":5, "y":10},{"x":5, "y":8},{"x":5, "y":7}];
		public static var timesSquareCoordinate:Array = [{"x":6, "y":10},{"x":6, "y":9},{"x":7, "y":10},{"x":7, "y":9},{"x":6, "y":12},{"x":7, "y":12},{"x":8, "y":12},{"x":9, "y":12},{"x":10, "y":12},{"x":9, "y":8},{"x":10, "y":8},{"x":10, "y":9},{"x":10, "y":10},{"x":10, "y":11}];
		public static var villageCoordinate:Array = [{"x":4, "y":26},{"x":4, "y":25},{"x":4, "y":24},{"x":4, "y":23},{"x":3, "y":20},{"x":3, "y":21},{"x":3, "y":22},{"x":15, "y":2},{"x":14, "y":2},{"x":13, "y":2},{"x":12, "y":2},{"x":11, "y":2},{"x":10, "y":2},{"x":9, "y":2},{"x":8, "y":2},{"x":7, "y":2}];
		public static var murbawismaCoordinate:Array = [{"x":17, "y":17},{"x":17, "y":18},{"x":17, "y":19},{"x":17, "y":20}];
		public static var madyawismaCoordinate:Array = [{"x":18, "y":15},{"x":19, "y":15},{"x":20, "y":15},{"x":20, "y":14},{"x":20, "y":13},{"x":20, "y":12},{"x":20, "y":11}];
		public static var adiwismaCoordinate:Array = [{"x":20, "y":6},{"x":20, "y":7},{"x":20, "y":8},{"x":20, "y":9},{"x":20, "y":10},{"x":19, "y":10},{"x":18, "y":10}];
		public static var playgroundCoordinate:Array = [{"x":11, "y":11},{"x":11, "y":10},{"x":11, "y":9},{"x":11, "y":8}];
		public static var beachCoordinate:Array = [{"x":21, "y":16},{"x":21, "y":6},{"x":21, "y":5},{"x":21, "y":4},{"x":21, "y":3}];
		public static var factoryCoordinate:Array = [{"x":14, "y":25},{"x":14, "y":26},{"x":14, "y":27},{"x":14, "y":28},{"x":8, "y":27},{"x":9, "y":27},{"x":10, "y":27},{"x":11, "y":27},{"x":12, "y":27},{"x":12, "y":26},{"x":12, "y":23},{"x":12, "y":24},{"x":12, "y":25}];
		public static var wonderlandCoordinate:Array = [{"x":16, "y":22},{"x":16, "y":23},{"x":16, "y":24},{"x":17, "y":24},{"x":17, "y":23},{"x":17, "y":22},{"x":20, "y":25},{"x":20, "y":24},{"x":20, "y":23},{"x":20, "y":22}];
		public static var sportCenterCoordinate:Array = [{"x":8, "y":14},{"x":8, "y":15},{"x":11, "y":13},{"x":11, "y":14},{"x":11, "y":15},{"x":11, "y":16},{"x":3, "y":4},{"x":4, "y":4},{"x":5, "y":4},{"x":5, "y":5},{"x":5, "y":6}];
		public static var townHallCoordinate:Array = [{"x":9, "y":7},{"x":9, "y":6},{"x":9, "y":5},{"x":10, "y":5},{"x":11, "y":5},{"x":11, "y":6},{"x":11, "y":7},{"x":10, "y":7}];
		public static var gameCenterCoordinate:Array = [{"x":12, "y":19},{"x":12, "y":20},{"x":12, "y":21},{"x":11, "y":21},{"x":10, "y":21}];
		public static var hospitalCoordinate:Array = [{"x":9, "y":18},{"x":9, "y":17},{"x":9, "y":16},{"x":10, "y":16},{"x":11, "y":16},{"x":12, "y":16}];
		public static var theaterCoordinate:Array = [{"x":9, "y":16},{"x":9, "y":17},{"x":9, "y":18},{"x":6, "y":16},{"x":7, "y":16},{"x":8, "y":16},{"x":14, "y":4},{"x":14, "y":5},{"x":14, "y":6},{"x":14, "y":7}];
		public static var bookStoreCoordinate:Array = [{"x":16, "y":3},{"x":16, "y":4},{"x":16, "y":5},{"x":17, "y":5},{"x":18, "y":5},{"x":19, "y":5}];
		public static var mallCoordinate:Array = [{"x":15, "y":12},{"x":16, "y":12},{"x":17, "y":12},{"x":17, "y":11},{"x":17, "y":10},{"x":17, "y":9},{"x":17, "y":8},{"x":17, "y":7},{"x":17, "y":6},{"x":14, "y":16},{"x":14, "y":15},{"x":14, "y":14},{"x":14, "y":13}];
	}
}