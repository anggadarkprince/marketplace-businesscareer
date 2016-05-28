package sketchproject.utilities
{
	import flash.geom.Point;

	/**
	 * Isometric conversion helper.
	 *
	 * @author Angga
	 */
	public class IsoHelper
	{

		/**
		 * Convert an isometric point to 2D.
		 *
		 * @param pt isometric location
		 * @return Point orthogonal location.
		 */
		public static function isoTo2D(pt:Point):Point
		{
			var tempPt:Point = new Point(0, 0);
			tempPt.x = (2 * pt.y + pt.x) / 2;
			tempPt.y = (2 * pt.y - pt.x) / 2;

			return (tempPt);
		}

		/**
		 * Convert a 2d point to isometric.
		 *
		 * @param pt orthogonal location
		 * @return isometric location
		 */
		public static function twoDToIso(pt:Point):Point
		{
			var tempPt:Point = new Point(0, 0);
			tempPt.x = pt.x - pt.y;
			tempPt.y = (pt.x + pt.y) / 2;

			return (tempPt);
		}

		/**
		 * Convert a 2d point to coordinate eg. (0,0) (3,5).
		 *
		 * @param pt tile coordinate
		 * @param tileHeight
		 * @return tile real position.
		 */
		public static function getTileCoordinates(pt:Point, tileHeight:Number):Point
		{
			var tempPt:Point = new Point(0, 0);
			tempPt.x = Math.floor(pt.x / tileHeight);
			tempPt.y = Math.floor(pt.y / tileHeight);

			return (tempPt);
		}

		/**
		 * Convert specific tile coordinate to 2d point eg. (100, 50) (500,750).
		 *
		 * @param pt
		 * @param tileHeight
		 * @return
		 */
		public static function get2dFromTileCoordinates(pt:Point, tileHeight:Number):Point
		{
			var tempPt:Point = new Point(0, 0);
			tempPt.x = pt.x * tileHeight;
			tempPt.y = pt.y * tileHeight;

			return (tempPt);
		}
	}
}
