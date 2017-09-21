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
		*
		* Static functions
		*/
		
		/*
		* Getter function for the Mansion_game instance
		*/
		public static function getInstance():Mansion_game{
			if(theInstance == null){
				theInstance = new Mansion_game();
			}
			return theInstance;
		}
		
		/*
		*
		* Instance methods
		*/
		
		public function init(referenceObject:Object):void{
			
			mainStage = referenceObject.mainStage;
			
			Updater.init(referenceObject);
			Controller.init(referenceObject);
		}
		
		
		/*
		*
		*/
		public function loadLevel(levelName:String):void{
			
			(mainStage.getChildAt(0) as MovieClip).gotoAndStop(levelName);
			Controller.setController("gameplayController");
		}

	}
	
}
