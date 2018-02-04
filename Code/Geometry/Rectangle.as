package Code.Geometry {
	
	import flash.geom.Point;
	import Code.Vector_2D;
	
	/*
	* A rectangle consisting of four TwoPointLine instances as its
	* edges.
	*/
	public class Rectangle {
		
		public var edge_array:Array;
		
		// Width and height of the rectangle, but not along x- or y-axis
		public var rect_width:Number;
		public var rect_height:Number;
		
		/*
		* The constructor takes the corners as four Vector_2D instances,
		* going clock-wise around the rectangle, starting from
		* the upper-left corner.
		*/
		public function Rectangle(corner1:Vector_2D, corner2:Vector_2D,
								  corner3:Vector_2D, corner4:Vector_2D) {
			
			edge_array = new Array(4);
			edge_array[0] = new TwoPointLine(corner1, corner2);
			edge_array[1] = new TwoPointLine(corner2, corner3);
			edge_array[2] = new TwoPointLine(corner3, corner4);
			edge_array[3] = new TwoPointLine(corner4, corner1);
			
			rect_width = Point.distance(corner1, corner2);
			rect_height = Point.distance(corner1, corner4);
		}

	}
	
}
