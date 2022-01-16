package menu;

import level.apartment.Bedroom;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MainMenu extends FlxState {
	var playButton:FlxButton;
	var titleText:FlxSprite;
	var playKey:Bool = false;

	override public function create() {
		titleText = new FlxText(20, 0, 0, "PaoPao", 40);
		titleText.screenCenter(X);
		add(titleText);

		playButton = new FlxButton(0, 0, "", clickPlay);
		playButton.loadGraphic(Paths.Menu_Play__png);

		add(playButton);
		playButton.screenCenter();
	}

	override public function update(elapsed:Float) {
		playKey = FlxG.keys.anyPressed([ENTER]);
		if (playKey) {
			clickPlay();
		}

		super.update(elapsed);
	}

	function clickPlay() {
		FlxG.switchState(new Bedroom());
		FlxG.camera.fade(FlxColor.WHITE, 1, false);
		
	}
}
