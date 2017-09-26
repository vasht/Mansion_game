package Code{
	
	import Code.Vector_2D;
	
	/*
	* A MovingObject extends the SolidObject class.
	* It adds properties related to movement
	* such as vectors for velocity and accelerations.
	*/
	public class DynamicObject extends SolidObject{
		
		public var velocity:Vector_2D;
		public var acceleration:Vector_2D;
		
		/*
		* The constructor
		*/
		public function DynamicObject() {
		
			tags.addTag("DynamicObject");
			
			// Add yourself to the dynamicObjects array in the CollisionDetector 
			// instance.
			CollisionDetector.getInstance().dynamicObjects.push(this);
		}

	}
	
}
