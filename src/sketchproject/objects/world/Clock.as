package sketchproject.objects.world
{

	/**
	 * Gameworld timer.
	 *
	 * @author Angga
	 */
	public class Clock
	{
		private var cHours:int = 24;
		private var cMinutes:int = 0;
		private var cSeconds:int = 0;

		/**
		 * Constructor of Clock.
		 *
		 * @param hour start simulation
		 * @param minute start simulation
		 * @param second start simulation
		 */
		public function Clock(hour:int = 0, minute:int = 0, second:int = 0)
		{
			this.hour = hour;
			this.minute = hour;
			this.second = hour;
		}

		/**
		 * Update the clock and time, we use hour and munute only.
		 */
		public function update():void
		{
			this.cMinutes += 2;

			if (this.cMinutes >= 60)
			{
				this.cMinutes = 0;
				this.cHours++;
			}
			if (this.cHours >= 24)
			{
				this.cHours = 0;
			}
		}

		/**
		 * Set current hour.
		 *
		 * @param cHour
		 */
		public function set hour(cHour:int):void
		{
			cHours = cHour;
		}

		/**
		 * Get current hour.
		 *
		 * @return
		 */
		public function get hour():int
		{
			return cHours;
		}

		/**
		 * Set current minute.
		 *
		 * @param cMinute
		 */
		public function set minute(cMinute:int):void
		{
			cMinutes = cMinute;
		}

		/**
		 * Get current minute.
		 *
		 * @return
		 */
		public function get minute():int
		{
			return cMinutes;
		}

		/**
		 * Set current second.
		 *
		 * @param cSecond
		 */
		public function set second(cSecond:int):void
		{
			cSecond = cSecond;
		}

		/**
		 * Get current second.
		 *
		 * @return
		 */
		public function get second():int
		{
			return cSeconds;
		}
	}
}
