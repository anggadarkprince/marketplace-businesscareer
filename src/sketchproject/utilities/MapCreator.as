package sketchproject.utilities
{
	import sketchproject.core.Assets;

	import starling.display.Image;

	/**
	 * Map helper to build tile.
	 *
	 * @author Angga
	 */
	public class MapCreator
	{
		/**
		 * Get texture overlay.
		 *
		 * @param id of tile
		 * @return image texture
		 */
		public static function getMapOverlay(id:uint):Image
		{
			var tile:Image;
			switch (id)
			{
				case 0:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("dot_grass"));
					break;
				case 1:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("dot_wall"));
					break;
				case 2:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("dot_player"));
					break;
			}
			return tile;
		}

		/**
		 * Get map tile of gameworld.
		 * id 1 - 23 are terrains
		 * id 24 - 93 are levels
		 * id 97 - 99 are shops
		 *
		 * @param id of tile
		 * @return image texture
		 */
		public static function getMapTile(id:uint):Image
		{
			var tile:Image;

			switch (id)
			{
				case 1:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("crossroad"));
					tile.name = "crossroad";
					break;
				case 2:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("dirt"));
					tile.name = "dirt";
					break;
				case 3:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("grass"));
					tile.name = "grass";
					break;
				case 4:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadCornerES"));
					tile.name = "roadCornerES";
					break;
				case 5:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadCornerNE"));
					tile.name = "roadCornerNE";
					break;
				case 6:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadCornerNW"));
					tile.name = "roadCornerNW";
					break;
				case 7:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadCornerWS"));
					tile.name = "roadCornerWS";
					break;
				case 8:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadEast"));
					tile.name = "roadEast";
					break;
				case 9:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadEndEast"));
					tile.name = "roadEndEast";
					break;
				case 10:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadEndNorth"));
					tile.name = "roadEndNorth";
					break;
				case 11:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadEndSouth"));
					tile.name = "roadEndSouth";
					break;
				case 12:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadEndWest"));
					tile.name = "roadEndWest";
					break;
				case 13:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadNorth"));
					tile.name = "roadNorth";
					break;
				case 14:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadTEast"));
					tile.name = "roadTEast";
					break;
				case 15:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadTNorth"));
					tile.name = "roadTNorth";
					break;
				case 16:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadTSouth"));
					tile.name = "roadTSouth";
					break;
				case 17:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("roadTWest"));
					tile.name = "roadTWest";
					break;
				case 18:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("treeConiferTallAll"));
					tile.name = "treeConiferTallAll";
					break;
				case 19:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("treeConiferTallTile"));
					tile.name = "treeConiferTallTile";
					break;
				case 20:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("treeTallAll"));
					tile.name = "treeTallAll";
					break;
				case 21:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("treeTallTile"));
					tile.name = "treeTallTile";
					break;
				case 22:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("water"));
					tile.name = "water";
					break;
				case 23:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("waterBeachSouth"));
					tile.name = "waterBeachSouth";
					break;
				case 24:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("airportBuilding"));
					tile.name = "airportBuilding";
					break;
				case 25:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("squareBuildingSmall"));
					tile.name = "squareBuildingSmall";
					break;
				case 26:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("govermentBuilding"));
					tile.name = "govermentBuilding";
					break;
				case 27:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("blueBuilding"));
					tile.name = "blueBuilding";
					break;
				case 28:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("slightBuilding"));
					tile.name = "slightBuilding";
					break;
				case 29:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("squareBuildingLarge"));
					tile.name = "squareBuildingLarge";
					break;
				case 30:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("communicationBuilding"));
					tile.name = "communicationBuilding";
					break;
				case 31:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("doubleSkyscapper"));
					tile.name = "doubleSkyscapper";
					break;
				case 32:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("stripBuilding"));
					tile.name = "stripBuilding";
					break;
				case 33:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("townAuditorium"));
					tile.name = "townAuditorium";
					break;
				case 34:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("townHallOffice"));
					tile.name = "townHallOffice";
					break;
				case 35:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("movieTheater"));
					tile.name = "movieTheater";
					break;
				case 36:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("productionFactory"));
					tile.name = "productionFactory";
					break;
				case 37:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("warehouseFactory"));
					tile.name = "warehouseFactory";
					break;
				case 38:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("powerPlant"));
					tile.name = "powerPlant";
					break;
				case 39:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("steamBuilding"));
					tile.name = "steamBuilding";
					break;
				case 40:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("factoryMachine"));
					tile.name = "factoryMachine";
					break;
				case 41:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("storageFactory"));
					tile.name = "storageFactory";
					break;
				case 42:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("freezerFactory"));
					tile.name = "freezerFactory";
					break;
				case 43:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("packagingBuilding"));
					tile.name = "packagingBuilding";
					break;
				case 44:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("smokestackFactory"));
					tile.name = "smokestackFactory";
					break;
				case 45:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("factoryOfficeWhite"));
					tile.name = "factoryOfficeWhite";
					break;
				case 46:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("factoryOfficeLarge"));
					tile.name = "factoryOfficeLarge";
					break;
				case 47:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("containerCargo"));
					tile.name = "containerCargo";
					break;
				case 48:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("motelBuilding"));
					tile.name = "motelBuilding";
					break;
				case 49:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("smallHouse"));
					tile.name = "smallHouse";
					break;
				case 50:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("mediumHouse"));
					tile.name = "mediumHouse";
					break;
				case 51:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("largeHouse"));
					tile.name = "largeHouse";
					break;
				case 52:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("cityMonument"));
					tile.name = "cityMonument";
					break;
				case 53:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("playgroundArea"));
					tile.name = "playgroundArea";
					break;
				case 54:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("universityBuilding"));
					tile.name = "universityBuilding";
					break;
				case 55:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("schoolBuilding"));
					tile.name = "schoolBuilding";
					break;
				case 56:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("libraryBuilding"));
					tile.name = "libraryBuilding";
					break;
				case 57:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("ramayanaStore"));
					tile.name = "ramayanaStore";
					break;
				case 58:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("mcDonals"));
					tile.name = "mcDonals";
					break;
				case 59:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("matahariStore"));
					tile.name = "matahariStore";
					break;
				case 60:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("gramediaStore"));
					tile.name = "gramediaStore";
					break;
				case 61:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("kfcStore"));
					tile.name = "kfcStore";
					break;
				case 62:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("giantStore"));
					tile.name = "giantStore";
					break;
				case 63:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("pizzahutStore"));
					tile.name = "pizzahutStore";
					break;
				case 64:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("twinSkyscraper"));
					tile.name = "twinSkyscraper";
					break;
				case 65:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("twinBrigdeSkyscraper"));
					tile.name = "twinBrigdeSkyscraper";
					break;
				case 66:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("highSkyscraper"));
					tile.name = "highSkyscraper";
					break;
				case 67:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("baseballStadium"));
					tile.name = "baseballStadium";
					break;
				case 68:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("basketArena"));
					tile.name = "basketArena";
					break;
				case 69:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("soccerStadium"));
					tile.name = "soccerStadium";
					break;
				case 70:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("grahaHallBuilding"));
					tile.name = "grahaHallBuilding";
					break;
				case 71:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("cityTower"));
					tile.name = "cityTower";
					break;
				case 72:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("wonderlandCarnival"));
					tile.name = "wonderlandCarnival";
					break;
				case 73:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("museumBuilding"));
					tile.name = "museumBuilding";
					break;
				case 74:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("hospitalBuilding"));
					tile.name = "hospitalBuilding";
					break;
				case 75:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("beachGuardTower"));
					tile.name = "beachGuardTower";
					break;
				case 76:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("umbrellaBeach"));
					tile.name = "umbrellaBeach";
					break;
				case 77:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("beachBridge"));
					tile.name = "beachBridge";
					break;
				case 78:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("obstacleArea"));
					tile.name = "obstacleArea";
					break;
				case 79:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("generalOffice"));
					tile.name = "generalOffice";
					break;
				case 80:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("apartementBuilding"));
					tile.name = "apartementBuilding";
					break;
				case 81:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("factoryParking"));
					tile.name = "factoryParking";
					break;
				case 82:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("atriumBuilding"));
					tile.name = "atriumBuilding";
					break;
				case 83:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("steamMachine"));
					tile.name = "steamMachine";
					break;
				case 84:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("gasStation"));
					tile.name = "gasStation";
					break;
				case 85:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("generalShop"));
					tile.name = "generalShop";
					break;
				case 86:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("gameCenter"));
					tile.name = "gameCenter";
					break;
				case 87:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("badmintonField"));
					tile.name = "badmintonField";
					break;
				case 88:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("villageHouse"));
					tile.name = "villageHouse";
					break;
				case 89:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("containerTracker"));
					tile.name = "containerTracker";
					break;
				case 90:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("cargoShip"));
					tile.name = "cargoShip";
					break;
				case 91:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("citySymbol"));
					tile.name = "citySymbol";
					break;
				case 92:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("cityParkingSmall"));
					tile.name = "cityParkingSmall";
					break;
				case 93:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("cityParkingLarge"));
					tile.name = "cityParkingLarge";
					break;
				case 97:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("shop1"));
					tile.name = "shop1";
					break;
				case 98:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("shop2"));
					tile.name = "shop2";
					break;
				case 99:
					tile = new Image(Assets.getAtlas(Assets.ISOMERTIC, Assets.ISOMERTIC_XML).getTexture("shop3"));
					tile.name = "shop3";
					break;
			}
			return tile;
		}
	}
}
