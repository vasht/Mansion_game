package Code {
	
	/*
	* The main character of the game. This class extends
	* the DynamicObject class and uses the Singleton programming
	* pattern.
	* This class contains properties such as
	* health, movement speed, mood properties etc. related
	* to the character.
	*
	* TODO
	* 
	*/
	public class MainCharacter extends DynamicObject {
		
		// Static variables
		private static var theInstance:MainCharacter;
		
		public var moving_speed:Number = 5.0;
		
		/*
		* The constructor
		*/
		public function MainCharacter(){
			Mansion_game.getInstance().mainCharacter = this;
			tags.addTag("MainCharacter");
			
			collider = new RectangleCollider(this);
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
