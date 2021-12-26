package levelstuff.levels.apartment;

import flixel.FlxObject;
import flixel.tweens.FlxTween;

class Bedroom extends LevelState {
	override public function create() {
		createLevel("Bedroom");
		nextLevel = Livingroom;
		/*(FlxTween.tween(LevelState.iya, {x: 59.9, y: 61}, 2, {
			onStart: function(flxTween:FlxTween) {
				LevelState.iya.animation.play("rLooped");
				LevelState.iya.facing = FlxObject.RIGHT;
			},
			onComplete: function(flxTween:FlxTween) {
				LevelState.iya.animation.stop();
				LevelState.iya.facing = FlxObject.RIGHT;
			}
		});*/
	}
}
