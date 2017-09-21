package Code {
	
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import Code.GameplayController;
	import Code.MenuController;
	
	
	/*
	* This class is in charge of taking keyboard input
	* and causing things to happen as a response to it.
	*/
	public class Controller {
		
		// Static variables
		public static var activeController:Controller;
		
		protected static var W_pressed:Boolean;
		protected static var A_pressed:Boolean;
		protected static var S_pressed:Boolean;
		protected static var D_pressed:Boolean;
		
		protected static var J_pressed:Boolean;
		protected static var K_pressed:Boolean;
		protected static var I_pressed:Boolean;
		
		protected static var ENTER_pressed:Boolean;
		
		
		/*
		* The constructor
		*/
		public function Controller() {
			
		}
		
		
		public static function init(referenceObject:Object):void{
			
			referenceObject.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, readKeyPressed);
			referenceObject.mainStage.addEventListener(KeyboardEvent.KEY_UP, readKeyReleased);
			
		}
		
		
		/*
		* Calls the function to react to input based
		* on the values of the boolean variables.
		* This way the processInput function can
		* respond to combo key presses for example.
		*/
		public function update():void{
			processInput();
		}
		
		/*
		* Responds to input based on the boolean variables.
		* The Controller class's method is empty, because
		* this is supposed to be overridden by the GameplayController
		* and MenuController classes.
		*/
		protected function processInput(){
			// Do nothing.
		}
		
		/*
		* Sets the boolean variables to true for those
		* keys that are pressed.
		*/
		private static function readKeyPressed(e:KeyboardEvent):void{
			
			switch(e.keyCode){
				case Keyboard.W:{
					
					W_pressed = true;
				}
				case Keyboard.A:{
					
					A_pressed = true;
				}
				case Keyboard.S:{
					
					S_pressed = true;
				}
				case Keyboard.D:{
					
					D_pressed = true;
				}
				case Keyboard.J:{
					
					J_pressed = true;
				}
				case Keyboard.K:{
					
					K_pressed = true;
				}
				case Keyboard.I:{
					
					I_pressed = true;
				}
				case Keyboard.ENTER:{
					
					ENTER_pressed = true;
				}
				default:{
					
				}
			}
		}
		
		/*
		* Sets the boolean variables to false for those keys
		* that are released.
		*/
		private static function readKeyReleased(e:KeyboardEvent):void{
			
			switch(e.keyCode){
				case Keyboard.W:{
					
					W_pressed = false;
				}
				case Keyboard.A:{
					
					A_pressed = false;
				}
				case Keyboard.S:{
					
					S_pressed = false;
				}
				case Keyboard.D:{
					
					D_pressed = false;
				}
				case Keyboard.J:{
					
					J_pressed = false;
				}
				case Keyboard.K:{
					
					K_pressed = false;
				}
				case Keyboard.I:{
					
					I_pressed = false;
				}
				case Keyboard.ENTER:{
					
					ENTER_pressed = false;
				}
				default:{
					
				}
			}
		}
		
		/*
		* Sets the active controller to the one named in the 
		* argument string.
		*/
		public static function setController(controllerName:String){
			
			if(controllerName == "gameplayController"){
				activeController = GameplayController.getInstance();
			} else if(controllerName == "menuController"){
				activeController = MenuController.getInstance();
			} else {
				trace("Invalid controller name in Controller." +
					  "setController: " + controllerName);
			}
		}

	}
	
}
