package sketchproject.utilities
{
	import sketchproject.core.Config;
	import sketchproject.core.Data;

	/**
	 * Day helper, count the day of simulation find out day of week and holiday moment.
	 *
	 * @author Angga
	 */
	public class DayCounter
	{
		/**
		 * Holiday status.
		 *
		 * @default
		 */
		public static var holiday:Boolean = false;

		/**
		 * Find out number of day week.
		 *
		 * @return
		 */
		public static function numberDayWeek():int
		{
			return Data.playtime % 7;
		}

		/**
		 * Find out name of day by number.
		 *
		 * @return
		 */
		public static function today():String
		{
			return Config.days[Data.playtime % 7];
		}

		/**
		 * Find out if today is saturday.
		 *
		 * @return
		 */
		public static function isWeekend():Boolean
		{
			if (Data.playtime % 7 == 6)
			{
				return true;
			}
			return false;
		}

		/**
		 * Find out if today is sunday.
		 *
		 * @return
		 */
		public static function isFreeday():Boolean
		{
			if (Data.playtime % 7 == 0)
			{
				return true;
			}
			return false;
		}

		/**
		 * Find out if today is holiday.
		 *
		 * @return
		 */
		public static function isHoliday():Boolean
		{
			return holiday;
		}

		/**
		 * Find out if number of the day over a year.
		 *
		 * @return
		 */
		public static function yearCounting():int
		{
			return int(Math.ceil(Data.playtime / 360));
		}

		/**
		 * Find out if number of the day in year.
		 *
		 * @return
		 */
		public static function dayCounting():int
		{
			if (Data.playtime % 360 == 0)
			{
				return 360;
			}
			return Data.playtime % 360;
		}
	}
}
