package level.apartment;

import character.Player;
import dialogue.DialogueSubstate;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.utils.Assets;
import menu.MainMenu;
import menu.OptionsMenu;

class Bedroom extends LevelCreation {
	var hasChanged = false;

	override public function create() {
		createLevel("Apartment", "Bedroom");
		nextLevel = Livingroom;
	}

	override public function update(elapsed:Float) {
		/*if (FlxG.collide(player, closet) && hasChanged == false) {
			DialogueSubstate.dialogueFile = Assets.getText(Paths.Apartment__txt).split("||");
			DialogueSubstate.person1 = "Player";
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
