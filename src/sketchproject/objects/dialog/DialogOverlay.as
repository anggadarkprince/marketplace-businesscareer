package sketchproject.objects.dialog
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import sketchproject.core.Assets;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class DialogOverlay extends Sprite
	{
		protected var overlay:Quad;
		protected var buttonClose:Button;
		
		public function DialogOverlay()
		{
			super();
						
			overlay = new Quad(Starling.current.nativeStage.stageWidth * 2.5,Starling.current.nativeStage.stageHeight * 2.5);
			overlay.pivotX = overlay.width * 0.5;
			overlay.pivotY = overlay.height * 0.5;
			overlay.alpha = 0.8;	
			overlay.color = 0x000000;
			addChild(overlay);
			
			buttonClose = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonClose")); 
			buttonClose.pivotX = buttonClose.width * 0.5;
			buttonClose.pivotY = buttonClose.height * 0.5;
			buttonClose.x = 162.5;
			buttonClose.y = 201.65;
			addChild(buttonClose);
			
			buttonClose.addEventListener(Event.TRIGGERED, function(event:Event):void{
				closeDialog();
			});
			
			scaleX = 0.5;
			scaleY = 0.5;
			alpha = 0;
			visible = false;
		}
		
		public function openDialog():void
		{
			visible = true;
			TweenMax.to(
				this,
				0.7,
				{
					ease:Back.easeOut,
					scaleX:0.9,
					scaleY:0.9,
					alpha:1,
					delay:0.2
				}
			);	
		}
		
		public function closeDialog():void
		{
			Assets.sfxChannel = Assets.sfxClick.play(0,0,Assets.sfxTransform);
			TweenMax.to(
				this,
				0.5,
				{
					ease:Back.easeIn,
					scaleX:0.5,
					scaleY:0.5,
					alpha:0,
					delay:0.2,
					onComplete:function():void{
						visible = false;					
					}
				}
			);
		}
		
		public function destroy():void
		{
			removeFromParent(true);
		}
	}
}