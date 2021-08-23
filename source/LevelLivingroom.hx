package;

import flixel.util.FlxColor;
import flixel.FlxG;

class LevelLivingroom extends LevelState{
    override public function create() {
        super.create();
        createLevel("Livingroom");
		prevLevel = LevelBedroom;
        nextLevel = LevelBedroom;
        FlxG.camera.fade(FlxColor.BLACK, 1, true);
		FlxG.camera.setScale(500, 500);
		FlxG.camera.follow(player, LOCKON, 1);
    }
}