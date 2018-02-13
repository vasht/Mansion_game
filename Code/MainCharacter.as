package Code {
	
	import Code.Geometry.RectangleCollider;
	import Code.Geometry.CircleCollider;
	
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
			
<<<<<<< HEAD
			collider = new RectangleCollider(this);
			// collider = new CircleCollider(this);
=======
			// collider = new RectangleCollider(this);
			collider = new CircleCollider(this);
>>>>>>> b7dd9326f7499a1d4e09a05b59483fecabb8cd1c
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
