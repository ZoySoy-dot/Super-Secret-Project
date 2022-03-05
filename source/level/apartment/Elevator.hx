package level.apartment;

import flixel.FlxG;

class Elevator extends LevelCreation {
	var timer = new haxe.Timer(10000);
	var timerDone:Bool = false;

	override public function create() {
		createLevel("Apartment", "Elevator");
		nextLevel = GroundFloor;
		FlxG.sound.playMusic("assets/music/ElevatorMusic.mp3", 0.1);
	}

	override public function update(elapsed:Float) {
		timer.run = function() {
			FlxG.sound.play("assets/sounds/ElevatorBell.mp3", 0.5);
			add(closet);
			FlxG.sound.music.fadeOut(1,0);
			timerDone = true;
			timer.stop();
			
		}
		if (timerDone) {
			if (FlxG.collide(player, closet)) {
				FlxG.switchState(Type.createInstance(nextLevel, []));
				FlxG.sound.pause();
			}
		}
		
		super.update(elapsed);
	}
}
