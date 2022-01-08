package levels.apartment;

import lime.utils.Assets;
import dialogue.DialogueBox;
import flixel.util.FlxColor;
import flixel.FlxG;

class Bedroom extends LevelCreation {
    override public function create() {
        createLevel("Apartment", "Bedroom");
		FlxG.camera.follow(player, LOCKON, 2);
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		FlxG.camera.setScale(400, 400);
    }
    override public function update(elapsed:Float) {
		if (FlxG.collide(player, interactableFurniture)) {
			final dialogueState = new DialogueBox();
			DialogueBox.dialogueFile = Assets.getText(Paths.Apartment__txt).split("||");
			DialogueBox.person1 = "Iya";
			DialogueBox.person2 = "phone";
			openSubState(dialogueState);
		}
		super.update(elapsed);
    }
}
