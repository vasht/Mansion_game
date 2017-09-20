package Code {
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
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
		
		public static function init(referenceObject:Object):void{
			
			gameplayController = GameplayController.getInstance();
			menuController = MenuController.getInstance();
			
			referenceObject.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, readInput);
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
		private static function readInput(e:Event = null):void{
			trace("löl");
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
