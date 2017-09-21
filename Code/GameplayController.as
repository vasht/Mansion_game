package Code{
	
	import Code.Controller;
	
	/*
	* The controller used to control the character.
	* This class uses the Singleton programming pattern.
	*/
	public class GameplayController extends Controller{

		private static var theInstance:GameplayController;

		/*
		* Since this class is supposed to be using the Singleton
		* pattern, this constructor should never be called outside
		* of the class.
		*/
		public function GameplayController() {
			
		}
		
		/*
		*
		*/
		public static function getInstance():GameplayController{
			if(theInstance == null){
				theInstance = new GameplayController();
			}
			return theInstance;
		}
		
		/*
		* This function overrides the processInput function in the
		* Controller class. It responds to input by doing stuff,
		* like moving the character, interacting with stuff and
		* pausing the game. :O
		*/
		protected override function processInput(){
			super.processInput();
			
			if(W_pressed){
				
				Mansion_game.getInstance().mainCharacter.y-= 5.0;
			}
			if(S_pressed){
				
				Mansion_game.getInstance().mainCharacter.y+= 5.0;
			}
			if(A_pressed){
				Mansion_game.getInstance().mainCharacter.x-= 5.0;
			}
			if(D_pressed){
				Mansion_game.getInstance().mainCharacter.x+= 5.0;
			}
		}
	
	}
	
}
