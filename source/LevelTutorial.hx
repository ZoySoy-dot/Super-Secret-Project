package;


import LevelState.Layers;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.graphics.frames.FlxFrame;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import haxe.rtti.CType.Rights;


class LevelTutorial extends LevelState
{
	
	override public function create()
	{
		nextLevel = LevelBedroom;
		createLevel("Tutorial");
		FlxG.mouse.visible = false;

		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		FlxG.camera.setScale(500, 500);
		FlxG.camera.follow(player, LOCKON, 1);
	}

	override public function update(elapsed:Float)
	{
		// Options


		super.update(elapsed);
	}
}
