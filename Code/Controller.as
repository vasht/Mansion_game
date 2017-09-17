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
			gameplayController = new GameplayController();
			menuController = new MenuController();
		}
		
		/*
		* 
		*/
		public function update():void{
			trace("löl");
		}

	}
	
}
