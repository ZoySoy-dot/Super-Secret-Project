package level.apartment;

import openfl.utils.Assets;
import dialogue.DialogueSubstate;
import flixel.FlxG;
import flixel.util.FlxColor;

class Livingroom extends LevelCreation {
	
	override public function create() {
		createLevel("Apartment", "Livingroom");
	
		prevLevel = Bedroom;
		bathroomLevel = Bathroom;
		nextLevel = Hallway;
	}

	override public function update(elapsed:Float) {
		if (FlxG.collide(player, chochi) && FlxG.keys.anyJustPressed([E])) {
			var randomizer = FlxG.random.int(0, 6);
			DialogueSubstate.dialogueFile = Assets.getText('assets/data/Dialogue/NPC/Chochi/$randomizer.txt').split("||");
			DialogueSubstate.person1 = "Chochi";

			openSubState(new DialogueSubstate());
		}
		super.update(elapsed);
		
	}
}
