package Code {
	
	import flash.display.MovieClip;
	
	/*
	* A Collider is used in the CollisionDetector to determine
	* if two SolidObjects collided or not.
	* A Collider actually has a shape, either rectangle or circle
	* (for now) which are used by the CollisionDetector.
	*/
	public class Collider extends MovieClip {
		
		public var tags:Tags;

		public function Collider() {
			tags = new Tags()
		}

	}
	
}
