import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
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

	public function createLevel(levelName:String)
	{
		if (levelName == "Bedroom")
		{
			map = new FlxOgmo3Loader(AssetPaths.Map__ogmo, 'assets/data/Maps/Apartment/$levelName.json');
			layers = new Map();

			layers[WALL] = map.loadTilemap(AssetPaths.Apartment_Bedroom_tileset__png, "Wall");
			layers[FLOOR] = map.loadTilemap(AssetPaths.Apartment_Bedroom_tileset__png, "Floor");
			layers[FURNITURE] = map.loadTilemap(AssetPaths.Apartment_Bedroom_tileset__png, "Furniture");
			layers[DETAIL] = map.loadTilemap(AssetPaths.Apartment_Bedroom_tileset__png, "Detail");
			layers[NEXTLEVEL] = map.loadTilemap(AssetPaths.Apartment_Bedroom_tileset__png, "NextLevel");

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
		else if (levelName == "Tutorial")
		{
			map = new FlxOgmo3Loader(AssetPaths.Map__ogmo, 'assets/data/Maps/$levelName.json');
			layers = new Map();
			layers[WALL] = map.loadTilemap(AssetPaths.Tutorial_tileset__png, "Wall");
			layers[FLOOR] = map.loadTilemap(AssetPaths.Tutorial_tileset__png, "Floor");
			layers[FURNITURE] = map.loadTilemap(AssetPaths.Tutorial_tileset__png, "Furniture");
			layers[DETAIL] = map.loadTilemap(AssetPaths.Tutorial_tileset__png, "Detail");
			layers[NEXTLEVEL] = map.loadTilemap(AssetPaths.Tutorial_tileset__png, "NextLevel");

			add(layers[NEXTLEVEL]);
			add(layers[FLOOR]);
			add(layers[WALL]);
			add(layers[FURNITURE]);
			add(layers[DETAIL]);

			player = new Player(187, 111);
			add(player);

			trace(levelName + " is loaded");
		}
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(player, layers[WALL]);
		FlxG.collide(player, layers[FURNITURE]);
		Reg.optionsKey = FlxG.keys.anyJustPressed([ESCAPE]);
		if (Reg.optionsKey)
		{
			FlxG.mouse.visible = true;
			var optionsState = new OptionsSubState();
			openSubState(optionsState);
		}

		// Load next State
		Reg.useKey = FlxG.keys.anyJustPressed([E]);
		if ((FlxG.collide(player, layers[NEXTLEVEL])) && (Reg.useKey))
		{
			trace("Going to the Apartment");
			final loadNextLevelsubstate = new LoadNextLevelSubState(nextLevel = LevelBedroom);
			openSubState(loadNextLevelsubstate);
		}
		super.update(elapsed);
	}
}
