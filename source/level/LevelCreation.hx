package level;

import menu.OptionsMenu;
import character.npc.Chochi;
import character.Iya;
import dialogue.DialogueSubstate;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import lime.utils.Assets;

class LevelCreation extends FlxState {
	var nextLevel:Class<LevelCreation>;
	var prevLevel:Class<LevelCreation>;
	var chochi:Chochi;
	var player:Iya;
	var map:FlxOgmo3Loader;
	var wall:FlxTilemap;
	var closet:FlxTilemap;
	var next:FlxTilemap;
	var prev:FlxTilemap;
	var furniture:FlxTilemap;
	

	public function createLevel(level:String, levelname:String) {
		player = new Iya();
		chochi = new Chochi();
		FlxG.mouse.visible = false;

		function placeEntities(entity:EntityData) {
			switch entity.name {
				case "iya":
					player.setPosition(entity.x, entity.y);
				case "chochi":
					chochi.setPosition(entity.x, entity.y);
			}
		}

		var map = new FlxOgmo3Loader('assets/data/Maps/$level/$level.ogmo', 'assets/data/Maps/$level/$levelname.json');

		if (level == "Apartment") {
			switch levelname {
				case "Bedroom":
					wall = map.loadTilemap(Paths.HouseTilesheet__png, "Wall");
					furniture = map.loadTilemap(Paths.HouseTilesheet__png, "Furniture");
					var floor = map.loadTilemap(Paths.HouseTilesheet__png, "Floor");
					next = map.loadTilemap(Paths.HouseTilesheet__png, "Next");
					closet = map.loadTilemap(Paths.HouseTilesheet__png, "Closet");

					map.loadEntities(placeEntities, "Entities");
					add(floor);
					add(wall);
					add(furniture);
					add(closet);
					add(next);
					add(chochi);
					add(player);
					
				case "Livingroom":
					wall = map.loadTilemap(Paths.HouseTilesheet__png, "Wall");
					var furniture = map.loadTilemap(Paths.HouseTilesheet__png, "Furniture");
					var floor = map.loadTilemap(Paths.HouseTilesheet__png, "Floor");
					next = map.loadTilemap(Paths.HouseTilesheet__png, "Next");
					closet = map.loadTilemap(Paths.HouseTilesheet__png, "Closet");

					map.loadEntities(placeEntities, "Entities");

					add(wall);
					add(furniture);
					add(floor);
					add(player);
					add(next);
			}
		}
	}

	function loadLevel() {
		if (FlxG.collide(player, next)) {
			FlxG.switchState(Type.createInstance(nextLevel, []));
		}
	}

	/*
		if (FlxG.collide(player, ))
		else if (FlxG.collide(player, layers[PREVLEVEL])) {
			FlxG.switchState(Type.createInstance(prevLevel, []));
	}*/
	override public function update(elapsed:Float) {
		super.update(elapsed);
		FlxG.collide(player, wall);
		FlxG.collide(player, furniture);
		FlxG.collide(chochi,wall);
		FlxG.collide(chochi,furniture);
		loadLevel();
		if(FlxG.keys.anyPressed([ESCAPE])) {
			openSubState(new OptionsMenu());
		}
	}
}
