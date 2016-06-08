package sketchproject.modules.states
{
	import flash.geom.Point;

	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.modules.DecisionFunction;
	import sketchproject.modules.MotivationFunction;
	import sketchproject.modules.PathFinder;
	import sketchproject.modules.Shop;
	import sketchproject.utilities.GameUtils;
	import sketchproject.utilities.IsoHelper;

	/**
	 * Agent takes a choice of brands and visit the shop.
	 *
	 * @author Angga
	 */
	public class EatingState implements IState
	{
		private var agent:Agent;
		private var name:String;
		private var updated:Boolean;
		private var shopName:String;
		private var shopCoordinate:Point;
		private var shop:Shop;
		private var motivationFunction:MotivationFunction;
		private var decisionFunction:DecisionFunction;

		/**
		 * Default constructor of EatingState.
		 *
		 * @param agent
		 */
		public function EatingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "eating";
			motivationFunction = new MotivationFunction();
			decisionFunction = new DecisionFunction();
		}

		/**
		 * Initialize and calculate agent's choice.
		 */
		public function initialize():void
		{
			trace("      |-- [state:eating] agent id", agent.agentId, ": onEnter");

			updated = false;

			shopCoordinate = new Point();

			var product:String = Shop.productList[GameUtils.randomFor(Shop.productList.length) - 1];

			if (agent.role == Agent.ROLE_FREEMAN)
			{
				shop = decisionFunction.accidentalSelection(WorldManager.instance.listShop, agent);
			}
			else
			{
				// do the math
				var decisionMaking:uint = GameUtils.randomFor(100);
				if (decisionMaking < 80)
				{
					// optimistic agent					
					trace("        |-- [state:eating] method optimistic");
					shop = motivationFunction.motivation(WorldManager.instance.listShop, agent, product);
				}
				else if (decisionMaking < 90)
				{
					// pesimistic agent
					trace("        |-- [state:eating] method pesimistic");
					shop = decisionFunction.influenceSelection(WorldManager.instance.listShop, agent);
				}
				else
				{
					// neutral agent					
					trace("        |-- [state:eating] method neutral");
					shop = decisionFunction.accidentalSelection(WorldManager.instance.listShop, agent);
				}
			}

			agent.choice = shop.shopId;
			agent.choiceReaction(agent.choice);			

			shop.transactionTotal += 1;
			shop.grossProfit += motivationFunction.calculateProductPrice(shop, product) * 1000;

			shopCoordinate = shop.districtCoordinate;
			shopName = shop.shopName;

			agent.destination = agent.coordinate;
			agent.path.splice(0, agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, shopCoordinate.x, shopCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(shopCoordinate);
			agent.isMoving = true;
			agent.perceptReaction("need");

			trace("        |-- [state:eating] choice shop id", shop.shopId, "name", shop.shopName);
			trace("        |-- [state:eating] product", product, "price", motivationFunction.calculateProductPrice(shop, product));
			trace("        |-- [state:eating] transaction #", shop.transactionTotal, "profit", shop.grossProfit);
			trace("        |-- [state:eating] destination", shopCoordinate);
			trace("        |-- [state:eating] path", agent.path);
		}

		/**
		 * Update state of eating.
		 */
		public function update():void
		{
			if (!updated)
			{
				trace("      |-- [state:eating] agent id", agent.agentId, ": onUpdate");
				updated = true;
			}

			if (agent.isMoving)
			{
				agent.moving();
			}
			else
			{
				var cartesian:Point = IsoHelper.get2dFromTileCoordinates(shopCoordinate, WorldManager.instance.map.tileHeight);
				var isometric:Point = IsoHelper.twoDToIso(cartesian);
				isometric.x = isometric.x + 50;

				agent.alpha = 0.3;
				WorldManager.instance.map.spawnCoin(isometric);
				
				agent.perceptReaction("satisfaction");

				trace("        |-- [state:eating] agent id", agent.agentId, "arrived in", shopName);
				
				agent.action.popState();
				agent.action.logState();
			}
		}

		/**
		 * Destroy eating state resources.
		 */
		public function destroy():void
		{
			trace("  |-- [state:eating] agent id", agent.agentId, ": onExit");

			updated = false;
			agent.isEating = false;
			agent.alpha = 1;
		}

		/**
		 * Print class name.
		 *
		 * @return
		 */
		public function toString():String
		{
			return "sketchproject.modules.states.EatingState";
		}
	}
}
