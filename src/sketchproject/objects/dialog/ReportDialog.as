package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Shop;
	
	import starling.display.Image;
	import starling.display.Shape;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class ReportDialog extends DialogOverlay
	{
		public static var instance:ReportDialog;
		
		private var background:Image;
		private var textSharePlayer:TextField;
		private var textShareCompetitor1:TextField;
		private var textShareCompetitor2:TextField;
		
		private var textSharePlayerMax:TextField;
		private var textShareCompetitor1Max:TextField;
		private var textShareCompetitor2Max:TextField;
		
		private var textSharePlayerAvg:TextField;
		private var textShareCompetitor1Avg:TextField;
		private var textShareCompetitor2Avg:TextField;
		
		private var textProfitPlayer:TextField;
		private var textProfitCompetitor1:TextField;
		private var textProfitCompetitor2:TextField;
		
		private var textTransactionPlayer:TextField;
		private var textTransactionCompetitor1:TextField;
		private var textTransactionCompetitor2:TextField;
		
		private var lastXShare:Number;
		private var lastY1Share:Number;
		private var lastY2Share:Number;
		private var lastY3Share:Number;
		
		private var lineBar:Shape;
		private var step:uint = 16;
		private var lastXProfit:Number;
		private var lastY1Profit:Number;
		private var lastY2Profit:Number;
		private var lastY3Profit:Number;
				
		public function ReportDialog()
		{			
			super();
			
			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dialogSimulationReport"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);
			
			buttonClose.x = 0;
			buttonClose.y = 235;
			
			swapChildren(background, buttonClose);
			
			textSharePlayer = new TextField(100, 30, "0 %", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textSharePlayer.pivotX = textSharePlayer.width * 0.5;
			textSharePlayer.pivotY = textSharePlayer.height * 0.5;
			textSharePlayer.x = -303.45;
			textSharePlayer.y = 129.45;
			addChild(textSharePlayer);
			
			textShareCompetitor1 = new TextField(100, 30, "0 %", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textShareCompetitor1.pivotX = textShareCompetitor1.width * 0.5;
			textShareCompetitor1.pivotY = textShareCompetitor1.height * 0.5;
			textShareCompetitor1.x = -303.45;
			textShareCompetitor1.y = 152.45;
			addChild(textShareCompetitor1);
			
			textShareCompetitor2 = new TextField(100, 30, "0 %", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textShareCompetitor2.pivotX = textShareCompetitor2.width * 0.5;
			textShareCompetitor2.pivotY = textShareCompetitor2.height * 0.5;
			textShareCompetitor2.x = -303.45;
			textShareCompetitor2.y = 175.65;
			addChild(textShareCompetitor2);
			
			textSharePlayerMax = new TextField(150, 30, "0 % Reached", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textSharePlayerMax.pivotY = textSharePlayerMax.height * 0.5;
			textSharePlayerMax.hAlign = HAlign.LEFT;
			textSharePlayerMax.x = -240.95;
			textSharePlayerMax.y = 129.45;
			addChild(textSharePlayerMax);
			
			textShareCompetitor1Max = new TextField(150, 30, "0 % Reached", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textShareCompetitor1Max.pivotY = textShareCompetitor1Max.height * 0.5;
			textShareCompetitor1Max.hAlign = HAlign.LEFT;
			textShareCompetitor1Max.x = -240.95;
			textShareCompetitor1Max.y = 152.45;
			addChild(textShareCompetitor1Max);
			
			textShareCompetitor2Max = new TextField(150, 30, "0 % Reached", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textShareCompetitor2Max.pivotY = textShareCompetitor2Max.height * 0.5;
			textShareCompetitor2Max.hAlign = HAlign.LEFT;
			textShareCompetitor2Max.x = -240.95;
			textShareCompetitor2Max.y = 175.65;
			addChild(textShareCompetitor2Max);
			
			textSharePlayerAvg = new TextField(100, 30, "0 % Avg", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textSharePlayerAvg.pivotY = textSharePlayerAvg.height * 0.5;
			textSharePlayerAvg.hAlign = HAlign.LEFT;
			textSharePlayerAvg.x = -128.45;
			textSharePlayerAvg.y = 129.45;
			addChild(textSharePlayerAvg);
			
			textShareCompetitor1Avg = new TextField(100, 30, "0 % Avg", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textShareCompetitor1Avg.pivotY = textShareCompetitor1Avg.height * 0.5;
			textShareCompetitor1Avg.hAlign = HAlign.LEFT;
			textShareCompetitor1Avg.x = -128.45;
			textShareCompetitor1Avg.y = 152.45;
			addChild(textShareCompetitor1Avg);
			
			textShareCompetitor2Avg = new TextField(100, 30, "0 % Avg", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textShareCompetitor2Avg.pivotY = textShareCompetitor2Avg.height * 0.5;
			textShareCompetitor2Avg.hAlign = HAlign.LEFT;
			textShareCompetitor2Avg.x = -128.45;
			textShareCompetitor2Avg.y = 175.65;
			addChild(textShareCompetitor2Avg);
			
			
			textProfitPlayer = new TextField(100, 30, "IDR 0", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textProfitPlayer.pivotY = textProfitPlayer.height * 0.5;
			textProfitPlayer.hAlign = HAlign.LEFT;
			textProfitPlayer.x = 158.55;
			textProfitPlayer.y = 129.45;
			addChild(textProfitPlayer);
			
			textProfitCompetitor1 = new TextField(100, 30, "IDR 0", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textProfitCompetitor1.pivotY = textProfitCompetitor1.height * 0.5;
			textProfitCompetitor1.hAlign = HAlign.LEFT;
			textProfitCompetitor1.x = 158.55;
			textProfitCompetitor1.y = 152.45;
			addChild(textProfitCompetitor1);
			
			textProfitCompetitor2 = new TextField(100, 30, "IDR 0", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textProfitCompetitor2.pivotY = textProfitCompetitor2.height * 0.5;
			textProfitCompetitor2.hAlign = HAlign.LEFT;
			textProfitCompetitor2.x = 158.55;
			textProfitCompetitor2.y = 175.65;
			addChild(textProfitCompetitor2);
			
			
			textTransactionPlayer = new TextField(150, 30, "0 X Transaction", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textTransactionPlayer.pivotY = textProfitPlayer.height * 0.5;
			textTransactionPlayer.hAlign = HAlign.LEFT;
			textTransactionPlayer.x = 271.05;
			textTransactionPlayer.y = 129.45;
			addChild(textTransactionPlayer);
			
			textTransactionCompetitor1 = new TextField(150, 30, "0 X Transaction", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textTransactionCompetitor1.pivotY = textProfitCompetitor1.height * 0.5;
			textTransactionCompetitor1.hAlign = HAlign.LEFT;
			textTransactionCompetitor1.x = 271.05;
			textTransactionCompetitor1.y = 152.45;
			addChild(textTransactionCompetitor1);
			
			textTransactionCompetitor2 = new TextField(150, 30, "0 X Transaction", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 15, 0x555555);
			textTransactionCompetitor2.pivotY = textProfitCompetitor2.height * 0.5;
			textTransactionCompetitor2.hAlign = HAlign.LEFT;
			textTransactionCompetitor2.x = 271.05;
			textTransactionCompetitor2.y = 175.65;
			addChild(textTransactionCompetitor2);
			
			lineBar = new Shape();
			addChild(lineBar);
			
			update();
			
		}
		
		public static function getInstance():ReportDialog
		{
			if(instance == null)
			{
				instance = new ReportDialog();
			}
			return instance;
		}
		
		private var a:int;
		private var b:int;
		private var c:int;
		public function update(myShop:Shop = null, competitor1Shop:Shop = null, competitor2Shop:Shop = null):void
		{
			if(myShop!=null){
				textSharePlayer.text = myShop.marketshare+"%";
				textShareCompetitor1.text = competitor1Shop.marketshare+"%";
				textShareCompetitor2.text = competitor2Shop.marketshare+"%";
				
				textSharePlayerMax.text = myShop.updateShareMax()+"% Reached";
				textShareCompetitor1Max.text = competitor1Shop.updateShareMax()+"% Reached";
				textShareCompetitor2Max.text = competitor2Shop.updateShareMax()+"% Reached";
				
				textSharePlayerAvg.text = myShop.updateShareAverage()+"% Avg";
				textShareCompetitor1Avg.text = competitor1Shop.updateShareAverage()+"% Avg";
				textShareCompetitor2Avg.text = competitor2Shop.updateShareAverage()+"% Avg";
				
				textTransactionPlayer.text = myShop.transactionTotal+" X Transaction";
				textTransactionCompetitor1.text = competitor1Shop.transactionTotal+" X Transaction";
				textTransactionCompetitor2.text = competitor2Shop.transactionTotal+" X Transaction";
				
				textProfitPlayer.text = "IDR "+myShop.grossProfit;
				textProfitCompetitor1.text = "IDR "+competitor1Shop.grossProfit;
				textProfitCompetitor2.text = "IDR "+competitor2Shop.grossProfit;
				
				lastXShare = -383.25;
				lastY1Share = -87.65 + 170;
				lastY2Share = -87.65 + 170;
				lastY3Share = -87.65 + 170;
				
				lastXProfit = 79.25;
				lastY1Profit = -87.65 + 170;
				lastY2Profit = -87.65 + 170;
				lastY3Profit = -87.65 + 170;
				
				// temporary
				a = 0;
				b = 0;
				c = 0;
				
				for (var j:int = 0; j < WorldManager.instance.listAgents.length; j++) 
				{
					if(WorldManager.instance.listAgents[j].choice == 1){
						a++;
					}
					else if(WorldManager.instance.listAgents[j].choice == 2){
						b++;
					}
					else if(WorldManager.instance.listAgents[j].choice == 3){
						c++;
					}
				}
				
				myShop.updateMarkershare(100*a/WorldManager.instance.listAgents.length);
				competitor1Shop.updateMarkershare(100*b/WorldManager.instance.listAgents.length);
				competitor2Shop.updateMarkershare(100*c/WorldManager.instance.listAgents.length);
								
				myShop.updateProfit();
				competitor1Shop.updateProfit();
				competitor2Shop.updateProfit();
				
				//-------------------------------
				
				if(myShop.listshare.length > 20)
				{
					lastY1Share = -87.65 + 170 - (170/100*myShop.listshare[0]);
					lastY2Share = -87.65 + 170 - (170/100*competitor1Shop.listshare[0]);
					lastY3Share = -87.65 + 170 - (170/100*competitor2Shop.listshare[0]);
					
					myShop.listshare.shift();	
					competitor1Shop.listshare.shift();
					competitor2Shop.listshare.shift();
					
					lastY1Profit = -87.65 + 170 - (170/1000000*myShop.listprofit[0]);
					lastY2Profit = -87.65 + 170 - (170/1000000*competitor1Shop.listprofit[0]);
					lastY3Profit = -87.65 + 170 - (170/1000000*competitor2Shop.listprofit[0]);
					
					myShop.listprofit.shift();	
					competitor1Shop.listprofit.shift();
					competitor2Shop.listprofit.shift();
				}
				
				lineBar.graphics.clear();
				
				for(var i:uint = 0, l:uint = myShop.listshare.length; i<l; i++)
				{
					lineBar.graphics.lineStyle(2, 0x5B9BD5);
					lineBar.graphics.moveTo(lastXShare,lastY1Share);
					lastY1Share = -87.65 + 170 - (170/100*myShop.listshare[i]);
					lineBar.graphics.lineTo(lastXShare + step, lastY1Share);
					
					lineBar.graphics.lineStyle(2, 0xED7D31);
					lineBar.graphics.moveTo(lastXShare,lastY2Share);
					lastY2Share = -87.65 + 170 - (170/100*competitor1Shop.listshare[i]);
					lineBar.graphics.lineTo(lastXShare + step, lastY2Share);
					
					lineBar.graphics.lineStyle(2, 0xA5A5A5);
					lineBar.graphics.moveTo(lastXShare,lastY3Share);
					lastY3Share = -87.65 + 170 - (170/100*competitor2Shop.listshare[i]);
					lineBar.graphics.lineTo(lastXShare + step, lastY3Share);
					
					lastXShare += step;
					
					
					
					lineBar.graphics.lineStyle(2, 0x5B9BD5);
					lineBar.graphics.moveTo(lastXProfit,lastY1Profit);
					lastY1Profit = -87.65 + 170 - (170/1000000*myShop.listprofit[i]);
					lineBar.graphics.lineTo(lastXProfit + step, lastY1Profit);
					
					lineBar.graphics.lineStyle(2, 0xED7D31);
					lineBar.graphics.moveTo(lastXProfit,lastY2Profit);
					lastY2Profit = -87.65 + 170 - (170/1000000*competitor1Shop.listprofit[i]);
					lineBar.graphics.lineTo(lastXProfit + step, lastY2Profit);
					
					lineBar.graphics.lineStyle(2, 0xA5A5A5);
					lineBar.graphics.moveTo(lastXProfit,lastY3Profit);
					lastY3Profit = -87.65 + 170 - (170/1000000*competitor2Shop.listprofit[i]);
					lineBar.graphics.lineTo(lastXProfit + step, lastY3Profit);
					
					lastXProfit += step;
				}
			}
		}
		
		
	}
}