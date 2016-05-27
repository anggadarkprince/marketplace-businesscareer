package sketchproject.utilities
{
	import sketchproject.core.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.TextureSmoothing;
	import starling.utils.VAlign;

	public class TableGenerator
	{
		public static var rowHeight:int = 20; 
		public static var xColum:int = 0;
		public static var headerColor:int = 0;
		public static var stripJump:int = 2;
		public static var oddColor:int = 0;
		public static var evenColor:int = 0;
		public static var headerFontColor:int = 0;
		public static var dataFontColor:int = 0;
		public static var headerFontSize:int = 14;
		public static var dataFontSize:int = 14;
		public static var isStriped:Boolean = true;
		public static var hasHeader:Boolean = true;
		
		public static function createTable(container:Sprite, header:Array, headerWidth:Array, data:Array, dataWidth:Array, align:Array):void
		{
			var bar:Image;
			var text:TextField;
			
			xColum = 0;
			
			if(hasHeader){
				// create header
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT).getTexture("whitebar"));
				bar.smoothing = TextureSmoothing.NONE;
				bar.width = 560;
				bar.height = rowHeight;
				bar.color = headerColor;
				//bar.x = xColum;
				container.addChild(bar);
				for(var i:int = 0; i< header.length;i++)
				{
					text = new TextField(headerWidth[i]-10,rowHeight,header[i].toString(),"Arial",headerFontSize,headerFontColor);
					text.hAlign = align[k];
					text.vAlign = VAlign.CENTER;
					text.x = xColum+5;
					container.addChild(text);
					
					xColum += headerWidth[i];
				}
			}
			
			var yData:int = (hasHeader) ? rowHeight : 0;
			
			// create content
			for(var j:int = 0; j< data.length;j++){
				xColum = 0;
				
				bar = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT).getTexture("whitebar"));
				bar.smoothing = TextureSmoothing.NONE;
				bar.width = 560;
				bar.height = rowHeight;
				bar.y = j * rowHeight + yData;
				if((j+1)%stripJump == 0)
				{
					// even
					bar.color = evenColor;
				}
				else{
					// odd
					bar.color = oddColor;
				}
				container.addChild(bar);
				
				for(var k:int = 0; k< data[j].length;k++){
					
					
					//bar.x = xColum;
					//bar.y = j * rowHeight + yData;
					//container.addChild(bar);
					
					text = new TextField(dataWidth[k]-10,rowHeight,data[j][k].toString(),"Arial",dataFontSize,dataFontColor);
					text.hAlign = align[k];
					text.vAlign = VAlign.CENTER;
					text.x = xColum + 5;
					text.y = j * rowHeight + yData;
					container.addChild(text);
					
					xColum += dataWidth[k];
				}						
			}
			container.flatten();
		}
	}
}