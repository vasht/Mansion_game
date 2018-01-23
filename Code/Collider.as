package Code {
	
	import flash.display.MovieClip;
	
	/*
	* A Collider is used in the CollisionDetector to determine
	* if two SolidObjects collided or not.
	* A Collider actually has a shape, either rectangle or circle
	* (for now) which are used by the CollisionDetector.
	*
	*/
	public class Collider {
		
		public var tags:Tags;
		
		// The solid object whose collider this is
		public var solidObject:SolidObject;
		
		public var minX:Number;
		public var minY:Number;
		public var maxX:Number;
		public var maxY:Number;
		
		public var has_moved:Boolean;

		/*
		*
		*/
		public function Collider(_solidObject:SolidObject){
			tags = new Tags();
			tags.addTag("Collider");
			
			this.solidObject = _solidObject;
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
