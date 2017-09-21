package Code{
	
	import Code.Vector_2D;
	
	/*
	* A MovingObject extends the GameObject class.
	* It adds properties related to movement
	* such as vectors for velocity and accelerations.
	*/
	public class MovingObject extends GameObject{
		
		public var velocity:Vector_2D;
		public var acceleration:Vector_2D;
		
		/*
		* The constructor
		*/
		public function MovingObject() {
			
		}

	}
	
}
