package Code {
	
	import flash.geom.Point;
	
	/*
	* A rectangle consisting of four points.
	* 
	* TODO:
	* -Make this save the rectangle as two-point lines
	*/
	public class Rectangle {
		
		public var edge_array:Array;
		
		public function Rectangle(corner1:Point, corner2:Point,
								  corner3:Point, corner4:Point) {
			
			edge_array = new Array(4);
			edge_array[0] = new TwoPointLine(corner1, corner2);
			edge_array[1] = new TwoPointLine(corner2, corner3);
			edge_array[2] = new TwoPointLine(corner3, corner4);
			edge_array[3] = new TwoPointLine(corner4, corner1);
		}

	}
	
}
