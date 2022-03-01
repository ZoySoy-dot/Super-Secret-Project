package level.apartment;

import flixel.util.FlxColor;
import flixel.FlxG;

class Bathroom extends LevelCreation{
    override public function create(){
		createLevel("Apartment", "Bathroom");
	
        prevLevel = Livingroom;
        
    }}