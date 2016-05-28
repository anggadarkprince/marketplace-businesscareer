package sketchproject.managers
{
	import flash.events.EventDispatcher;
	
	import sketchproject.core.Data;

	public class DataManager extends EventDispatcher
	{				
		public static function traceGameData():void
		{
			trace("\nGAMEDATA------------------------------------------------");
			trace("playtime", Data.playtime);
			trace("point", Data.point);
			trace("cash", Data.cash);
			trace("customer", Data.customer);
			trace("advisor", Data.advisor);
			trace("personalObjective", Data.personalObjective);
			trace("businessPlan", Data.businessPlan);
			
			trace("---------------------------------------");
			
			trace("playtime", Data.financing);
			trace("instalment", Data.instalment);
			trace("weather", JSON.stringify(Data.weather));
			trace("event", JSON.stringify(Data.event));
			trace("tasks", JSON.stringify(Data.tasks));
			trace("booster", Data.booster);
			trace("avatarName", Data.avatarName);
			trace("avatar", JSON.stringify(Data.avatar));
			trace("motivation", Data.motivation);
			trace("booster", Data.booster);
			trace("valuePopulation", Data.valuePopulation);
			trace("valueWeather", Data.valueWeather);
			trace("valueEvent", Data.valueEvent);
			trace("valueCompetitor", Data.valueCompetitor);
			trace("valueVariant", Data.valueVariant);
			trace("valueAddicted", Data.valueAddicted);
			trace("valueBuying", Data.valueBuying);
			trace("valueEmotion", Data.valueEmotion);
			
			trace("---------------------------------------");
			
			trace("shop", Data.shop);
			trace("logo", Data.logo);
			trace("district", Data.district);
			trace("schedule", JSON.stringify(Data.schedule));
			trace("decoration", JSON.stringify(Data.decoration));
			trace("scent", JSON.stringify(Data.scent));
			trace("cleanness", JSON.stringify(Data.cleanness));
			trace("salesToday", Data.salesToday);
			trace("salesTotal", Data.salesTotal);
			trace("research", JSON.stringify(Data.research));
			trace("program", JSON.stringify(Data.program));
			trace("advertising", JSON.stringify(Data.advertising));
			
			trace("---------------------------------------");
			
			trace("employee",JSON.stringify(Data.employee));
			trace("inventory",JSON.stringify(Data.inventory));
			trace("asset",JSON.stringify(Data.asset));
			trace("product",JSON.stringify(Data.product));
			trace("achievement",JSON.stringify(Data.achievement));
			trace("simulation",JSON.stringify(Data.simulation));
			trace("----------------------------------------------------------\n");
		}
	}
}