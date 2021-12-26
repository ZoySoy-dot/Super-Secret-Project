package levelstuff;

import character.Iya;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import levelstuff.dialogue.Dialogue;
import menus.OptionsMenu;

enum Layers {
	NEXTDOOR;
	PREVDOOR;
	DESIGN;
	FURNITURE;
	FLOOR;
	WALL;
}

class LevelState extends FlxState {
	public static var iya:Iya;

	var map:FlxOgmo3Loader;
	var layers:Map<Layers, FlxTilemap>;
	var nextLevel:Class<LevelState>;
	var prevLevel:Class<LevelState>;

	public static var iyaPosX:Int;
	public static var iyaPosY:Int;
	public static var doneDialogue:Bool;

	public static var curLevel:String;

	override public function update(elapsed:Float) {
		collision();
		door();
		openOptions();
		openDialogueSubstate();

		super.update(elapsed);
	}

	public function createLevel(levelName:String) {
		layers = new Map();
		iya = new Iya();

		switch (levelName) {
			case "StartBedroom":
				map = new FlxOgmo3Loader(Paths.Project__ogmo, 'assets/data/Maps/Apartment/$levelName.json');

				layers[WALL] = map.loadTilemap(Paths.HouseTilesheet__png, "Wall");
				layers[FLOOR] = map.loadTilemap(Paths.HouseTilesheet__png, "Floor");
				layers[FURNITURE] = map.loadTilemap(Paths.HouseTilesheet__png, "Furniture");
				layers[DESIGN] = map.loadTilemap(Paths.HouseTilesheet__png, "Design");
				layers[NEXTDOOR] = map.loadTilemap(Paths.HouseTilesheet__png, "nextDoor");
				layers[PREVDOOR] = map.loadTilemap(Paths.HouseTilesheet__png, "prevDoor");

				map.loadEntities(placeEntities, "entities");
				add(layers[WALL]);
				add(layers[FLOOR]);
				add(layers[FURNITURE]);
				add(layers[DESIGN]);
				add(layers[NEXTDOOR]);
				add(layers[PREVDOOR]);
				add(iya);

				trace(levelName + " is loaded");
				curLevel = '$levelName';

			case "Bedroom":
			
				map = new FlxOgmo3Loader(Paths.Project__ogmo, 'assets/data/Maps/Apartment/$levelName.json');

				layers[WALL] = map.loadTilemap(Paths.HouseTilesheet__png, "Wall");
				layers[FLOOR] = map.loadTilemap(Paths.HouseTilesheet__png, "Floor");
				layers[FURNITURE] = map.loadTilemap(Paths.HouseTilesheet__png, "Furniture");
				layers[DESIGN] = map.loadTilemap(Paths.HouseTilesheet__png, "Design");
				layers[NEXTDOOR] = map.loadTilemap(Paths.HouseTilesheet__png, "nextDoor");
				layers[PREVDOOR] = map.loadTilemap(Paths.HouseTilesheet__png, "prevDoor");

				map.loadEntities(placeEntities, "entities");
				add(layers[WALL]);
				add(layers[FLOOR]);
				add(layers[FURNITURE]);
				add(layers[DESIGN]);
				add(layers[NEXTDOOR]);
				add(layers[PREVDOOR]);
				add(iya);

				trace(levelName + " is loaded");
				curLevel = '$levelName';

			case "Livingroom":
				map = new FlxOgmo3Loader(Paths.Project__ogmo, 'assets/data/Maps/Apartment/$levelName.json');

				layers[WALL] = map.loadTilemap(Paths.HouseTilesheet__png, "Wall");
				layers[FLOOR] = map.loadTilemap(Paths.HouseTilesheet__png, "Floor");
				layers[FURNITURE] = map.loadTilemap(Paths.HouseTilesheet__png, "Furniture");
				layers[DESIGN] = map.loadTilemap(Paths.HouseTilesheet__png, "Design");
				layers[NEXTDOOR] = map.loadTilemap(Paths.HouseTilesheet__png, "nextDoor");
				layers[PREVDOOR] = map.loadTilemap(Paths.HouseTilesheet__png, "prevDoor");

				map.loadEntities(placeEntities, "entities");
				add(layers[WALL]);
				add(layers[FLOOR]);
				add(layers[FURNITURE]);
				add(layers[DESIGN]);
				add(layers[NEXTDOOR]);
				add(layers[PREVDOOR]);
				add(iya);

				trace(levelName + " is loaded");
				curLevel = '$levelName';
		}
		FlxG.camera.setScale(400, 400);
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		FlxG.camera.follow(iya, LOCKON, 1);
		FlxG.mouse.visible = false;
	}

	function placeEntities(entity:EntityData) {
		if (entity.name == "player") {
			iya.setPosition(entity.x, entity.y);
		}
	}

	function door() {
		if (FlxG.collide(iya, layers[NEXTDOOR])) {
			FlxG.switchState(Type.createInstance(nextLevel, []));
		} else if (FlxG.collide(iya, layers[PREVDOOR])) {
			FlxG.switchState(Type.createInstance(prevLevel, []));
		}
	}

	function openOptions() {
		if (FlxG.keys.anyJustPressed([ESCAPE])) {
			FlxG.mouse.visible = true;
			final optionsState = new OptionsSubState();
			openSubState(optionsState);
		}
	}

	function collision() {
		FlxG.collide(iya, layers[WALL]);
		FlxG.collide(iya, layers[FURNITURE]);
	}

	function openDialogueSubstate() {
		iyaPosX = Std.int(iya.x);
		iyaPosY = Std.int(iya.y);
		final dialogueState = new Dialogue();

		switch curLevel {
			case "Bedroom":
				if (iya.x == 9 && iyaPosY == 19) {
					openSubState(dialogueState);
				}
		}
	}
}
