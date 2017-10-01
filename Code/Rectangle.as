package Code {
	
	/*
	* A rectangle consisting of four points.
	* 
	*/
	public class Rectangle {
		
		public var corner_array:Array;
		
		public function Rectangle(corner1:Vector_2D, corner2:Vector_2D,
								  corner3:Vector_2D, corner4:Vector_2D) {
			
			corner_array = new Array(4);
			corner_array[0] = corner1;
			corner_array[1] = corner2;
			corner_array[2] = corner3;
			corner_array[3] = corner4;
		}

	}
	
}
