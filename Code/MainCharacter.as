package Code{
	
	/*
	* The main character of the game. This class extends
	* the DynamicObject class and uses the Singleton programming
	* pattern.
	* This class contains properties such as
	* health, movement speed, mood properties etc. related
	* to the character.
	*/
	public class MainCharacter extends DynamicObject{
		
		// Static variables
		private static var theInstance:MainCharacter;
		
		/*
		* The constructor
		*/
		public function MainCharacter(){
			Mansion_game.getInstance().mainCharacter = this;
		}
		
		/*
		*
		* Static functions
		*/
		
		/*
		*
		*/
		public static function getInstance():MainCharacter{
			if(theInstance == null){
				theInstance = new MainCharacter();
			}
			return theInstance;
		}

	}
	
}
