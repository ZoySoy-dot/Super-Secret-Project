package level.apartment;

import menu.OptionsMenu;
import menu.MainMenu;
import character.Iya;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import dialogue.DialogueSubstate;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import lime.utils.Assets;

class Bedroom extends LevelCreation {
	var hasChanged = false;
	
	override public function create() {
		createLevel("Apartment", "Bedroom");
		FlxG.camera.follow(player, LOCKON, 2);
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		FlxG.camera.setScale(400, 400);
		nextLevel = Livingroom;
		
	}

	override public function update(elapsed:Float) {
		/*if (FlxG.collide(player, closet) && hasChanged == false) {
			DialogueSubstate.dialogueFile = Assets.getText(Paths.Apartment__txt).split("||");
			DialogueSubstate.person1 = "Iya";
			DialogueSubstate.person2 = "Phone";
			openSubState(new DialogueSubstate());
			hasChanged = true;
			
		}*/
		if (FlxG.collide(player, chochi) && FlxG.keys.anyJustPressed([E])) {
			var randomizer = FlxG.random.int(0, 6);
			DialogueSubstate.dialogueFile = Assets.getText('assets/data/Dialogue/NPC/Chochi/$randomizer.txt').split("||");
			DialogueSubstate.person1 = "Chochi";

			openSubState(new DialogueSubstate());
		}
		super.update(elapsed);
	}

	
}