package sketchproject.objects.dialog
{
	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class AgentDialog extends DialogOverlay
	{
		private var background:Image;
		private var buttonRandom:Button;
		
		private var action:TextField;
		private var agentId:TextField;
		private var district:TextField;
		private var mainRole:TextField;
		private var buyingPower:TextField;
		private var emotion:TextField;
		private var education:TextField;
		private var art:TextField;
		private var athletic:TextField;
		private var actionWill:TextField;
		
		private var priceSensitivity:TextField;
		private var priceThreshold:TextField;
		private var qualitySensitivity:TextField;
		private var qualityThreshold:TextField;
		private var recommendation:TextField;
		private var disqualification:TextField;
		private var environmentEval:TextField;
		private var productEval:TextField;
		private var adverEval:TextField;
		private var respondEval:TextField;
		
		private var facing:TextField;
		private var deltaX:TextField;
		private var deltaY:TextField;
		private var speed:TextField;
		private var position:TextField;
		private var coordinate:TextField;
		private var cartesian:TextField;
		private var destination:TextField;
		private var path:TextField;
		private var isMoving:TextField;
		
		private var choice:TextField;
		private var percept:TextField;
		
		private var agent:Agent;
				
		public function AgentDialog()
		{			
			super();
			
			background = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("dialogAgentView"));
			background.pivotX = background.width * 0.5;
			background.pivotY = background.height * 0.5;
			addChild(background);
			
			buttonClose.x = 360;
			buttonClose.y = 205;
			
			swapChildren(background, buttonClose);
			
			buttonRandom = new Button(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("buttonRandom")); 
			buttonRandom.pivotX = buttonRandom.width * 0.5;
			buttonRandom.pivotY = buttonRandom.height * 0.5;
			buttonRandom.x = 240;
			buttonRandom.y = 205;
			addChild(buttonRandom);
			
			buttonRandom.addEventListener(Event.TRIGGERED, onRandomTriggered);
			
			// personality
			
			action = new TextField(135, 30, "action", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			action.pivotX = action.width * 0.5;
			action.pivotY = action.height * 0.5;
			action.x = -217.15;
			action.y = -132.75;
			addChild(action);
			
			agentId = new TextField(135, 30, "id", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			agentId.pivotX = agentId.width * 0.5;
			agentId.pivotY = agentId.height * 0.5;
			agentId.x = -217.15;
			agentId.y = -99.95;
			addChild(agentId);
			
			district = new TextField(135, 30, "district", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			district.pivotX = agentId.width * 0.5;
			district.pivotY = agentId.height * 0.5;
			district.x = -217.15;
			district.y = -68.75;
			addChild(district);
			
			mainRole = new TextField(135, 30, "role", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			mainRole.pivotX = agentId.width * 0.5;
			mainRole.pivotY = agentId.height * 0.5;
			mainRole.x = -217.15;
			mainRole.y = -36.75;
			addChild(mainRole);
			
			buyingPower = new TextField(135, 30, "buying power", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			buyingPower.pivotX = agentId.width * 0.5;
			buyingPower.pivotY = agentId.height * 0.5;
			buyingPower.x = -217.15;
			buyingPower.y = -4.75;
			addChild(buyingPower);
			
			emotion = new TextField(135, 30, "emotion", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			emotion.pivotX = agentId.width * 0.5;
			emotion.pivotY = agentId.height * 0.5;
			emotion.x = -217.15;
			emotion.y = 28.05;
			addChild(emotion);
			
			education = new TextField(135, 30, "education", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			education.pivotX = agentId.width * 0.5;
			education.pivotY = agentId.height * 0.5;
			education.x = -217.15;
			education.y = 59.25;
			addChild(education);
			
			art = new TextField(135, 30, "art", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			art.pivotX = agentId.width * 0.5;
			art.pivotY = agentId.height * 0.5;
			art.x = -217.15;
			art.y = 91.25;
			addChild(art);
			
			athletic = new TextField(135, 30, "athletic", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			athletic.pivotX = agentId.width * 0.5;
			athletic.pivotY = agentId.height * 0.5;
			athletic.x = -217.15;
			athletic.y = 123.25;
			addChild(athletic);
			
			actionWill = new TextField(135, 30, "action will", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			actionWill.pivotX = agentId.width * 0.5;
			actionWill.pivotY = agentId.height * 0.5;
			actionWill.x = -217.15;
			actionWill.y = 156.05;
			addChild(actionWill);
			
			
			// motivation
			
			priceSensitivity = new TextField(135, 30, "price sensitivity", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			priceSensitivity.pivotX = action.width * 0.5;
			priceSensitivity.pivotY = action.height * 0.5;
			priceSensitivity.x = 68.35;
			priceSensitivity.y = -132.75;
			addChild(priceSensitivity);
			
			priceThreshold = new TextField(135, 30, "price threshold", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			priceThreshold.pivotX = agentId.width * 0.5;
			priceThreshold.pivotY = agentId.height * 0.5;
			priceThreshold.x = 68.35;
			priceThreshold.y = -99.95;
			addChild(priceThreshold);
			
			qualitySensitivity = new TextField(135, 30, "quality sensitivity", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			qualitySensitivity.pivotX = agentId.width * 0.5;
			qualitySensitivity.pivotY = agentId.height * 0.5;
			qualitySensitivity.x = 68.35;
			qualitySensitivity.y = -68.75;
			addChild(qualitySensitivity);
			
			qualityThreshold = new TextField(135, 30, "quality threshold", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			qualityThreshold.pivotX = agentId.width * 0.5;
			qualityThreshold.pivotY = agentId.height * 0.5;
			qualityThreshold.x = 68.35;
			qualityThreshold.y = -36.75;
			addChild(qualityThreshold);
			
			recommendation = new TextField(135, 30, "recommendation", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			recommendation.pivotX = agentId.width * 0.5;
			recommendation.pivotY = agentId.height * 0.5;
			recommendation.x = 68.35;
			recommendation.y = -4.75;
			addChild(recommendation);
			
			disqualification = new TextField(135, 30, "disqualification", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			disqualification.pivotX = agentId.width * 0.5;
			disqualification.pivotY = agentId.height * 0.5;
			disqualification.x = 68.35;
			disqualification.y = 28.05;
			addChild(disqualification);
			
			environmentEval = new TextField(135, 30, "environment eval", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			environmentEval.pivotX = agentId.width * 0.5;
			environmentEval.pivotY = agentId.height * 0.5;
			environmentEval.x = 68.35;
			environmentEval.y = 59.25;
			addChild(environmentEval);
			
			productEval = new TextField(135, 30, "product eval", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			productEval.pivotX = agentId.width * 0.5;
			productEval.pivotY = agentId.height * 0.5;
			productEval.x = 68.35;
			productEval.y = 91.25;
			addChild(productEval);
			
			adverEval = new TextField(135, 30, "adver eval", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			adverEval.pivotX = agentId.width * 0.5;
			adverEval.pivotY = agentId.height * 0.5;
			adverEval.x = 68.35;
			adverEval.y = 123.25;
			addChild(adverEval);
			
			respondEval = new TextField(135, 30, "respon eval", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			respondEval.pivotX = agentId.width * 0.5;
			respondEval.pivotY = agentId.height * 0.5;
			respondEval.x = 68.35;
			respondEval.y = 156.05;
			addChild(respondEval);
			
			
			// movement
			
			facing = new TextField(135, 30, "facing", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			facing.pivotX = action.width * 0.5;
			facing.pivotY = action.height * 0.5;
			facing.x = 345.15;
			facing.y = -132.75;
			addChild(facing);
			
			deltaX = new TextField(135, 30, "deltaX", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			deltaX.pivotX = agentId.width * 0.5;
			deltaX.pivotY = agentId.height * 0.5;
			deltaX.x = 345.15;
			deltaX.y = -99.95;
			addChild(deltaX);
			
			deltaY = new TextField(135, 30, "deltaY", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			deltaY.pivotX = agentId.width * 0.5;
			deltaY.pivotY = agentId.height * 0.5;
			deltaY.x = 345.15;
			deltaY.y = -68.75;
			addChild(deltaY);
			
			speed = new TextField(135, 30, "speed", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			speed.pivotX = agentId.width * 0.5;
			speed.pivotY = agentId.height * 0.5;
			speed.x = 345.15;
			speed.y = -36.75;
			addChild(speed);
			
			position = new TextField(135, 30, "position", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			position.pivotX = agentId.width * 0.5;
			position.pivotY = agentId.height * 0.5;
			position.x = 345.15;
			position.y = -4.75;
			addChild(position);
			
			coordinate = new TextField(135, 30, "coordinate", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			coordinate.pivotX = agentId.width * 0.5;
			coordinate.pivotY = agentId.height * 0.5;
			coordinate.x = 345.15;
			coordinate.y = 28.05;
			addChild(coordinate);
			
			cartesian = new TextField(135, 30, "cartesian", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			cartesian.pivotX = agentId.width * 0.5;
			cartesian.pivotY = agentId.height * 0.5;
			cartesian.x = 345.15;
			cartesian.y = 59.25;
			addChild(cartesian);
			
			destination = new TextField(135, 30, "destination", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			destination.pivotX = agentId.width * 0.5;
			destination.pivotY = agentId.height * 0.5;
			destination.x = 345.15;
			destination.y = 91.25;
			addChild(destination);
			
			path = new TextField(135, 30, "path", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			path.pivotX = agentId.width * 0.5;
			path.pivotY = agentId.height * 0.5;
			path.x = 345.15;
			path.y = 123.25;
			addChild(path);
			
			isMoving = new TextField(135, 30, "is moving", Assets.getFont(Assets.FONT_SSREGULAR).fontName, 13, 0x333333);
			isMoving.pivotX = agentId.width * 0.5;
			isMoving.pivotY = agentId.height * 0.5;
			isMoving.x = 345.15;
			isMoving.y = 156.05;
			addChild(isMoving);
			
			
			choice = new TextField(135, 30, "Choice #1", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			choice.hAlign = HAlign.LEFT;
			choice.x = -400.8;
			choice.y = 193.45;
			addChild(choice);
			
			percept = new TextField(300, 30, "Percept [Intension]", Assets.getFont(Assets.FONT_SSBOLD).fontName, 16, 0x333333);
			percept.hAlign = HAlign.LEFT;
			percept.x = -250.8;
			percept.y = 193.45;
			addChild(percept);
		}
		
		private function onRandomTriggered(event:Event):void
		{
			selectRandomAgent();
		}
		
		public function selectRandomAgent():void
		{
			var count:int = Data.valuePopulation; //WorldManager.instance.listAgents.length;
			if(count > 0){
				agent = WorldManager.instance.listAgent[Math.floor(Math.random() * count)];
				update();
			}
		}
		
		public function update():void
		{
			if(agent != null){
				action.text = agent.action.getCurrentState().toString().split(".").pop();
				agentId.text = String(agent.agentId);
				district.text = String(agent.district);
				mainRole.text = String(agent.role);
				buyingPower.text = String(agent.buyingPower);
				emotion.text = String(agent.emotion);
				education.text = String(agent.education);
				art.text = String(agent.art);
				athletic.text = String(agent.athletic);
				actionWill.text = String(agent.actionWill);
				
				priceSensitivity.text = String(agent.priceSensitivity);
				priceThreshold.text = String(agent.priceThreshold);			
				qualitySensitivity.text = String(agent.qualitySensitivity);
				qualityThreshold.text = String(agent.qualityThreshold);
				recommendation.text = String(agent.acceptance);
				disqualification.text = String(agent.rejection);
				environmentEval.text = String((agent.decorationMatch.modern+agent.decorationMatch.colorfull+agent.decorationMatch.vintage)+","+(agent.cleanessMatch.product+agent.cleanessMatch.place)+","+(agent.scentMatch.ginger+agent.scentMatch.jasmine+agent.scentMatch.rosemary));
				productEval.text = String(agent.productQualityAssesment);
				adverEval.text = String(agent.adverContactRate.tv+","+agent.adverContactRate.radio+","+agent.adverContactRate.newspaper+","+agent.adverContactRate.internet+","+agent.adverContactRate.event+","+agent.adverContactRate.billboard);
				respondEval.text = String(agent.serviceResponseAssesment);
				
				facing.text = String(agent.facing);
				deltaX.text = String(agent.dX);
				deltaY.text = String(agent.dY);
				speed.text = String(agent.speed.toFixed(3));
				position.text = String("x:"+agent.position.x.toFixed(2)+" y:"+agent.position.y.toFixed(2));
				coordinate.text = String("x:"+agent.coordinate.x.toFixed(2)+" y:"+agent.coordinate.y.toFixed(2));
				cartesian.text = String("x:"+agent.cartesian.x.toFixed(2)+" y:"+agent.cartesian.y.toFixed(2));
				destination.text = String(agent.destination);
				path.text = String(agent.path.length+" node");
				isMoving.text = String(agent.isMoving);
			}
		}	
	}
}