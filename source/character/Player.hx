package character;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import haxe.Timer;

class Player extends FlxSprite {
	var idleTimer = new haxe.Timer(6000);
	var idleTimerDone = false;

	function updateMovement() {
		var SPEED:Float = 40;
		var newAngle:Float = 0;
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		up = FlxG.keys.anyPressed([W, UP]);
		down = FlxG.keys.anyPressed([S, DOWN]);
		left = FlxG.keys.anyPressed([A, LEFT]);
		right = FlxG.keys.anyPressed([D, RIGHT]);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up || down || left || right) {
			velocity.x = SPEED;
			velocity.y = SPEED;
			if (up) {
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = FlxObject.UP;
			} else if (down) {
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = FlxObject.DOWN;
			} else if (left) {
				newAngle = 180;
				facing = FlxObject.LEFT;
			} else if (right) {
				newAngle = 0;
				facing = FlxObject.RIGHT;
			}

			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), newAngle);

			if ((velocity.x != 0 || velocity.y != 0)) {
				switch (facing) {
					case LEFT, RIGHT:
						animation.play("lr");
					case UP:
						animation.play("u");
					case DOWN:
						animation.play("d");

					case _:
				}
			}
		}
	}

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);

		loadGraphic(Paths.Player__png, true, 17, 23);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);

		animation.add('d', [1, 2, 3, 4, 5, 6], 7, false);
		animation.add("u", [9, 10, 11, 12, 13, 14], 7, false);
		animation.add("lr", [16, 17, 18, 19, 20, 21], 7, false);
		animation.add("idle", [22, 23, 24, 25], 4, true);

		animation.add("dLooped", [1, 2, 3, 4, 5, 6,], 3, true);
		animation.add("lLooped", [15, 16, 17, 18, 19, 20], 3, true);
		animation.add("rLooped", [15, 16, 17, 18, 19, 20], 3, true);
		animation.add("uLooped", [8, 9, 10, 11, 12, 13], 3, true);

		drag.x = drag.y = 1600;
		setSize(13, 6);
		offset.set(2, 19);
	}

	override function update(elapsed:Float) {
		updateMovement();
		if (!FlxG.keys.anyJustPressed([W, A, S, D])) {
			trace(idleTimer);
			idleTimer.run = function name() {
				animation.play("idle");
				idleTimer.stop;
			}
		}
		super.update(elapsed);
	}
}
