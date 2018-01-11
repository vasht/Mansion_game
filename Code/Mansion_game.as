package Code{
	
	import flash.display.Stage;
	import flash.display.MovieClip;
	
	import Code.Controller;
	import Code.MainCharacter;
	
	
	/*
	* The actual game.
	*
	* This class uses the Singleton programming pattern.
	*/
	public class Mansion_game {
		
		// Static variables
		private static var theInstance:Mansion_game;
		
		public static var mainStage:Stage;
		
		// Instance properties
		public var mainCharacter:MainCharacter;
		
		
		/*
		* Constructor
		*/
		public function Mansion_game() {
			
		}

		
		/*
		* Getter function for the Mansion_game instance
		*/
		public static function getInstance():Mansion_game{
			if(theInstance == null){
				theInstance = new Mansion_game();
			}
			return theInstance;
		} // End of getInstance
		
		
		/*
		* Takes an object with references to stuff and
		* takes a reference to the stage from it.
		* Then calls the init functions of other classes
		* and hands them the referenceObject.
		*/
		public function init(referenceObject:Object):void{
			
			mainStage = referenceObject.mainStage;
			
			Updater.init(referenceObject);
			Controller.init(referenceObject);
		} // End of init
		
		
		/*
		* Takes the name of a level as a string. 
		* Goes to the frame with a label that equals the given
		* level name.
		*
		* Also sets the controller to a gameplay controller.
		*/
		public function loadLevel(levelName:String):void{
			
			(mainStage.getChildAt(0) as MovieClip).gotoAndStop(levelName);
			Controller.setController("gameplayController");
		}

	}
	
}
