package level.apartment;

import character.Iya;
import dialogue.DialogueSubstate;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import lime.utils.Assets;

class Livingroom extends LevelCreation {
	
	override public function create() {
		createLevel("Apartment", "Livingroom");
		FlxG.camera.follow(player, LOCKON, 2);
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		FlxG.camera.setScale(400, 400);
		
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
