package Code {
	
	import Code.GameplayController;
	import Code.MenuController;
	
	/*
	* This class is in charge of taking keyboard input
	* and causing things to happen as a response to it.
	*/
	public class Controller {
		
		public static var gameplayController:GameplayController;
		public static var menuController:MenuController;
		public static var activeController:Controller;

		public function Controller() {
			
		}
		
		public static function init():void{
			gameplayController = GameplayController.getInstance();
			menuController = MenuController.getInstance();
		}
		
		/*
		* 
		*/
		public function update():void{
			readInput();
		}
		
		/*
		*
		*/
		private function readInput():void{
			
		}
		
		/*
		*
		*/
		public static function setController(controllerName:String){
			
			if(controllerName == "gameplayController"){
				activeController = gameplayController;
			} else if(controllerName == "menuController"){
				activeController = menuController;
			} else {
				trace("Invalid controller name in Controller." +
					  "setController: " + controllerName);
			}
		}

	}
	
}
