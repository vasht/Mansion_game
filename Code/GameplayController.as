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
	
	}
	
}
