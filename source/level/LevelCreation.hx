package level;

import character.Player;
import character.npc.Car;
import character.npc.Chochi;
import dialogue.DialogueSubstate;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import lime.utils.Assets;
import menu.OptionsMenu;

class LevelCreation extends FlxState {
	var nextLevel:Class<LevelCreation>;
	var prevLevel:Class<LevelCreation>;
	var bathroomLevel:Class<LevelCreation>;

	public var chochi:Chochi;
	public var player:Player;
	public var car:Car;

	var map:FlxOgmo3Loader;

	var wall:FlxTilemap;
	var floor:FlxTilemap;
	var next:FlxTilemap;
	var prev:FlxTilemap;
	var furniture:FlxTilemap;
	var building:FlxTilemap;

	var bathroom:FlxTilemap;
	var closet:FlxTilemap;

	public function createLevel(level:String, levelname:String) {
		player = new Player();
		chochi = new Chochi();
		car = new Car();
		FlxG.mouse.visible = false;

		function placeEntities(entity:EntityData) {
			switch entity.name {
				case "iya":
					player.setPosition(entity.x, entity.y);
				case "chochi":
					chochi.setPosition(entity.x, entity.y);
				case "car":
					car.setPosition(entity.x, entity.y);
			}
		}

		var map = new FlxOgmo3Loader('assets/data/Maps/$level/$level.ogmo', 'assets/data/Maps/$level/$levelname.json');
		trace(level, levelname);
		if (level == "Apartment") {
			wall = map.loadTilemap(Paths.ApartmentTilesheet__png, "Wall");
			furniture = map.loadTilemap(Paths.ApartmentTilesheet__png, "Furniture");
			floor = map.loadTilemap(Paths.ApartmentTilesheet__png, "Floor");
			next = map.loadTilemap(Paths.ApartmentTilesheet__png, "Next");
			prev = map.loadTilemap(Paths.ApartmentTilesheet__png, "Prev");

			switch levelname {
				case "Bedroom":
					closet = map.loadTilemap(Paths.ApartmentTilesheet__png, "Closet");

					map.loadEntities(placeEntities, "Entities");
					add(floor);
					add(wall);
					add(furniture);
					add(closet);
					add(next);
					add(chochi);
					add(player);

				case "Livingroom":
					bathroom = map.loadTilemap(Paths.ApartmentTilesheet__png, "Bathroom");

					map.loadEntities(placeEntities, "Entities");
					add(floor);
					add(wall);
					add(furniture);
					add(next);
					add(prev);
					add(chochi);
					add(player);
					add(bathroom);
				case "Bathroom":
					map.loadEntities(placeEntities, "Entities");
					add(floor);
					add(wall);
					add(furniture);
					add(prev);
					add(player);
				case "Hallway":
					map.loadEntities(placeEntities, "Entities");
					add(floor);
					add(wall);
					add(furniture);
					add(prev);
					add(player);
					add(next);
				case "Elevator":
					closet = map.loadTilemap(Paths.ApartmentTilesheet__png, "Closet");

					map.loadEntities(placeEntities, "Entities");
					add(wall);
					add(floor);
					add(player);
				case "GroundFloor":
					map.loadEntities(placeEntities, "Entities");
					add(floor);
					add(wall);
					add(furniture);
					add(next);
					add(player);
			}
		}
		if (level == "Outside") {
			wall = map.loadTilemap(Paths.OutsideTilesheet__png, "Wall");
			building = map.loadTilemap(Paths.OutsideTilesheet__png, "Building");
			floor = map.loadTilemap(Paths.OutsideTilesheet__png, "Floor");
			next = map.loadTilemap(Paths.OutsideTilesheet__png, "Next");
			prev = map.loadTilemap(Paths.OutsideTilesheet__png, "Prev");

			switch levelname {
				case "Outside0":
					map.loadEntities(placeEntities, "Entities");
					add(building);
					add(floor);
					add(wall);
					add(next);
					add(prev);
					add(car);
					add(player);
			}
		}
		FlxG.camera.follow(player, LOCKON, 2);
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		FlxG.camera.setScale(400, 400);
		FlxG.camera.antialiasing = true;
		
	}

	function collision() {
		FlxG.collide(player, wall);
		FlxG.collide(player, furniture);
		FlxG.collide(chochi, wall);
		FlxG.collide(chochi, furniture);

		if (FlxG.collide(player, next)) {
			FlxG.switchState(Type.createInstance(nextLevel, []));
		}
		if (FlxG.collide(player, prev)) {
			FlxG.switchState(Type.createInstance(prevLevel, []));
		}
		if (FlxG.collide(player, bathroom)) {
			FlxG.switchState(Type.createInstance(bathroomLevel, []));
		}
		if (FlxG.collide(prev, car)) {
			car.kill();
		}
	}

	override public function update(elapsed:Float) {
		collision();
		if (FlxG.keys.anyPressed([ESCAPE])) {
			openSubState(new OptionsMenu());
		}
		super.update(elapsed);
	}
}
