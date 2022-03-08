package character.npc;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Car extends FlxSprite {
	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		
		
		
		makeGraphic(50, 30, FlxColor.WHITE);
	}

	override public function update(elapsed:Float) {
		velocity.x = 0;
		velocity.y = 100;
		super.update(elapsed);
	}
}
