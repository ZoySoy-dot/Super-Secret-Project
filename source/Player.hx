package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	var SPEED:Float = 75;

	function updateMovement()
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		var sprinting:Bool = false;
		var canMove:Bool = false;

		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		sprinting = FlxG.keys.anyPressed([SHIFT]);

		if (sprinting)
			SPEED = 150;
		else
			SPEED = 75;
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up || down || left || right)
		{
			velocity.x = SPEED;
			velocity.y = SPEED;

			var newAngle:Float = 0;

			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;

				facing = FlxObject.UP;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;

				facing = FlxObject.DOWN;
			}
			else if (left)
			{
				newAngle = 180;

				facing = FlxObject.LEFT;
			}
			else if (right)
			{
				newAngle = 0;

				facing = FlxObject.RIGHT;
			}

			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), newAngle);

			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
			{
				switch (facing)
				{
					case FlxObject.LEFT, FlxObject.RIGHT:
						animation.play("lr");
					case FlxObject.UP:
						animation.play("u");
					case FlxObject.DOWN:
						animation.play("d");
				}
			}
		}
	}

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic("assets/images/Player.png", true, 32, 32);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);

		animation.add('d', [0, 1, 2, 3], 4, false);
		animation.add("lr", [4, 5, 6, 7], 4, false);
		animation.add("u", [8, 9, 10, 11], 4, false);

		animation.add("dLooped", [0, 1, 2, 3], 4, true);
		animation.add("lrLooped", [4, 5, 6, 7], 4, true);
		animation.add("uLooped", [8, 9, 10, 11], 4, true);

		drag.x = drag.y = 1600;
		setSize(10, 1);
		offset.set(11, 30);
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}
}
