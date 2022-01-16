package dialogue;

import character.Iya;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import level.LevelCreation;
import lime.utils.Assets;
import openfl.text.TextField;

class DialogueSubstate extends FlxSubState {
	var dialogueBox:FlxSprite;
	var dialogueText:FlxText;
	public static var dialogueFile:Array<String>;
	var i:Int;
	var text:String;

	public static var person1:String;
	public static var person2:String;

	var p1Icon:FlxSprite;
	var p2Icon:FlxSprite;

	public function new() {
		super(0x61000000);
	}



	override public function create() {
		super.create();
		text = dialogueFile[i++];

		dialogueBox = new FlxSprite(515, 380).makeGraphic(250, 50, FlxColor.WHITE);
		dialogueBox.scrollFactor.set(0, 0);
		add(dialogueBox);

		dialogueText = new FlxText(dialogueBox.x + 5, dialogueBox.y + 5, 0, text);
		dialogueText.color = FlxColor.BLACK;
		dialogueText.alignment = FlxTextAlign.RIGHT;
		dialogueText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.WHITE, 0);
		dialogueText.scrollFactor.set(0, 0);

		add(dialogueText);

		p1Icon = new FlxSprite(dialogueBox.x, dialogueBox.y - 50).loadGraphic('assets/images/UI/Icons/$person1.png');
		p2Icon = new FlxSprite(dialogueBox.x, dialogueBox.y - 50).loadGraphic('assets/images/UI/Icons/$person2.png');
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
			text = dialogueFile[i++];
			dialogueText.text = text;
			FlxG.sound.playMusic(Paths.Beep__wav, 0.5, false);
			if (dialogueFile[i] == null) {
				close();
			}
		}
	}
}
