package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.modules.Agent;
	import sketchproject.modules.AgentGenerator;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class TrendDialog extends DialogOverlay
	{
		private var background:Image;
		private var trendList:TextField;
		private var eventList:TextField;
		private var agentGenerator:AgentGenerator;
		private var predictAgent:Array;
				
		public function TrendDialog()
		{			
			super();
			
			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dialogShoppingStreet"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);
			
			buttonClose.x = 0;
			buttonClose.y = 152.65;			
			
			swapChildren(background, buttonClose);
			
			agentGenerator = new AgentGenerator();
			
			predictAgent = new Array();
			
			trendList = new TextField(315, 150, "", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			trendList.hAlign = HAlign.LEFT;
			trendList.vAlign = VAlign.TOP;
			trendList.x = -160.4;
			trendList.y = -85;
			addChild(trendList);
			
			eventList = new TextField(315, 120, "No Event", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			eventList.hAlign = HAlign.LEFT;
			eventList.vAlign = VAlign.TOP;
			eventList.x = -160.4;
			eventList.y = -4.2;
			addChild(eventList);
			
			update();
			
		}
		
		
		public function update():void
		{
			if(Data.event.length > 0)
			{
				eventList.text = "";
				for(var i:int = 0; i<Data.event.length; i++){
					eventList.text += (i+1)+". Event "+Data.event[i][1]+", start at "+Data.event[i][2]+" - "+Data.event[i][3]+"\n     Education : "+int(Data.event[i][6][0])+", Art : "+int(Data.event[i][6][1])+",Athletic : "+int(Data.event[i][6][2])+"\n";
				}
			}
			else
			{
				eventList.text = "No Event Today";
			}
			
			agentGenerator.generatePopulation(predictAgent, Data.valuePopulation);
			agentGenerator.generateSocialVariant(predictAgent, Data.valueVariant);
			var agent:Agent;
			
			var education:int = 0;
			var art:int = 0;
			var athletic:int = 0;
			
			var decoration:int = 0;
			var scent:int = 0;
			var cleaness:int = 0;
			
			for(i=0;i<predictAgent.length;i++){
				agent = predictAgent[i] as Agent;
				
				education += agent.education;
				art += agent.art;
				athletic += agent.athletic;
				
				decoration += int(agent.decorationMatch.modern);
				decoration += int(agent.decorationMatch.colorfull);
				decoration += int(agent.decorationMatch.vintage);
				
				cleaness += int(agent.cleanessMatch.product);
				cleaness += int(agent.cleanessMatch.place);
				
				scent += int(agent.scentMatch.ginger);
				scent += int(agent.scentMatch.jasmine);
				scent += int(agent.scentMatch.rosemary);
				
			}
			
			education = education/predictAgent.length;
			art = art/predictAgent.length;
			athletic = athletic/predictAgent.length;
			
			decoration = decoration/3/predictAgent.length;
			cleaness = cleaness/2/predictAgent.length;
			scent = scent/3/predictAgent.length;
			
			trendList.text = "Trend ketertarikan event dengan rata - rata kemiripan :\nEducation : "+education+"  Art : "+art+"  Athletic : "+athletic+",";
			trendList.text = trendList.text+"\nDecoration : "+decoration+"  Cleaness : "+cleaness+"  Scent : "+scent+"";
		}
		
		
	}
}