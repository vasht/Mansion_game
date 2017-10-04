package Code {
	
	import flash.display.MovieClip;
	
	/*
	* A Collider is used in the CollisionDetector to determine
	* if two SolidObjects collided or not.
	* A Collider actually has a shape, either rectangle or circle
	* (for now) which are used by the CollisionDetector.
	*
	* TODO
	* 
	*/
	public class Collider {
		
		public var tags:Tags;
		
		// The solid object whose collider this is
		public var solidObject;
		
		public var has_moved:Boolean;

		public function Collider() {
			tags = new Tags();
			has_moved = false;
		}
		
		/*
		*
		*/
		public function updateCollider():void{
			
			has_moved = false;
		}

	}
	
}
