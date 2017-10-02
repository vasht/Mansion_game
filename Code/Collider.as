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
		
		public var has_moved:Boolean;

		public function Collider() {
			tags = new Tags();
			has_moved = true;
		}
		
		/*
		*
		*/
		public function updateCollider():void{
			
			has_moved = false;
		}

	}
	
}
