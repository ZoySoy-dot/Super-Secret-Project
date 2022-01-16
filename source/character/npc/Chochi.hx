package character.npc;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;

class Chochi extends FlxSprite {
	static inline var speed:Float = 40;

	var brain:FSM;
	var idleTimer:Float;
	var moveDirection:Float;

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		loadGraphic(Paths.ChochiSpritesheet__png, true, 35, 22);
		setFacingFlip(LEFT, true, false);
		setFacingFlip(RIGHT, false, false);
		animation.add("lr", [0, 1, 2, 3], 3);
		animation.add("idle", [1],1,false);
		brain = new FSM(idle);
		idleTimer = 0;
		setSize(20, 15);
		offset.set(7, 5);
	}

	override public function update(elapsed:Float) {
		if(FlxG.random.bool(0.1)) {
			FlxG.sound.play(Paths.Bark__wav,0.1,false);
		}
		if ((velocity.x != 0 || velocity.y != 0) ) {
			if (Math.abs(velocity.x) > Math.abs(velocity.y)) {
				if (velocity.x < 0)
					facing = LEFT;
				else
					facing = RIGHT;
			} else {
				if (velocity.y < 0)
					facing = UP;
				else
					facing = DOWN;
			}

			switch (facing) {
				case LEFT, RIGHT:
					animation.play("lr");
				case UP,DOWN:
					animation.play("lr");
					
				case _:
			}
		}else{animation.play("idle");}
		brain.update(elapsed);
		super.update(elapsed);
	}

	function idle(elapsed:Float) {
		if (idleTimer <= 0) {
			if (FlxG.random.bool(20)) {
				moveDirection = 1;
				velocity.y = velocity.x = 0;
			} else {
				moveDirection = FlxG.random.int(0, 8) * 45;

				velocity.set(speed, 0);
				velocity.rotate(FlxPoint.weak(), moveDirection);
			}
			idleTimer = FlxG.random.int(1, 4);
		} else
			idleTimer -= elapsed;
	}
}
