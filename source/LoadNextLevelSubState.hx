package;

import flixel.FlxG;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

enum LevelChoice
{
	LEAVE;
	STAY;
}

class LoadNextLevelSubState extends FlxSubState
{
	var _nextLevel:Class<LevelState>;
	var box:FlxSprite;
	var choices:Map<LevelChoice, FlxButton>;

	public function new(nextLevel:Class<LevelState>)
	{
		super(0x61000000);
		_nextLevel = nextLevel;
	}

	public function stayInRoom()
	{
		close();
		FlxG.mouse.visible = false;
	}

	public function leaveRoom()
	{
		close();
		FlxG.mouse.visible = false;
		FlxG.switchState(Type.createInstance(_nextLevel, []));
	}

	override function create()
	{
		super.create();

		box = new FlxButton(0, 335).loadGraphic(AssetPaths.LoadLevel_Background__png);
		box.screenCenter(X);
		add(box);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.anyJustPressed([ESCAPE]))
		{
			stayInRoom();
		}
		if (FlxG.keys.anyJustPressed([SPACE]))
		{
			leaveRoom();
		}
		super.update(elapsed);
	}
}
