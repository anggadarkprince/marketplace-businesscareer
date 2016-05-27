package sketchproject.objects.world
{	
	import starling.display.Image;
	
	public class Clock
	{
		private var clockBase:Image;
		
		private var hourImage:Image;
		private var minuteImage:Image;
		private var secondImage:Image;
		
		private var cHours:int		= 24;
		private var cMinutes:int	= 0;
		private var cSeconds:int	= 0;
		
		public function Clock(hour:int = 0, minute:int = 0, second:int = 0)
		{
			this.hour = hour;
			this.minute = hour;
			this.second = hour;
			super();
		}
		
		public function update():void
		{
			this.cSeconds++;
			this.cMinutes += 2;
			
			if(this.cSeconds>=60){
				this.cSeconds = 0;
				//this.cMinutes++;
			}
			if(this.cMinutes>=60){
				this.cMinutes = 0;
				this.cHours++;
			}
			if(this.cHours>=24){
				this.cHours = 0;
			}
		}
		
		public function set hour(cHour:int):void
		{
			cHours = cHour;
		}
		
		public function get hour():int
		{
			return cHours;
		}
		
		public function set minute(cMinute:int):void
		{
			cMinutes = cMinute;
		}
		
		public function get minute():int
		{
			return cMinutes;
		}
		
		public function set second(cSecond:int):void
		{
			cSecond = cSecond;
		}
		
		public function get second():int
		{
			return cSeconds;
		}
	}
}