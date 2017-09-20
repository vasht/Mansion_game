package Code{
	
	import flash.display.Stage;
	import Code.Controller;
	import flash.display.MovieClip;
	
	/*
	* The actual game.
	*/
	public class Mansion_game {
		
		public var mainStage:Stage;
		
		public function Mansion_game() {
			
		}
		
		public function init(referenceObject:Object):void{
			
			mainStage = referenceObject.mainStage;
			
			Updater.init(referenceObject);
			Controller.init();
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
