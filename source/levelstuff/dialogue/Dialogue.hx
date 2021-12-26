package levelstuff.dialogue;

import character.Iya;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import levelstuff.LevelState;
import lime.utils.Assets;
import openfl.text.TextField;

class Dialogue extends FlxSubState {
	var box:FlxSprite;
	var box_text:FlxText;
	var dialog_file:Array<String>;
	var i:Int;
	var text:String;

	var doneDialogue:Bool = false;

	var person1:String;
	var person2:String;

	var p1Icon:FlxSprite;
	var p2Icon:FlxSprite;

	public function new() {
		super(0x61000000);
	}

	public function loadDialogue() {
		switch LevelState.curLevel {
			case "Bedroom":
				if (LevelState.iya.x == 9 && LevelState.iyaPosY == 19) {
					person1 = "Iya";
					person2 = "Phone";
					dialog_file = Assets.getText(Paths.Bedroom__txt).split("||");
				}
		}
	}

	override public function create() {
		super.create();
		loadDialogue();
		text = dialog_file[i++];

		box = new FlxSprite(515, 380).makeGraphic(250, 50, FlxColor.WHITE);
		box.scrollFactor.set(0, 0);
		add(box);

		box_text = new FlxText(box.x + 5, box.y + 5, 0, text);
		box_text.color = FlxColor.BLACK;
		box_text.alignment = FlxTextAlign.RIGHT;
		box_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 0);
		box_text.scrollFactor.set(0, 0);

		add(box_text);

		p1Icon = new FlxSprite(box.x, box.y - 50).loadGraphic('assets/images/UI/Icons/$person1.png');
		p2Icon = new FlxSprite(box.x, box.y - 50).loadGraphic('assets/images/UI/Icons/$person2.png');
		p1Icon.scrollFactor.set(0, 0);
		p2Icon.scrollFactor.set(0, 0);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		nextLine();
	}

	function nextLine() {
		if (text.indexOf(person2) != -1) {
			remove(p1Icon);
			add(p2Icon);
		} else if (text.indexOf(person1) != -1) {
			add(p1Icon);
			remove(p2Icon);
		}
		if (FlxG.keys.anyJustPressed([ENTER])) {
			text = dialog_file[i++];
			box_text.text = text;
			FlxG.sound.playMusic(Paths.Beep__wav, 0.5, false);
			if (text == "") {
				close();
				LevelState.iya.setPosition(LevelState.iya.x + 1, LevelState.iyaPosY + 1);
			}
		}
	}
}
