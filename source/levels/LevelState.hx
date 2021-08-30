package levels;

import substates.OptionsSubState;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;

enum Layers
{
	DETAIL;
	FURNITURE;
	WALL;
	FLOOR;
	NEXTLEVEL;
	PREVLEVEL;
}

class LevelState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var layers:Map<Layers, FlxTilemap>;
	var nextLevel:Class<LevelState>;
	var prevLevel:Class<LevelState>;
	var dialogue:FlxText;
	public function createLevel(levelName:String)
	{
		// AssetPaths
		var mapOgmo:String = AssetPaths.Map__ogmo;

		var tutorialTileset:String = AssetPaths.Tutorial_tileset__png;
		if (levelName == "Tutorial")
		{
			map = new FlxOgmo3Loader(mapOgmo, 'assets/data/Maps/$levelName.json');
			layers = new Map();
			layers[WALL] = map.loadTilemap(tutorialTileset, "Wall");
			layers[FLOOR] = map.loadTilemap(tutorialTileset, "Floor");
			layers[FURNITURE] = map.loadTilemap(tutorialTileset, "Furniture");
			layers[DETAIL] = map.loadTilemap(tutorialTileset, "Detail");
			layers[NEXTLEVEL] = map.loadTilemap(tutorialTileset, "NextLevel");
			layers[PREVLEVEL] = map.loadTilemap(tutorialTileset, "PrevLevel");
			

			add(layers[NEXTLEVEL]);
			add(layers[FLOOR]);
			add(layers[WALL]);
			add(layers[FURNITURE]);
			add(layers[DETAIL]);
			

			player = new Player(247, 82);
			add(player);

			trace(levelName + " is loaded");
		}
		var bedroomTileset:String = AssetPaths.Apartment_Bedroom_tileset__png;
		var bedroomFurnitureTileset:String = AssetPaths.Bedroom_Furniture__png;
		if (levelName == "Bedroom")
		{
			map = new FlxOgmo3Loader(mapOgmo, 'assets/data/Maps/Apartment/$levelName.json');
			layers = new Map();

			layers[WALL] = map.loadTilemap(bedroomTileset, "Wall");
			layers[FLOOR] = map.loadTilemap(bedroomTileset, "Floor");
			layers[FURNITURE] = map.loadTilemap(bedroomFurnitureTileset, "Furniture");
			layers[DETAIL] = map.loadTilemap(bedroomTileset, "Detail");
			layers[NEXTLEVEL] = map.loadTilemap(bedroomTileset, "NextLevel");
			layers[PREVLEVEL] = map.loadTilemap(bedroomTileset, "PrevLevel");

			add(layers[NEXTLEVEL]);
			add(layers[FLOOR]);
			add(layers[WALL]);
			add(layers[FURNITURE]);
			add(layers[DETAIL]);

			player = new Player(212, 140);
			add(player);

			trace(levelName + " is loaded");

			FlxG.sound.playMusic(AssetPaths.Apartment__wav, 0.5, true);
		}
		var livingroomTileset:String = AssetPaths.Apartment_Livingroom_tileset__png;
		if (levelName == "Livingroom")
		{
			map = new FlxOgmo3Loader(mapOgmo, 'assets/data/Maps/Apartment/$levelName.json');
			layers = new Map();

			layers[WALL] = map.loadTilemap(livingroomTileset, "Wall");
			layers[FLOOR] = map.loadTilemap(livingroomTileset, "Floor");
			layers[FURNITURE] = map.loadTilemap(livingroomTileset, "Furniture");
			layers[DETAIL] = map.loadTilemap(livingroomTileset, "Detail");
			layers[NEXTLEVEL] = map.loadTilemap(livingroomTileset, "NextLevel");
			layers[PREVLEVEL] = map.loadTilemap(livingroomTileset, "PrevLevel");

			add(layers[NEXTLEVEL]);
			add(layers[FLOOR]);
			add(layers[WALL]);
			add(layers[FURNITURE]);
			add(layers[DETAIL]);

			player = new Player(269, 114);
			add(player);

			trace(levelName + " is loaded");

			FlxG.sound.playMusic(AssetPaths.Apartment__wav, 0.5, true);
		}
	}

	override public function update(elapsed:Float)
	{
		
		collision();
		loadLevel();
		openOptions();
		

		
		
		super.update(elapsed);
	}


	function loadLevel()
	{
		if (FlxG.collide(player, layers[NEXTLEVEL]))
		{
			FlxG.switchState(Type.createInstance(nextLevel, []));
		}
		else if (FlxG.collide(player, layers[PREVLEVEL]))
		{
			FlxG.switchState(Type.createInstance(prevLevel, []));
		}
	}
	function openOptions() {
		Reg.optionsKey = FlxG.keys.anyJustPressed([ESCAPE]);
		if (Reg.optionsKey)
		{
			FlxG.mouse.visible = true;
			var optionsState = new OptionsSubState();
			openSubState(optionsState);
		}
	}
	function collision() {
		FlxG.collide(player, layers[WALL]);
		FlxG.collide(player, layers[FURNITURE]);
	}
}
