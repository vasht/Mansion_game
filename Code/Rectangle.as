package Code {
	
	import flash.geom.Point;
	
	/*
	* A rectangle consisting of four points.
	*/
	public class Rectangle {
		
		public var edge_array:Array;
		
		public function Rectangle(corner1:Vector_2D, corner2:Vector_2D,
								  corner3:Vector_2D, corner4:Vector_2D) {
			
			edge_array = new Array(4);
			edge_array[0] = new TwoPointLine(corner1, corner2);
			edge_array[1] = new TwoPointLine(corner2, corner3);
			edge_array[2] = new TwoPointLine(corner3, corner4);
			edge_array[3] = new TwoPointLine(corner4, corner1);
		}

	}
	
}
