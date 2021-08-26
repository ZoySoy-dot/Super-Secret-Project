package;

import Discord.DiscordClient;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.debug.stats.Stats;
import flixel.util.FlxColor;
import openfl.display.Sprite;

class Main extends Sprite
{
	var ver = 0.20 + "a";

	public function new()
	{
		super();
		addChild(new FlxGame(1280, 720, MenuState, 100, 60, 60, false));
		DiscordClient.initialize();
		var sprite = new FlxSprite();
		sprite.loadGraphic(AssetPaths.Cursor__png, true, 32, 32);
		sprite.animation.add("click", [0, 1], 2);

		FlxG.autoPause = false;
		FlxG.mouse.load(sprite.pixels, 1);
		trace("Game ver " + ver);
	}
}
