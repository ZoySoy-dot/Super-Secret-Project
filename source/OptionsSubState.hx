package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.ui.FlxButton;

using flixel.util.FlxSpriteUtil;

enum Choice
{
	CONTINUE;
	EXIT;
}

class OptionsSubState extends FlxSubState
{
	var box:FlxSprite;
	var choices:Map<Choice, FlxButton>;

	public function new()
	{
		super(0x61000000);
	}

	public function closeOptions()
	{
		Reg.optionsKey = FlxG.keys.anyJustPressed([ESCAPE]);
		if (Reg.optionsKey)
		{
			close();
			trace("Options menu is closed: " + Reg.optionsKey);
		}
	}

	public function exitGame()
	{
		FlxG.switchState(new MenuState());
	}

	override public function create()
	{
		super.create();

		box = new FlxButton().loadGraphic(AssetPaths.Options__png);
		box.screenCenter();
		add(box);

		choices = new Map();
		choices[CONTINUE] = new FlxButton(0, box.y + 30, closeOptions);
		choices[CONTINUE].loadGraphic(AssetPaths.Options_Continue__png);
		choices[CONTINUE].screenCenter(X);

		choices[EXIT] = new FlxButton(0, box.y + 60, exitGame);
		choices[EXIT].loadGraphic(AssetPaths.Options_Exit__png);
		choices[EXIT].screenCenter(X);

		add(choices[CONTINUE]);
		add(choices[EXIT]);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		closeOptions();
	}
}
