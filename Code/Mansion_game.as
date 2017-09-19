package Code{
	
	import flash.display.Stage;
	import Code.Controller;
	
	/*
	* The actual game.
	*/
	public class Mansion_game {
		
		public var mainStage:Stage;
		
		public function Mansion_game() {
			
		}
		
		public function init(referenceObject:Object):void{
			
			mainStage = referenceObject.mainStage;
			
			Updater.getInstance().init(referenceObject);
			Controller.init();
		}
		
		/*
		*
		*/
		public function loadLevel(levelName:String):void{
			
		}

	}
	
}
