package;

import openfl.ui.MouseCursor;
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
	var ver = 0.21 + "a";
	

	public function new()
	{
		super();
		addChild(new FlxGame(1280, 720, MenuState, 100, 60, 60, false));
		
		trace("Game ver " + ver);
		DiscordClient.initialize();
		FlxG.autoPause = false;
		
		
		var mouseCursor = new FlxSprite();
		mouseCursor.loadGraphic(AssetPaths.Cursor__png, true, 32, 32);
		FlxG.mouse.load(mouseCursor.pixels, 1);
		
	}
}
