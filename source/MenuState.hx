package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.display.Tilemap;

class MenuState extends FlxState
{
	var playButton:FlxButton;
	var title:FlxText;
	var playKey:Bool = false;

	function clickPlay()
	{
		FlxG.switchState(new LevelTutorial());
		FlxG.camera.fade(FlxColor.WHITE, 1, false);
	}

	override public function create()
	{
		FlxG.cameras.flash(FlxColor.BLACK, 1);
		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(AssetPaths.Menu__ogg, 1, true);
		}

		// background
		var sprite = new FlxSprite();
		sprite.loadGraphic(AssetPaths.Menu_Background_sheet__png, true, 1280, 720);
		sprite.animation.add("idle", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 2, true);
		sprite.animation.play("idle");
		sprite.screenCenter();
		add(sprite);

		playButton = new FlxButton(0, 0, "", clickPlay);
		playButton.loadGraphic(AssetPaths.Menu_Play__png);
		title = new FlxText(0, 0, 300, "", 1000);
		title.setFormat(null, 16, FlxColor.WHITE, CENTER);

		add(title);
		add(playButton);
		playButton.screenCenter();
	}

	override public function update(elapsed:Float)
	{
		playKey = FlxG.keys.anyPressed([ENTER]);
		if (playKey)
		{
			clickPlay();
		}

		super.update(elapsed);
	}
}
