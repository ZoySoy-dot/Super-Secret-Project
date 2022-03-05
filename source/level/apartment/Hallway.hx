package level.apartment;

import flixel.FlxG;
import flixel.util.FlxColor;

class Hallway extends LevelCreation {
	override public function create() {
		createLevel("Apartment", "Hallway");

		prevLevel = Livingroom;
		nextLevel = Elevator;
	}

}
