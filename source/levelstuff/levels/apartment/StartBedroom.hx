package levelstuff.levels.apartment;

class StartBedroom extends LevelState{
        override public function create() {
            createLevel("StartBedroom");
            nextLevel = Livingroom;
        }
    
}