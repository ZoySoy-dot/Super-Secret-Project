package level.outside;

import flixel.FlxG;

class Outside0 extends LevelCreation {
	override public function create() {
		createLevel("Outside", "Outside0");
		player.setPosition(176, 208);
		car.setPosition(208, 5);
	}

	override public function update(elapsed:Float) {
		FlxG.collide(player, building);

		if (FlxG.collide(player, car)) {
			player.x -= (car.width - 20);
		}

		if (!car.alive) {
			car.revive();
			car.setPosition(208, 10);
		}
		

		super.update(elapsed);
	}
}
