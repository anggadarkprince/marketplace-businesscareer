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
	import sketchproject.modules.states.InfluenceState;
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

	/**
	 * Agent base class.
	 *
	 * @author Angga
	 */
	public class Agent extends Sprite
	{
		public static const ROLE_FREEMAN:String = "freeman";
		public static const ROLE_WORKER:String = "worker";
		public static const ROLE_STUDENT:String = "student";
		public static const ROLE_TRADER:String = "trader";

		public static const DISTRICT_VILLAGE:String = "village";
		public static const DISTRICT_MURBAWISMA:String = "murbawisma";
		public static const DISTRICT_MADYAWISMA:String = "madyawisma";
		public static const DISTRICT_ADIWISMA:String = "adiwisma";

		public static const INFLUENCE_RECOMMENDATION:String = "recommendation"
		public static const INFLUENCE_DISQUALIFICATION:String = "disqualification"

		public var action:StackFSM;

		// graphic character
		public var baseCharacter:MovieClip;
		public var perceptImage:Image;
		public var choiceImage:Image;
		public var npc:String;

		// agent movement
		public var facing:String;
		public var isMoving:Boolean;
		public var dX:Number;
		public var dY:Number;
		public var idle:Boolean;
		public var speed:Number;
		public var position:Point; // isometric coordinate
		public var coordinate:Point; // cartesian coordinate
		public var cartesian:Point; // 2D coordinate
		public var destination:Point;
		public var path:Array;

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
		public var stress:Number;
		public var health:Number;

		// motivation
		public var income:int;
		public var priceSensitivity:int;
		public var qualitySensitivity:int;
		public var susceptibility:int;
		public var followerTendency:int;
		public var acceptance:int;
		public var rejection:int;
		public var choice:int;
		public var unselected:int;
		public var consumption:int;
		public var consumptionTime:Array;
		public var isEating:Boolean;

		// environment taste
		public var decorationMatch:Object;
		public var cleanessMatch:Object;
		public var scentMatch:Object;

		// advertising contact rate
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
		public var visitingAction:IState;
		public var influenceAction:IState;
		public var findingAction:IState;

		// additional vars
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

		public var hasAttendingEventChecked:Boolean;
		public var attendingEventList:Array;

		/**
		 * Default constructor of Agent.
		 *
		 * @param tileCoordinate initial position of agent
		 */
		public function Agent(tileCoordinate:Point)
		{
			action = new StackFSM();

			npc = "char" + GameUtils.randomFor(15);
			facing = "right";
			isMoving = false;
			mainRoleDone = false;
			isGoingEvent = false;
			isGoingTask = false;

			hasAttendingEventChecked = false;
			attendingEventList = new Array();

			isGoingTaskByDay = false;
			isGoingTaskByWeather = false;
			isGoingTaskByDeterminant = false;
			isFlocking = false;
			isFree = false;
			isStress = false;
			isSick = false;
			isEating = false;

			stress = 2;
			health = 8;
			choice = 0;
			unselected = 0;

			speed = 0.5 + Math.random();

			baseCharacter = new MovieClip(Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTextures(npc + "_walk"), Math.ceil(25 * speed));
			baseCharacter.pivotX = -50 + baseCharacter.width * 0.5;
			baseCharacter.pivotY = baseCharacter.height;
			Starling.juggler.add(baseCharacter);
			addChild(baseCharacter);

			perceptImage = new Image(Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("percept_satisfaction"));
			perceptImage.x = 60;
			perceptImage.y = -75;
			perceptImage.visible = false;
			addChild(perceptImage);

			choiceImage = new Image(Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("side1"));
			choiceImage.pivotX = choiceImage.width * 0.5;
			choiceImage.pivotY = choiceImage.height;
			choiceImage.x = 50;
			choiceImage.y = -60;
			choiceImage.visible = false;
			addChild(choiceImage);

			dX = 0;
			dY = 0;

			path = new Array();
			placeAgent(tileCoordinate);

			stepsTillTurn = 25 / speed * 10;
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
			visitingAction = new VisitingState(this);
			influenceAction = new InfluenceState(this);
			findingAction = new FindingState(this);
		}

		/**
		 * Set agent location.
		 *
		 * @param tileCoordinate
		 */
		public function placeAgent(tileCoordinate:Point):void
		{
			coordinate = tileCoordinate;
			cartesian = WorldManager.instance.map.placeAgentLocation(coordinate);
			position = IsoHelper.twoDToIso(cartesian);

			x = position.x;
			y = position.y;
		}

		/**
		 * Update stack finite state machine.
		 */
		public function update():void
		{
			action.update();
		}

		/**
		 * Facing left or right.
		 */
		public function flipFacing():void
		{
			if (this.facing == "right")
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

		/**
		 * Set percept reaction agent againts shop.
		 *
		 * @param contact
		 */
		public function perceptReaction(contact:String):void
		{
			perceptImage.visible = true;
			switch (contact)
			{
				case "influence":
					perceptImage.texture = Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("percept_influence");
					break;
				case "satisaction":
					perceptImage.texture = Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("percept_satisfaction");
					break;
				case "price":
					perceptImage.texture = Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("percept_price");
					break;
				case "quality":
					perceptImage.texture = Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("percept_quality");
					break;
				case "service":
					perceptImage.texture = Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("percept_services");
					break;
				case "need":
					perceptImage.texture = Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("percept_need");
					break;
				case "none":
					perceptImage.visible = false;
					break;
			}
		}

		/**
		 * Set choice reaction after eating.
		 *
		 * @param contact
		 */
		public function choiceReaction(contact:int):void
		{
			choiceImage.visible = true;
			switch (contact)
			{
				case 1:
					choiceImage.texture = Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("side1");
					break;
				case 2:
					choiceImage.texture = Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("side2");
					break;
				case 3:
					choiceImage.texture = Assets.getAtlas(Assets.NPC, Assets.NPC_XML).getTexture("side3");
					break;
			}
		}

		/**
		 * Move agent in map with path has given by A Star.
		 */
		public function moving():void
		{
			// agent must be moving
			if (this.isMoving)
			{
				// character stop then stop walking animation
				if (dY == 0 && dX == 0)
				{
					baseCharacter.stop();
					idle = true;
				}
				// character change direction or start to move so resume walking animation
				else if (idle)
				{
					idle = false;
					baseCharacter.play();
				}

				// now character is moving so change agent position if (!idle && isWalkable())
				if (!idle)
				{
					// update agent position in 2D cartesian coordinate
					cartesian.x += speed * dX;
					cartesian.y += speed * dY;

					// convert from 2D cartesian to isometric
					position = IsoHelper.twoDToIso(cartesian);

					// apply this position to agent
					x = position.x;
					y = position.y;

					// find out and update agent coordinate by 2D cartesian coordinate
					coordinate = IsoHelper.getTileCoordinates(cartesian, WorldManager.instance.map.tileHeight);
				}

				// path has ended then reset moving variable status and skip all code after
				if (path.length == 0)
				{
					dX = dY = 0;
					this.isFirstStep = true;
					this.isMoving = false;

					return;
				}

				// find out if current agent coordinate equal last tile destination then retrieve the next tile
				if (coordinate.equals(destination))
				{
					// agent has new destination path, fetch new destinatiion and take the first step
					if (this.isFirstStep)
					{
						// make sure this destination fetch once, after this move agent to the destination
						// fetch very first tile because agent has been standing over it, later fetch again for next destination 
						destination = path.pop();
						this.isFirstStep = false;
					}
					else
					{
						// wait till agent moves few steps into the tile to make sure close enough in center of tile
						this.stepsTaken += 10;
						if (this.stepsTaken < this.stepsTillTurn)
						{
							// count step taken around 25 iteration til reach stepsTillTurn variable 
							// before that skip all code after
							return;
						}
						// ok waiting agent is over, I think agent is close enough in center then
						// reset stepsTaken variable for next tile and code below will execute
						this.stepsTaken = 0;
					}

					// make sure and set agent in the middle of current tile before turn
					// if waiting step does not close enough or step over from middle, this code will produces glitch
					cartesian = WorldManager.instance.map.placeAgentLocation(coordinate);
					position = IsoHelper.twoDToIso(cartesian);
					x = position.x;
					y = position.y;

					// fresh new destination after reach last tile, turn, find dX,dY
					destination = path.pop();

					// trace("coordinate", coordinate, position, "depth", x + y);
					// trace("agent "+agentId+" current destination ", coordinate, destination, position);

					// +x direction : if agent walk to the right
					if (coordinate.x < destination.x)
					{
						dX = 1;
						facing = "left";
					}
					// -x direction : if agent walk to the left
					else if (coordinate.x > destination.x)
					{
						dX = -1;
						facing = "right";
					}
					// x stay at current x location, move up or down only
					else
					{
						dX = 0;
					}

					// +y direction : if agent move down
					if (coordinate.y < destination.y)
					{
						dY = 1;
						facing = "right";
					}
					// -y direction : if agent move up
					else if (coordinate.y > destination.y)
					{
						dY = -1;
						facing = "left";
					}
					// y stay at current y location, move left or right only
					else
					{
						dY = 0;
					}

					// flip agent facing
					flipFacing();

					// make sure dX is 0 if agent walk to top or bottom
					if (coordinate.x == destination.x)
					{
						dX = 0;
					}
					// make sure dY is 0 if agent walk to  left or right
					else if (coordinate.y == destination.y)
					{
						dY = 0;
					}
				}
			}
		}

		/**
		 * Print agent data.
		 */
		public function getAgentData():void
		{
			trace("[Agent] --------------------------");
			trace("----------------------------------");
			trace("-- personality -------------------");
			trace("---- id", agentId);
			trace("---- role", role);
			trace("---- district", district);
			trace("---- buying power", buyingPower);
			trace("---- emotion", emotion);
			trace("---- education", education);
			trace("---- athletic", athletic);
			trace("---- art", art);
			trace("---- action will", actionWill);
			trace("---- stress", stress);
			trace("---- health", health);

			trace("-- motivation --------------------");
			trace("---- price", priceSensitivity);
			trace("---- price threshold", priceSensitivity - (GameUtils.randomFor(10, false) + 5));
			trace("---- quality", qualitySensitivity);
			trace("---- quality threshold", qualitySensitivity - (GameUtils.randomFor(10, false) + 5));
			trace("---- acceptance", acceptance);
			trace("---- rejection", rejection);
			trace("---- choice", choice);
			trace("---- consumption", consumption);
			trace("---- consumption time", consumptionTime);

			trace("-- environment -------------------");
			trace("---- decoration", decorationMatch.modern, decorationMatch.colorfull, decorationMatch.vintage);
			trace("---- cleaness", cleanessMatch.product, cleanessMatch.place);
			trace("---- scent", scentMatch.ginger, scentMatch.jasmine, scentMatch.rosemary);

			trace("-- advertisment ------------------");
			trace("---- adver tv", adverContactRate.tv);
			trace("---- adver radio", adverContactRate.radio);
			trace("---- adver newspapaer", adverContactRate.newspaper);
			trace("---- adver internet", adverContactRate.internet);
			trace("---- adver event", adverContactRate.event);
			trace("---- adver billboard", adverContactRate.billboard);

			trace("-- quality -----------------------");
			trace("---- quality food 1", productQualityAssesment.food1);
			trace("---- quality food 2", productQualityAssesment.food2);
			trace("---- quality food 3", productQualityAssesment.food3);
			trace("---- quality drink 1", productQualityAssesment.drink1);
			trace("---- quality drink 2", productQualityAssesment.drink2);

			trace("-- service -----------------------");
			trace("---- morale", serviceResponseAssesment.morale);
			trace("---- services", serviceResponseAssesment.services);
			trace("---- productivity", serviceResponseAssesment.productivity);

			trace("-- influence ---------------------");
			trace("---- shop player", serviceResponseAssesment.shopPlayer);
			trace("---- shop competitor1", serviceResponseAssesment.shopCompetitor1);
			trace("---- shop competitor2", serviceResponseAssesment.shopCompetitor2);
			trace("----------------------------------\n");
		}
	}
}
