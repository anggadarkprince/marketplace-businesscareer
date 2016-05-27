package sketchproject.modules
{
	import flash.geom.Point;
	
	import sketchproject.core.Assets;
	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.states.EatingState;
	import sketchproject.modules.states.FindingState;
	import sketchproject.modules.states.HomewardState;
	import sketchproject.modules.states.IdleState;
	import sketchproject.modules.states.PlayingState;
	import sketchproject.modules.states.StudyingState;
	import sketchproject.modules.states.TradingState;
	import sketchproject.modules.states.VacationState;
	import sketchproject.modules.states.VisitingState;
	import sketchproject.modules.states.WanderingState;
	import sketchproject.modules.states.WorkingState;
	import sketchproject.utilities.GameUtils;
	import sketchproject.utilities.IsoHelper;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;

	public class Agent extends Sprite
	{
		public static const ROLE_FREEMAN:String = "freeman";
		public static const ROLE_WORKER:String = "worker";
		public static const ROLE_STUDENT:String = "student";
		public static const ROLE_TRADER:String = "trader";
		
		public var action:StackFSM;
		
		// graphic character
		public var baseCharacter:MovieClip;
		public var perceptImage:Image;
		public var sideImage:Image;
		public var npc:String;
		
		// personality trait
		public var agentId:int;
		public var role:String;
		public var district:String;
		public var buyingPower:int;		
		public var emotion:int;
		public var education:Number;
		public var athletic:Number;
		public var art:Number;
		public var actionWill:Number;
				
		// agent movement
		public var facing:String;
		public var isMoving:Boolean;
		public var dX:Number;
		public var dY:Number;
		public var idle:Boolean;
		public var speed:Number;
		public var position:Point;
		public var coordinate:Point;
		public var cartesian:Point;
		public var destination:Point;
		public var path:Array;
		
		// motivation
		public var priceSensitivity:int;
		public var priceThreshold:int;
		public var qualitySensitivity:int;
		public var qualityThreshold:int;
		public var acceptance:int;		
		public var rejection:int;	
		public var choice:int;
		public var consumption:int;
		public var consumptionTime:Array;
		
		// environment evaluation, scent, cleaness, decoration
		public var decorationMatch:Object;
		public var cleanessMatch:Object;
		public var scentMatch:Object;
		
		// adverising contact rate
		public var adverContactRate:Object;
		
		// product quality assesment
		public var productQualityAssesment:Object;
		
		// respond
		public var serviceResponseAssesment:Object;
		
		// influence
		public var shopInfluence:Object;
		
		// agent states
		public var idleAction:IState;
		public var wanderingAction:IState;
		public var workingAction:IState;
		public var studyingAction:IState;
		public var tradingAction:IState;
		public var eatingAction:IState;
		public var playingAction:IState;
		public var vacationAction:IState;
		public var homewardAction:IState;
		public var findingAction:IState;
		public var visitingAction:IState;
		
		// additional
		public var stepsTillTurn:uint;
		public var stepsTaken:uint;	
		public var isFirstStep:Boolean;
		public var mainRoleDone:Boolean;
		
		public var isGoingTaskByDay:Boolean;
		public var isGoingTaskByWeather:Boolean;
		public var isGoingTaskByDeterminant:Boolean;
		public var isFlocking:Boolean;
		public var isFree:Boolean;
		public var isStress:Boolean;
		public var isSick:Boolean;
		public var freeTime:int;
		
		public var isGoingTask:Boolean;
		public var isGoingEvent:Boolean;
		public var eventId:int;
		public var targetDistrict:String;
		public var stress:Number;
		public var health:Number;
		
		public function Agent(tileCoordinate:Point)
		{
			action = new StackFSM();
			
			npc = "char"+GameUtils.randomFor(15);
			facing = "right";
			isMoving = false;
			mainRoleDone = false;
			isGoingEvent = false;
			isGoingTask = false;
			
			isGoingTaskByDay = false;
			isGoingTaskByWeather = false;
			isGoingTaskByDeterminant = false;
			isFlocking = false;
			isFree = false;
			isStress = false;
			isSick = false;
			
			
			stress = 2;
			health = 8;
			
			speed = 0.5 + Math.random();
			
			baseCharacter = new MovieClip(Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTextures(npc+"_walk"), Math.ceil(25*speed));		
			baseCharacter.pivotX = -50 + baseCharacter.width * 0.5;
			baseCharacter.pivotY = baseCharacter.height;
			Starling.juggler.add(baseCharacter);
			addChild(baseCharacter);
			
			perceptImage = new Image(Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("percept_satisfaction"));
			perceptImage.x = 60;
			perceptImage.y = -75;
			perceptImage.visible = false;
			addChild(perceptImage);
			/*
			if(Math.random() < 0.5){				
				var p:int = GameUtils.randomFor(3);
				if(p == 1){
					perceptReaction("satisaction");
				}
				if(p == 2){
					perceptReaction("price");
				}
				if(p == 3){
					perceptReaction("influence");
				}
				if(p == 3){
					perceptReaction("service");
				}
				if(p == 3){
					perceptReaction("need");
				}
				if(p == 3){
					perceptReaction("quality");
				}
			}
			*/
			sideImage = new Image(Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("side1"));
			sideImage.pivotX = sideImage.width * 0.5;
			sideImage.pivotY = sideImage.height;
			sideImage.x = 50;
			sideImage.y = -60;
			sideImage.visible = false;
			addChild(sideImage);
			/*
			if(Math.random() < 0.5){				
				var side:int = GameUtils.randomFor(3);
				if(side == 1){
					choiceReaction("player");
				}
				if(side == 2){
					choiceReaction("competitor1");
				}
				if(side == 3){
					choiceReaction("competitor2");
				}
			}*/
						
			dX = 0;
			dY = 0;
			
			path = new Array();
			coordinate = tileCoordinate;
			cartesian = WorldManager.instance.map.placeAgentLocation(coordinate);
			position = IsoHelper.twoDToIso(cartesian);	

			x = position.x;
			y = position.y;
			
			stepsTillTurn = 25/speed*10;
			stepsTaken = 0;
			
			idleAction = new IdleState(this);
			wanderingAction = new WanderingState(this);
			workingAction = new WorkingState(this);
			studyingAction = new StudyingState(this);
			tradingAction = new TradingState(this);
			homewardAction = new HomewardState(this);
			playingAction = new PlayingState(this);
			vacationAction = new VacationState(this);
			eatingAction = new EatingState(this);
			findingAction = new FindingState(this);
			visitingAction = new VisitingState(this);
		}
		
		public function placeAgent(tileCoordinate:Point):void
		{
			coordinate = tileCoordinate;
			cartesian = WorldManager.instance.map.placeAgentLocation(coordinate);
			position = IsoHelper.twoDToIso(cartesian);	
			
			x = position.x;
			y = position.y;
		}
		
		public function update():void
		{
			action.update();
		}
				
		public function flipFacing():void
		{
			if(this.facing == "right")
			{
				baseCharacter.scaleX = -1;
				baseCharacter.x = 110 - baseCharacter.width * 0.5;
			}
			else
			{
				baseCharacter.scaleX = 1;
				baseCharacter.x = 0;
			}			
		}
		
		public function perceptReaction(contact:String):void
		{
			perceptImage.visible = true;
			switch(contact){
				case "influence":
					perceptImage.texture = Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("percept_influence");
					break;
				case "satisaction":
					perceptImage.texture = Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("percept_satisfaction");
					break;
				case "price":
					perceptImage.texture = Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("percept_price");
					break;
				case "quality":
					perceptImage.texture = Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("percept_quality");
					break;
				case "service":
					perceptImage.texture = Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("percept_services");
					break;
				case "need":
					perceptImage.texture = Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("percept_need");
					break;
			}
		}
		
		public function choiceReaction(contact:String):void
		{
			sideImage.visible = true;
			switch(contact){
				case "player":
					sideImage.texture = Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("side1");
					break;
				case "competitor1":
					sideImage.texture = Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("side2");
					break;
				case "competitor2":
					sideImage.texture = Assets.getAtlas(Assets.NPC,Assets.NPC_XML).getTexture("side3");
					break;
			}
		}
		
		public function moving():void
		{
			if(this.isMoving)
			{
				//character stop then stop character walking
				if (dY == 0 && dX == 0)
				{
					baseCharacter.stop();
					idle = true;
				}
				// character change direction or start to move then resume character walking
				else if (idle)
				{
					idle = false;
					baseCharacter.play();
				}
				
				// character moving and no against the wall then change position if (!idle && isWalkable())
				if (!idle)
				{
					// update agent position
					cartesian.x +=  speed * dX;
					cartesian.y +=  speed * dY;		
					
					position = IsoHelper.twoDToIso(cartesian);
					
					x = position.x;
					y = position.y;
					
					// update agent coordinate
					coordinate = IsoHelper.getTileCoordinates(cartesian, WorldManager.instance.map.tileHeight);	
				}
				
				// path has ended
				if(path.length == 0){
					dX = dY = 0;
					this.isFirstStep = true;
					this.isMoving = false;
					
					return;
				}
				
				// reached current destination, set new, change direction
				if(coordinate.equals(destination)){
					if(this.isFirstStep){						
						destination = path.pop();
						this.isFirstStep = false;						
					}
					else{
						// wait till we are few steps into the tile before we turn
						this.stepsTaken+=10;
						if(this.stepsTaken < this.stepsTillTurn){
							return;
						}
						this.stepsTaken=0;
					}
					
					// place the hero at tile middle before turn
					cartesian = WorldManager.instance.map.placeAgentLocation(coordinate);
					position = IsoHelper.twoDToIso(cartesian);					
					x = position.x;
					y = position.y;
					
					// new point, turn, find dX,dY
					destination = path.pop();
					//trace("coordinate",coordinate,position,"depth",x+y);
					//trace("agent "+agentId+" current destination ",coordinate, destination, position);
					
					// x direction
					
					if(coordinate.x < destination.x){
						dX = 1;
						facing = "left";						
					}
					else if(coordinate.x > destination.x){
						dX = -1;
						facing = "right";
					}
					else{
						dX = 0;
					}
										
					// y direction
					if(coordinate.y < destination.y){
						dY = 1;
						facing = "right";
					}
					else if(coordinate.y > destination.y){
						dY = -1;
						facing = "left";
					}
					else{
						dY = 0;
					}
					
					flipFacing();
					
					//top or bottom
					if(coordinate.x == destination.x){
						dX = 0;
					}
					//left or right
					else if(coordinate.y == destination.y){
						dY = 0;
					}
				}	
			}
		}
	}
}