package levels;

import character.Iya;
import dialogue.DialogueBox;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import lime.utils.Assets;

class LevelCreation extends FlxState {
	var player:Iya;
	var map:FlxOgmo3Loader;
	var wall:FlxTilemap;
	var interactableFurniture:FlxTilemap;

	public function createLevel(level:String, levelname:String) {
		player = new Iya();

		FlxG.mouse.visible = false;

		function placeEntities(entity:EntityData) {
			switch entity.name {
				case "iya":
					player.setPosition(entity.x, entity.y);
			}
		}

		var map = new FlxOgmo3Loader('assets/data/Maps/$level/$level.ogmo', 'assets/data/Maps/$level/$levelname.json');

		if (level == "Apartment") {
			switch levelname {
				case "Bedroom":
					wall = map.loadTilemap(Paths.HouseTilesheet__png, "Wall");
					var furniture = map.loadTilemap(Paths.HouseTilesheet__png, "Furniture");
					var floor = map.loadTilemap(Paths.HouseTilesheet__png, "Floor");
					interactableFurniture = map.loadTilemap(Paths.HouseTilesheet__png, "InteractableFurniture");
					map.loadEntities(placeEntities, "Entities");

					add(wall);
					add(furniture);
					add(floor);
					add(interactableFurniture);
					add(player);
			}
		}
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		FlxG.collide(player, wall);
		if (FlxG.keys.anyJustPressed([ENTER])) {
			FlxG.sound.playMusic(Paths.Beep__wav, 0.5, false);
		}
	}
}
