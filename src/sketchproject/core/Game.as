package sketchproject.core
{
	
	import sketchproject.interfaces.IState;
	import sketchproject.states.Gameworld;
	import sketchproject.states.MainMenu;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{		
		/** game state constant */
		public static const MENU_STATE:int = 1;
		public static const WORLD_STATE:int = 2;
				
		/** current state which iterate execution */
		private var currentState:IState;
		
		/** game layer, first, gameStage as main stage for currentState, second, overlayStage for particle */
		public static var gameStage:Sprite;
		public static var overlayStage:Sprite;
		private var data:DataLoader;
		
		/** x, y position for custom cursor sprite */
		private var xPos:Number = 0;
		private var yPos:Number = 0;
				
		/**
		 * Game constructor
		 */
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * Initializing game stage
		 * @params $event passing Added to Stage event
		 * @return void
		 */
		private function init(event:Event):void {			
			gameStage = new Sprite();
			addChild(gameStage);
			
			overlayStage = new Sprite();
			addChild(overlayStage);
							
			data = new DataLoader();
			data.addEventListener(DataLoader.DATA_LOADED, onGameDataLoaded);
			data.loadMapData();						
			data.loadAdvertisementData();						
			data.loadDistrict();						
			data.loadEventData();
			data.loadResearchData();
			data.loadTipsData();
			data.loadTransactionData();
			data.loadWeatherData();
			//data.loadData();
		}
		
		private function onGameDataLoaded(event:Event):void
		{
			Assets.init();
			changeState(MENU_STATE);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * Game state manager, switch between state to another state
		 * @params $state passing current state
		 * @return void
		 */
		public function changeState(state:int):void {
			if(currentState != null) {
				currentState.destroy();
				currentState = null;
			}
			
			switch(state) {				
				case MENU_STATE:
					currentState = new MainMenu(this);
					break;
				
				case WORLD_STATE:
					currentState = new Gameworld(this);
					break;
			}
			
			gameStage.addChild(Sprite(currentState));			
		}
		
		/**
		 * Update game frame, 
		 * Update cursor sprite position follow mouse and arraging by game screen
		 * @params $event passing Enter Frame event
		 * @return void
		 */
		private function update(event:Event):void {
			currentState.update();		
		}
		
	}
}