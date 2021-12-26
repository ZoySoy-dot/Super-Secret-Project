package levelstuff.levels.apartment;

import flixel.FlxObject;
import flixel.tweens.FlxTween;

class Livingroom extends LevelState {
	override public function create() {
		createLevel("Livingroom");
		nextLevel = Livingroom;
		prevLevel = Bedroom;
		
	}
}
