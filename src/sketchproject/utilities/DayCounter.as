package sketchproject.utilities
{
	import sketchproject.core.Config;
	import sketchproject.core.Data;

	public class DayCounter
	{
		public static var holiday:Boolean = false;
		
		public static function numberDayWeek():int
		{
			return Data.playtime%7;
		}
		
		public static function today():String
		{
			return Config.days[Data.playtime%7];
		}
		
		public static function isWeekend():Boolean
		{
			if(Data.playtime%7 == 6){
				return true;
			}
			return false;
		}
		
		public static function isFreeday():Boolean
		{
			if(Data.playtime%7 == 0){
				return true;
			}
			return false;
		}
		
		public static function isHoliday():Boolean
		{
			return holiday;
		}
		
		public static function yearCounting():int
		{
			return int(Math.ceil(Data.playtime/360));
		}
		
		public static function dayCounting():int
		{
			if(Data.playtime % 360 == 0){
				return 360;
			}
			return Data.playtime % 360;
		}
	}
}