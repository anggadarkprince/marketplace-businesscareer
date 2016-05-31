package sketchproject.managers
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Cubic;

	import sketchproject.core.Assets;
	import sketchproject.core.Data;
	import sketchproject.core.Game;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;

	/**
	 * Reward manager to generate gem and coin.
	 *
	 * @author Angga
	 */
	public class RewardManager
	{
		public static const REWARD_COIN:String = "coin";
		public static const REWARD_GEM:String = "gem";

		public static const SPAWN_ONCE:String = "once";
		public static const SPAWN_LOW:String = "low";
		public static const SPAWN_AVERAGE:String = "average";
		public static const SPAWN_HIGH:String = "high";

		private var listItem:Array;
		private var coin:*;

		private var fireworkManager:FireworkManager;

		private var generate:int;
		private var type:String;
		private var reward:Number;

		private var isReward:Boolean;
		private var container:DisplayObjectContainer;

		/**
		 * Default constructor of RewardManager.
		 *
		 * @param typeReward
		 * @param spawnRate
		 * @param isReward
		 * @param container
		 */
		public function RewardManager(typeReward:String = REWARD_COIN, spawnRate:String = SPAWN_AVERAGE, isReward:Boolean = true, container:DisplayObjectContainer = null)
		{
			listItem = new Array();

			this.isReward = isReward;
			this.container = container;
			fireworkManager = new FireworkManager(Game.overlayStage);

			initialize(typeReward, spawnRate);
		}

		/**
		 * Create number of reward item.
		 *
		 * @param typeReward
		 * @param spawnRate
		 */
		public function initialize(typeReward:String = REWARD_COIN, spawnRate:String = SPAWN_AVERAGE):void
		{
			switch (spawnRate)
			{
				case SPAWN_ONCE:
					generate = 1;
					break;
				case SPAWN_LOW:
					generate = 5;
					break;
				case SPAWN_AVERAGE:
					generate = 10;
					break;
				case SPAWN_HIGH:
					generate = 15;
					break;
			}

			if (typeReward == RewardManager.REWARD_COIN)
			{
				type = RewardManager.REWARD_COIN;
			}
			else
			{
				type = RewardManager.REWARD_GEM;
			}
		}

		/**
		 * Spawn reward item by given location.
		 *
		 * @param xStart
		 * @param yStart
		 * @param xDest
		 * @param yDest
		 * @param reward
		 * @param isAdded
		 */
		public function spawn(xStart:Number, yStart:Number, xDest:Number, yDest:Number, reward:int = 0, isAdded:Boolean = true):void
		{
			if (this.isReward)
			{
				if (type == RewardManager.REWARD_COIN)
				{
					if (isAdded)
					{
						Data.cash += reward;
					}
					else
					{
						Data.cash -= reward;
					}
				}
				else
				{
					if (isAdded)
					{
						Data.point += reward;
					}
					else
					{
						Data.point -= reward;
					}
				}
			}

			if (generate == 1)
			{
				update(xStart, yStart, xDest, yDest);
			}
			else
			{
				for (var i:int = 0; i < generate; i++)
				{
					if (Math.random() < 0.5)
					{
						update(xStart, yStart, xDest, yDest);
					}
				}
			}
		}

		/**
		 * Update reward animation until destroyed.
		 *
		 * @param xStart
		 * @param yStart
		 * @param xDest
		 * @param yDest
		 */
		public function update(xStart:Number, yStart:Number, xDest:Number, yDest:Number):void
		{
			if (type == RewardManager.REWARD_COIN)
			{
				coin = new MovieClip(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTextures("coin"), 8);
				coin.pivotX = coin.width * 0.5;
				coin.pivotY = coin.height * 0.5;
				Starling.juggler.add(coin);
			}
			else
			{
				coin = new Image(Assets.getAtlas(Assets.CONTENT, Assets.CONTENT_XML).getTexture("hud_icon_diamond"));
				coin.pivotX = coin.width * 0.5;
				coin.pivotY = coin.height * 0.5;
			}

			coin.alpha = 0;

			if (generate == 1 && container != null)
			{
				coin.x = xStart;
				coin.y = yStart;

				listItem.push(coin);
				container.addChild(coin);
			}
			else
			{
				coin.x = Math.random() * 300 + (xStart - 150);
				coin.y = Math.random() * 100 + (yStart - 50);

				listItem.push(coin);
				Game.overlayStage.addChild(coin);
				Game.overlayStage.swapChildren(coin, Game.overlayStage.getChildAt(Game.overlayStage.numChildren - 1));
			}

			TweenMax.to(coin, 0.2, {alpha: 1, delay: (Math.random() * 2) - 1, onComplete: upCoin, onCompleteParams: [coin, coin.x, yStart, xDest, yDest]});
		}

		/**
		 * Animate show up reward item.
		 *
		 * @param coin
		 * @param xStart
		 * @param yStart
		 * @param xDest
		 * @param yDest
		 */
		public function upCoin(coin:*, xStart:Number, yStart:Number, xDest:Number, yDest:Number):void
		{
			Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
			TweenMax.to(coin, 0.3, {y: coin.y - 60, ease: Cubic.easeOut, onComplete: downCoin, onCompleteParams: [coin, xStart, yStart, xDest, yDest]});
		}

		/**
		 * Animate down reward item, bouncing.
		 *
		 * @param coin
		 * @param xStart
		 * @param yStart
		 * @param xDest
		 * @param yDest
		 */
		public function downCoin(coin:*, xStart:Number, yStart:Number, xDest:Number, yDest:Number):void
		{
			TweenMax.to(coin, 1, {y: yStart, ease: Bounce.easeOut, onComplete: endCoin, onCompleteParams: [coin, xStart, yDest, xDest, yDest]});
		}

		/**
		 * Kick out the reward item and remove.
		 *
		 * @param coin
		 * @param xStart
		 * @param yStart
		 * @param xDest
		 * @param yDest
		 */
		public function endCoin(coin:*, xStart:Number, yStart:Number, xDest:Number, yDest:Number):void
		{
			TweenMax.to(coin, 0.5, {x: xDest, y: yDest, onComplete: function():void
			{
				if (isReward)
				{
					if (Math.random() < 0.5)
					{
						fireworkManager.spawn(xDest, yDest);
					}
				}
				Assets.sfxChannel = Assets.sfxCoin.play(0, 0, Assets.sfxTransform);
				coin.removeFromParent(true);
			}});
		}
	}
}
