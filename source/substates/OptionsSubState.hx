package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.ui.FlxButton;

using flixel.util.FlxSpriteUtil;

class OptionsSubState extends FlxSubState
{
	var box:FlxSprite;
	var continueBtn:FlxButton;
	var exitBtn:FlxButton;

	public function new()
	{
		super(0x61000000);
	}

	function closeOptions()
	{
		close();
		trace("working");
	}

	function exitGame()
	{
		FlxG.switchState(new MenuState());
	}

	override public function create()
	{
		super.create();
		box = new FlxSprite().loadGraphic(AssetPaths.Options__png);
		box.screenCenter();
		box.scrollFactor.set(0, 0);
		add(box);

		continueBtn = new FlxButton(closeOptions);
		continueBtn.y = FlxG.height - continueBtn.height - 10;
		continueBtn.screenCenter(X);
		add(continueBtn);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		Reg.optionsKey = FlxG.keys.anyJustPressed([ESCAPE]);
		if (Reg.optionsKey)
		{
			close();
		}
	}
}
