package sketchproject.modules.states
{
	import flash.geom.Point;

	import sketchproject.interfaces.IState;
	import sketchproject.managers.WorldManager;
	import sketchproject.modules.Agent;
	import sketchproject.modules.PathFinder;
	import sketchproject.modules.Shop;
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
		private var isBought:Boolean;
		private var shop:Shop;

		/**
		 * Default constructor of EatingState.
		 *
		 * @param agent
		 */
		public function EatingState(agent:Agent)
		{
			this.agent = agent;
			this.name = "eating";
		}

		/**
		 * Initialize and calculate agent's choice.
		 */
		public function initialize():void
		{
			trace("      |-- [state:eating] agent id", agent.agentId, ": onEnter");

			updated = false;

			shopCoordinate = new Point();

			isBought = false;

			// do the math

			// optimistic agent

			// pesimistic agent

			// neutral agent.

			if (agent.choice == 1)
			{
				shop = WorldManager.instance.listShop[0] as Shop;
			}
			else if (agent.choice == 2)
			{

				shop = WorldManager.instance.listShop[1] as Shop;
			}
			else if (agent.choice == 3)
			{
				shop = WorldManager.instance.listShop[2] as Shop;
			}

			shopCoordinate = shop.districtCoordinate;
			shopName = shop.shopName;

			agent.destination = agent.coordinate;
			agent.path.splice(0, agent.path.length);
			agent.path = PathFinder.go(agent.coordinate.x, agent.coordinate.y, shopCoordinate.x, shopCoordinate.y, WorldManager.instance.map.levelData);
			agent.path.unshift(shopCoordinate);
			agent.isMoving = true;

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

				WorldManager.instance.map.spawnCoin(isometric);
				agent.alpha = 0.3;
				isBought = true;

				trace("        |-- [state:eating] agent id", agent.agentId, "arrived in", shopName);
			}
		}

		/**
		 * Destroy eating state resources.
		 */
		public function destroy():void
		{
			trace("  |-- [state:wandering] agent id", agent.agentId, ": onExit");

			agent.alpha = 1;
			updated = false;
			isBought = false;
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
