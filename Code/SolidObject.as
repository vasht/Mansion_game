package Code{
	
	import flash.display.MovieClip;
	
	import Code.Tags;
	
	/*
	* A SolidObject is an object that the player cannot
	* walk through.
	*/
	public class SolidObject extends MovieClip{

		public var tags:Tags;

		public function SolidObject() {
			
			tags = new Tags();
			tags.addTag("SolidObject");
			
			// Add yourself to the solidObjects array in CollisionDetector
			CollisionDetector.getInstance().solidObjects.push(this);
			
		}

	}
	
}
