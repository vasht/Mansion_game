package Code.Geometry {
	
	import Code.Vector_2D;
	
	/*
	* A circle consisting of center coordinates as a Vector_2D
	* instance, and a radius.
	*/
	public class Circle {
		
		public var midPoint:Vector_2D;
		
		public var radius:Number;
		
		public function Circle(_midPoint:Vector_2D, _radius:Number){
			this.midPoint = _midPoint;
			this.radius = _radius;
		}

	}
	
}
