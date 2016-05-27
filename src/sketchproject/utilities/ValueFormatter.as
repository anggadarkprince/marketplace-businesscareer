package sketchproject.utilities
{
	public class ValueFormatter
	{
		
		public static function format(value:Number, isRounded:Boolean = true, prefix:String = "", postfix:String = ""):String
		{
			var number:Number = value;
			var numberformat:String = number.toString();

			if(number.toString().length > 5)
			{
				if(isRounded)
				{
					numberformat = Math.round(value/1000) + " K";
				}
				else
				{
					numberformat = (value/1000).toFixed(2) + " K";
				}				
			}
			if(number.toString().length > 7)
			{
				if(isRounded)
				{
					numberformat = Math.round(value/1000000) + " M";
				}
				else
				{
					numberformat = (value/1000000).toFixed(2) + " M";
				}				
			}
			if(number.toString().length > 9)
			{
				if(isRounded)
				{
					numberformat = Math.round(value/1000000000) + " B";
				}
				else
				{
					numberformat = (value/1000000000).toFixed(2) + " B";
				}				
			}
			return prefix+" "+numberformat+" "+postfix;
		}
		
		public static function numberFormat(input:Number, prefix:String = "", postfix:String = ""):String
		{
			var base:String = input.toString();
			base = base.split("").reverse().join("");
			base = base.replace(/\d{3}(?=\d)/g,"$&.");
			return prefix+" "+base.split("").reverse().join("")+" "+postfix;
		}
		
		
	}
}