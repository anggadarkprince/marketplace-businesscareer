package sketchproject.utilities
{

	/**
	 * Currency formatter.
	 *
	 * @author Angga
	 */
	public class ValueFormatter
	{

		/**
		 * Format value by add prefix and postfix,
		 * add thousand shorter from Kilo, Million, Billion.
		 *
		 * @param value of data
		 * @param isRounded round to nearest value
		 * @param prefix add prefix such as currency symbol
		 * @param postfix add postfix such as decimal digit or cent.
		 * @return
		 */
		public static function format(value:Number, isRounded:Boolean = true, prefix:String = "", postfix:String = ""):String
		{
			var number:Number = value;
			var numberformat:String = number.toString();

			if (number.toString().length > 5)
			{
				if (isRounded)
				{
					numberformat = Math.round(value / 1000) + " K";
				}
				else
				{
					numberformat = (value / 1000).toFixed(2) + " K";
				}
			}
			if (number.toString().length > 7)
			{
				if (isRounded)
				{
					numberformat = Math.round(value / 1000000) + " M";
				}
				else
				{
					numberformat = (value / 1000000).toFixed(2) + " M";
				}
			}
			if (number.toString().length > 9)
			{
				if (isRounded)
				{
					numberformat = Math.round(value / 1000000000) + " B";
				}
				else
				{
					numberformat = (value / 1000000000).toFixed(2) + " B";
				}
			}
			return prefix + " " + numberformat + " " + postfix;
		}

		/**
		 * Add format thousand period separator.
		 *
		 * @param input
		 * @param prefix
		 * @param postfix
		 * @return
		 */
		public static function numberFormat(input:Number, prefix:String = "", postfix:String = ""):String
		{
			var base:String = input.toString();
			base = base.split("").reverse().join("");
			base = base.replace(/\d{3}(?=\d)/g, "$&.");
			return prefix + " " + base.split("").reverse().join("") + " " + postfix;
		}
	}
}
