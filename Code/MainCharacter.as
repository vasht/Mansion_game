package Code{
	
	/*
	* The main character of the game. This class extends
	* the MovingObject class and uses the Singleton programming
	* pattern.
	* This class contains properties such as
	* health, movement speed, mood properties etc. related
	* to the character.
	*/
	public class MainCharacter extends MovingObject{
		
		private static var theInstance:MainCharacter;
		
		public function MainCharacter(){
			
		}
		
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
