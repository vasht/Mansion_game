package Code {
	
	import flash.text.TextField;
	
	/*
	*
	*/
	public class DebugGUI {
		
		public static var theInstance:DebugGUI;
		
		private var touchingTextField:TextField;
		
		public var mainCharacterTouching:Boolean;

		public function DebugGUI() {
			touchingTextField = new TextField();
			touchingTextField.x = 20;
			touchingTextField.y = 20;
			touchingTextField.width = 100;
			touchingTextField.height = 20;
			
			Mansion_game.mainStage.addChild(touchingTextField);
			
			mainCharacterTouching = false;
		}
		
		public static function getInstance():DebugGUI{
			if(theInstance == null){
				theInstance = new DebugGUI();
			}
			return theInstance;
		}
		
		public function update(){
			
			if(mainCharacterTouching){
				touchingTextField.text = "Touching";
			} else {
				touchingTextField.text = "Not touching";
			}
		}

	}
	
}
