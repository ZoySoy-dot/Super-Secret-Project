package level.apartment;

import level.outside.Outside0;

class GroundFloor extends LevelCreation {
	override public function create() {
        createLevel("Apartment", "GroundFloor");
        nextLevel = Outside0;
    }
}
