package Code{
	
	import flash.display.MovieClip;
	
	import Code.Tags;
	
	/*
	* A SolidObject is an object that the player cannot
	* walk through.
	*
	* Any class that extends this class should initialize the collider
	* parameter to the correct type of collider!
	*
	* TODO
	* 
	*/
	public class SolidObject extends MovieClip {

		public var tags:Tags;
		
		// The collider should be initialized in whatever class
		// extends this class
		public var collider:Collider;

		public function SolidObject() {
			
			tags = new Tags();
			tags.addTag("SolidObject");
			// trace("From solid object");
			// Add yourself to the solidObjects array in CollisionDetector
			CollisionDetector.getInstance().solidObjects.push(this);
			
		}
		
		/*
		* This is supposed to be overridden by classes that
		* extend the SolidObject class.
		*/
		public function collision(solidObject:SolidObject):void{
			
		}

	}
	
}
