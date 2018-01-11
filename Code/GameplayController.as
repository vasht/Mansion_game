package Code {
	
	import Code.Controller;
	
	/*
	* The controller used to control the character.
	* This class uses the Singleton programming pattern.
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
			var levelObject:LevelObject;
			var speed:Number = mainCharacter.moving_speed;
			
			if(W_pressed || S_pressed || A_pressed || D_pressed || J_pressed || K_pressed){
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
				if(J_pressed){
					mainCharacter.rotation-= speed;
					
					// Here I added controls to rotate the level object
					levelObject = CollisionDetector.getInstance().solidObjects[1];
					levelObject.rotation+= speed;
					levelObject.collider.has_moved = true;
					levelObject.collider.updateCollider();
					trace((levelObject.collider as RectangleCollider).rectangle.edge_array[0].p2);
				}
				if(K_pressed){
					mainCharacter.rotation+= speed;
					
					// Here I added controls to rotate the level object
					levelObject = CollisionDetector.getInstance().solidObjects[1];
					levelObject.rotation-= speed;
					levelObject.collider.has_moved = true;
				}
				mainCharacter.collider.has_moved = true;
			}
		} // End of processInput
	
	}
	
}
