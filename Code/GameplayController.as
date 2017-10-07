package Code {
	
	import Code.Controller;
	
	/*
	* The controller used to control the character.
	* This class uses the Singleton programming pattern.
	*
	* TODO
	* -Make this also set the has_moved flag to true in the main character
	*/
	public class GameplayController extends Controller {

		private static var theInstance:GameplayController;

		/*
		* Since this class is supposed to be using the Singleton
		* pattern, this constructor should never be called outside
		* of the class.
		*/
		public function GameplayController(){
			
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
			
			var mainCharacter:MainCharacter = Mansion_game.getInstance().mainCharacter;
			var speed:Number = mainCharacter.moving_speed;
			
			if(W_pressed || S_pressed || A_pressed || D_pressed){
				if(W_pressed){
					mainCharacter.y-= speed;
				}
				if(S_pressed){
					mainCharacter.y+= speed;
				}
				if(A_pressed){
					mainCharacter.x-= speed;
				}
				if(D_pressed){
					mainCharacter.x+= speed;
				}
				mainCharacter.collider.has_moved = true;
			}
		}
	
	}
	
}
