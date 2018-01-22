package Code {
	
	/*
	* A level object is something in the level that you
	* can't walk through, like walls, pillars, shelves etc.
	*/
	
	/*
	* TODO:
	* -Figure out a way for this to get the appropriate kind
	* of collider
	*/
	public class LevelObject extends SolidObject {
		
		
		public function LevelObject() {
			tags.addTag("LevelObject");
			
			collider = new RectangleCollider(this);
		}

	}
	
}
