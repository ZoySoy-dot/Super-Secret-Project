package menu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import menu.MainMenu;

using flixel.util.FlxSpriteUtil;

enum Choice {
	CONTINUE;
	EXIT;
}

class OptionsMenu extends FlxSubState {
	var box:FlxSprite;

	var pointer:FlxSprite;
	var selected:Choice;
	var choices:Map<Choice, FlxText>;

	public function new() {
		super(0x61000000);
	}

	override public function create() {
		super.create();

		box = new FlxSprite().loadGraphic(Paths.Options__png);
		box.screenCenter();
		box.scrollFactor.set(0, 0);
		add(box);

		choices = new Map();
		final textX = box.x + 65;

		choices[CONTINUE] = new FlxText(textX, box.y + 20, "Continue", 10);
		choices[CONTINUE].scrollFactor.set(0, 0);
		add(choices[CONTINUE]);

		choices[EXIT] = new FlxText(textX, choices[CONTINUE].y + choices[CONTINUE].height + 8, "Exit", 10);
		choices[EXIT].scrollFactor.set(0, 0);
		add(choices[EXIT]);

		pointer = new FlxSprite(box.x + 10, choices[CONTINUE].y + (choices[CONTINUE].height / 2) - 8, Paths.Pointer__png);
		pointer.visible = true;
		pointer.scrollFactor.set(0, 0);
		add(pointer);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateKeyboardInput();
	}

	function updateKeyboardInput() {
		var up:Bool = false;
		var down:Bool = false;
		var fire:Bool = false;

		fire = FlxG.keys.anyJustReleased([ENTER, SPACE]);
		down = FlxG.keys.anyJustReleased([DOWN, S]);
		up = FlxG.keys.anyJustReleased([W, UP]);

		if (up || down) {
			selected = if (selected == CONTINUE) EXIT else CONTINUE;
			movePointer();
		} else if (fire) {
			makeChoice();
		}
		if (FlxG.keys.anyJustPressed([ESCAPE])) {
			close();
		}
	}

	function movePointer() {
		pointer.y = choices[selected].y + (choices[selected].height / 2) - 8;
	}

	function makeChoice() {
		pointer.visible = false;
		switch (selected) {
			case CONTINUE:
				close();
			case EXIT:
				FlxG.switchState(new MainMenu());
		}
	}
}
