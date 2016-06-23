package sketchproject.core
{
	public class Data
	{
		/** player data **/
		public static var id:String 				= "111";
		public static var key:String 				= "62fb654g924g76q937s4xv0";
		public static var name:String 				= "Vierpiers Mist";
		public static var nickname:String 			= "Priest";
		public static var username:String 			= "slasher15";
		
		
		/** game data **/
		public static var playtime:int				= 1;
		public static var point:Number 				= 0;
		public static var cash:Number 				= 0;
		public static var customer:Number 			= 0;
		public static var advisor:String 			= "advisor2";
		public static var personalObjective:String 	= "No Objective";
		public static var businessPlan:String 		= "No Business Plan";
		public static var financing:String 			= "DEBT";
		public static var instalment:uint 			= 0;
		public static var shoppingStreet:String		= "Vinichles are not permitted on Main Street in the Shopping Distric todah, as we create an outdor mail from 10am to 5px. Music and entertainment will be provided at not change. have a great day!";		
		public static var weather:Array 			= new Array();
		public static var event:Array 				= new Array();
		public static var tasks:Array 				= new Array();
		public static var booster:Array 			= [0, 0, 0, 0];
		public static var avatarName:String 		= "No Avatar";
		public static var avatar:Array 				= [0,0,0,0,0];
		public static var motivation:String 		= "No Motivation";
		
		public static var stars:uint 				= 1;
		public static var worldRank:int 			= 32;
				
		/** shop, logo & advisor */
		public static var shop:String 				= "Djanggo Cafe";
		public static var logo:String 				= "logo2";
		public static var district:String 			= "Green Ville";
		public static var schedule:Array 			= [[8,15],[9,18],[9,19],[8,18],[8,18],[8,18],[9,15]];
		public static var decoration:Array 			= [1,1,1];
		public static var scent:Array 				= [1,1,1];		
		public static var cleanness:Array 			= [1,1];		
		public static var salesToday:Number 		= 0;
		public static var salesTotal:Number 		= 0;
		public static var research:Array 			= [0,0,0,0,0];
		public static var program:Array 			= [0,0,0,0,0,0,0,0,0];
		public static var advertising:Array			= [["1","NONE","NONE"],["2","NONE","NONE"],["3","NONE","NONE"],["4","NONE","NONE"],["5","NONE","NONE"],["6","NONE","NONE"]];
		
		/** parameter **/
		public static var valuePopulation:int 		= 100;
		public static var valueWeather:int 			= 7;
		public static var valueEvent:int 			= 4;
		public static var valueCompetitor:int		= 2;		
		public static var valueVariant:int 			= 8;
		public static var valueAddicted:int 		= 8;
		public static var valueBuying:int 			= 7;
		public static var valueEmotion:int 			= 6;
		
		/** business statistic */
		public static var stress:int 				= 10;
		public static var stressHistory:Array 		= new Array();
		public static var work:int 					= 0;
		public static var workAvg:int 				= 9;
		public static var workTotal:int 			= 0;
		public static var workHistory:Array			= new Array();
		
		public static var firstCostOfGood:Number 	= 0;
		public static var lastCostOfGood:Number 	= 0;
		
		public static var locationHistory:Array		= new Array();
		public static var inventoryHistory:Array	= new Array();
		public static var customerHistory:Array		= new Array();
		public static var transactionHistory:Array	= new Array();
		public static var isUseHint:Boolean			= false;
		public static var hintAvoidHistory:Array	= new Array();
		public static var marketShareHistory:Array	= new Array();
		public static var isFailAnswer:Boolean		= false;
		public static var correctHistory:Array		= new Array();
		
		public static var simulation:Array			= new Array();
		
		public static var programCost:Number		= 0;
		public static var researchCost:Number		= 0;
		public static var advertisingCost:Array		= new Array();
		
		public static var discountFirst:int			= 0;
		public static var discountLast:int			= 0;
		
		
		
		/** player achieved **/
		public static var achievement:Array = new Array();
							
		/** player employee **/
		public static var employee:Array = new Array();
		
		/** player product **/
		public static var product:Array = new Array();
		
		/** player inventory **/
		public static var inventory:Array = new Array();
		
		/** player asset **/
		public static var asset:Array = new Array({ast_level:1});
		
		/** material product **/
		public static var productInventory:Array = new Array();
		
	}
}