﻿package Code.Geometry {
	
	import flash.geom.Point;
	import Code.Math2;
	
	import Code.Collider;
	import Code.Vector_2D;
	
	
	/*
	* A class that contains functions related to geometry.
	* Mostly for checking if two geometrical shapes are intersecting.
	*
	* This is a static class, so the constructor should not be used.
	*/
	public class GeometricalEquations {

		public function GeometricalEquations() {
			trace("The GeometricalEquations class constructor should not " + 
				  "be used!");
		}
		
		/*
		* Checks if two given rectangle colliders are touching
		* First checks if the bounding boxes are overlapping. If they're not,
		* it returns false.
		* Then it checks if any of the edges are overlapping. If at least one pair
		* of edges is overlapping, returns true.
		*/
		public static function collisionTestRectangles(rectCollider1:RectangleCollider, 
												rectCollider2:RectangleCollider):Boolean{
			
			// Checking if the bounding rectangles are overlapping
			if(!collisionTestBoundingRectangles(rectCollider1, rectCollider2)){
				return false;
			}
			
			// Checking if any pair of edges from the rectangles is overlapping.
			if(collisionTestRectangleEdges(rectCollider1.rectangle, rectCollider2.rectangle)){
				return true;
			}
			
			// None of the edges were overlapping
			// Checking if one of the rectangles is inside of the other one
			// We do this by checking if one arbitrary corner in either one is 
			// inside of the other rectangle.
			var rect1_corner0:Vector_2D = (rectCollider1.rectangle.edge_array[0] as TwoPointLine).p1;
			var rect2_corner0:Vector_2D = (rectCollider2.rectangle.edge_array[0] as TwoPointLine).p1;
			
			
			if(pointInRectangle(rect1_corner0, rectCollider2.rectangle) ||
			   pointInRectangle(rect2_corner0, rectCollider1.rectangle)){
				return true;
			}
			
			return false;
		} // End of collisionTestRectangles

		/*
		* Checks if a given rectangle and circle collider are touching
		*/
		public static function collisionTestRectCirc(rectCollider:RectangleCollider, 
											  circCollider:CircleCollider):Boolean{
			
			// Checking if the bounding rectangles are overlapping
			if(!collisionTestBoundingRectangles(rectCollider, circCollider)){
				
				return false;
			}
			
			// Checking if any pair of edges from the rectangles is overlapping.
			if(collisionTestRectangleEdgesWithCircle(rectCollider.rectangle, circCollider.circle)){
				return true;
			}
			
			return false;
		} // End of collisionTestRectCirc
		
		/*
		* Checks if two given circle colliders are touching
		*/
		public static function collisionTestCircles(circCollider1:CircleCollider, 
											 circCollider2:CircleCollider):Boolean {
			
			// Checking if the bounding rectangles are overlapping
			if(!collisionTestBoundingRectangles(circCollider1, circCollider2)){
				
				return false;
			}
			
			// Calculating the distance between the center points
			var r1:Number = circCollider1.circle.radius;
			var r2:Number = circCollider2.circle.radius;
			
			var center1:Vector_2D = circCollider1.circle.midPoint;
			var center2:Vector_2D = circCollider2.circle.midPoint;
			
			var distance:Number = Vector_2D.distance(center1,center2);
			
			// Checking if the two circles are touching
			if(distance <= (r1 + r2)){
				return true;
			}
			
			return false;
		} // End of collisionTestCircles
		
		
		/*
		* Goes through the edges of the two given rectangles and checks if they're 
		* intersecting.
		*/
		public static function collisionTestRectangleEdges(rect1:Rectangle, rect2:Rectangle):Boolean {
			
			// Going through the edges of the first rectangle
			for(var i=0; i<rect1.edge_array.length; i++){
				
				var line1:TwoPointLine = rect1.edge_array[i];
				// Going through the edges of the second rectangle
				for(var j=0; j<rect2.edge_array.length; j++){
					var line2:TwoPointLine = rect2.edge_array[j];
					
					// Checking if these lines are intersecting
					if(collisionTestTwoPointLines(line1, line2)){
						return true;
					}
				}
			}
			return false;
		} // End of collisionTestRectangleEdges
		
		/*
		* Goes through the edges of the given rectangle and checks if they're 
		* intersecting the given circle.
		*
		* There's documentation on how I deduced the equations for
		* where the line and circle intersect in the file Geometrical_equations_considerations.txt
		*/
		public static function collisionTestRectangleEdgesWithCircle(rect:Rectangle, circ:Circle):Boolean {
			
			var line:TwoPointLine;
			
			// Checkin if any of the edges intersect the circle
			for(var i=0; i<rect.edge_array.length; i++){
				line = rect.edge_array[i];
				
				if(checkLineCircle(line, circ)){
					return true;
				}
			}
				
			return false;
		} // End of collisionTestRectangleEdgesWithCircle
		
		
		/*
		* Checks if two given lines between two points are intersecting.
		*/
		public static function collisionTestTwoPointLines(line1:TwoPointLine, line2:TwoPointLine):Boolean {
			
			var p1:Vector_2D = line1.p1;
			var p2:Vector_2D = line1.p2;
			var p3:Vector_2D = line2.p1;
			var p4:Vector_2D = line2.p2;
			
			// Checking if both of the lines are vertical
			if(p1.x == p2.x && p3.x == p4.x){
				return checkLinesVertical(line1, line2);
			}
			
			// The intersection coordinates
			var iCoord:Vector_2D;
			
			// Checking if one of the lines is vertical
			if(p1.x == p2.x || p3.x == p4.x){
				
				iCoord = checkOneLineVertical(line1, line2);
			} else {
		
				// Neither line is vertical
				// Checking if the lines are parallel to each other
				
				// Incline of the lines
				var k1:Number = (p2.y - p1.y)/(p2.x - p1.x);
				var k2:Number = (p4.y - p3.y)/(p4.x - p3.x);
				
				// Rounding the incline to two decimal places
				k1 = Math.round(k1*100)/100;
				k2 = Math.round(k2*100)/100;
				if(k1 == k2){
					// The lines are parallel to each other
					return checkParallelLines(line1, line2, k1, k2);
				}
			
				// The lines are not parallel to each other
				iCoord = checkNonParallelNonVerticalLines(line1, line2, k1, k2);
			}
		
			/*
			* Checking if the intersection coordinates are within the interval
			* defined by the two points on both lines.
			*/
			if(pointOnTwoPointLine(iCoord, line1) &&
			   pointOnTwoPointLine(iCoord, line2)){
				
				return true;
			} else {
				return false;
			}
			
		} // End of collisionTestTwoPointLines
		
		/*
		* Checks if two given vertical lines are touching
		*/
		public static function checkLinesVertical(line1:TwoPointLine, line2:TwoPointLine):Boolean {
			
			var p1:Vector_2D = line1.p1;
			var p2:Vector_2D = line1.p2;
			var p3:Vector_2D = line2.p1;
			var p4:Vector_2D = line2.p2;
			
			// Checking if the lines are aligned with each other
			if(p1.x == p3.x){
				
				// Checking if they occupy the same interval
				if((p3.y > p1.y && p3.y > p2.y && p4.y > p1.y && p4.y > p2.y) ||
					(p3.y < p1.y && p3.y < p1.y && p4.y < p1.y && p4.y < p2.y)){
					return false;
				}
				
				return true;
			}
			return false;
		} // End of checkLinesVertical
		
		/*
		* Checks if two given lines between two points, where one is vertical,
		* are touching.
		*/
		public static function checkOneLineVertical(line1:TwoPointLine, line2:TwoPointLine):Vector_2D {
			
			var iCoord:Vector_2D = new Vector_2D();
			
			var p1:Vector_2D = line1.p1;
			var p2:Vector_2D = line1.p2;
			var p3:Vector_2D = line2.p1;
			var p4:Vector_2D = line2.p2;
			
			// The points of whichever line is vertical
			var vp1:Vector_2D;
			var vp2:Vector_2D;
			// The points of whichever line is not vertical
			var nvp1:Vector_2D;
			var nvp2:Vector_2D;
			// The inclination of the non-vertical line
			var nvk:Number;
			
			// Checking if the first line is vertical
			if(p1.x == p2.x){
				vp1 = p1;
				vp2 = p2;
				nvp1 = p3;
				nvp2 = p4;
			} else {
				// The second line is vertical
				vp1 = p3;
				vp2 = p4;
				nvp1 = p1;
				nvp2 = p2;
			}
			// Incline of the non-vertical line
			nvk = (nvp2.y - nvp1.y)/(nvp2.x - nvp1.x);
			
			iCoord.x = vp1.x;
		
			// Calculating the y-coordinate of the intersection
			// y = tk*vp1.x - tk*tp1.x + tp1.y
			iCoord.y = nvk*vp1.x - nvk*nvp1.x + nvp1.y;
			
			
			return iCoord;
		} // End of checkOneLineVertical
		
		/*
		* Checks if two given parallel lines, between two points, are touching.
		*/
		public static function checkParallelLines(line1:TwoPointLine, line2:TwoPointLine, 
										   k1:Number, k2:Number):Boolean {
			
			var p1:Vector_2D = line1.p1;
			var p2:Vector_2D = line1.p2;
			var p3:Vector_2D = line2.p1;
			var p4:Vector_2D = line2.p2;
			
			/*
			* Checking if the lines are aligned by calculating y at x = 0 
			* for both lines, aka. the c parameter.
			* If they have the same c parameter, then they are
			* aligned with each other
			* c = k1x1 + y1
			*/
			var c1:Number = -k1*p1.x + p1.y;
			var c2:Number = -k2*p3.x + p3.y;
			
			// Rounding c1 and c2 to two decimals
			c1 = Math.round(c1*100)/100;
			c2 = Math.round(c2*100)/100;
			if(c1 == c2){
				
				// Checking that the lines occupy the same interval
				if(pointOnTwoPointLine(p1, line2) ||
				   pointOnTwoPointLine(p2, line2)){
					return true;
				}
			}
			// The lines aren't touching
			return false;
		} // End of checkParallelLines
		
		/*
		* Checks if two given lines, between two points, that aren't vertical or parallel to
		* each other, are intersecting each other.
		*/
		public static function checkNonParallelNonVerticalLines(line1:TwoPointLine, line2:TwoPointLine,
														 k1:Number, k2:Number):Vector_2D {
												
			var p1:Vector_2D = line1.p1;
			var p2:Vector_2D = line1.p2;
			var p3:Vector_2D = line2.p1;
			var p4:Vector_2D = line2.p2;
			
			/* 
			* Calculating the intersection coordinates for the lines
			*
			* y = k1x - k1x1 + y1, y' = k2x - k2x3 + y3
			* Math magic ->
			* x = (k1x1 - k2x3 - y1 + y3)/(k1 - k2)
			*/
			var iCoord:Vector_2D = new Vector_2D();
			iCoord.x = (k1*p1.x - k2*p3.x - p1.y + p3.y)/(k1 - k2);
			
			/*
			* y = k1x - k1x1 + y1
			*/
			iCoord.y = k1*iCoord.x - k1*p1.x + p1.y;
			return iCoord;
		} // End of checkNonParallelNonVerticalLines
		
		/*
		* Takes a two-point line and a circle and checks if they
		* TODO:
		* -Make this work with vertical lines, when there's only one 
		* intersection
		* -Make this work with non-vertical lines when there are two
		* intersections
		* -Make a test file where you test that this function works correctly
		*/
		public static function checkLineCircle(line:TwoPointLine, circ:Circle):Boolean {
			
			// Parameters for the quadratic formula
			var a:Number;
			var b:Number;
			var c:Number;
			var intersection:Vector_2D;
			var intersection1:Vector_2D;
			var intersection2:Vector_2D;
			
			if(Math.abs(line.p2.x - line.p1.x) < 0.5){
				// trace(line.p2.x - line.p1.x);
				line.p2.x = line.p1.x;
				
			}
			// Check if the line is vertical
			if(line.p1.x == line.p2.x){
				
				// We only need to figure out the y-coordinates
				var intersections_y:Array;
				
				// Calculating the intersection points with the 
				// circle
				// More information in Geometrical_equations_considerations.txt
				// v = (x - (mx))^2
				// a = 1
				// b = -2(my)
				// c = (my)^2 + v - r^2
				var v:Number = Math.pow(line.p1.x - circ.midPoint.x, 2); 
				a = 1;
				b = -2*circ.midPoint.y;
				c = Math.pow(circ.midPoint.y, 2) + v - Math.pow(circ.radius, 2);
				
				// Checking the intersections
				// This calculates the y-coordinates of the intersections
				// The x-coordinates are known, since the line is vertical
				intersections_y = Math2.solveQuadraticEquation(a, b, c);
				
				// They don't intersect
				if(intersections_y.length == 0){
						
					return false;
				} else if(intersections_y.length == 1){
					
					// There's one intersection point
					// Checking if it's in the scope of the two-point line
					intersection = new Vector_2D(line.p1.x, intersections_y[0]);
					if(pointOnTwoPointLine(intersection, line)){
					   
					   // trace("vertical, one solution:");
					   // trace(intersection);
						return true;
					}
					return false;
				} else {
						
					// There are two solutions
					intersection1 = new Vector_2D(line.p1.x, intersections_y[0]);
					intersection2 = new Vector_2D(line.p1.x, intersections_y[1]);
					
					// trace(intersection1);
					// Checking if the intersections are within the scope of the
					// two-point line
					if(pointOnTwoPointLine(intersection1, line) ||
					   pointOnTwoPointLine(intersection2, line)){
						   
						// trace("Vertical, two solutions");
						// trace(intersection1);
						// trace(intersection2);
						return true;
					}
					return false;
				}
			}
			
			// The line is not vertical
			// The x-coordinates of the intersection(s)
			var intersections_x:Array;
		
			// The incline of the line
			var k:Number = (line.p2.y - line.p1.y)/(line.p2.x - line.p1.x);
			// trace("k: " + k);
			
			// Solving y0, that is y(x=0)
			// y0 = y - kx
			// Inserting p1 as the x and y
			var y0:Number = line.p1.y - k*line.p1.x;
			
			// d = y0 - my
			var d:Number = y0 - circ.midPoint.y;
			
			// Solving intersection
			// c = (mx)^2 + d^2 - r^2
			c = Math.pow(circ.midPoint.x, 2) + Math.pow(d, 2) - 
			Math.pow(circ.radius, 2);
			
			// a = 1 + k^2
			a = 1 + Math.pow(k, 2);
			
			// b = 2(dk - (mx))
			b = 2*(d*k - circ.midPoint.x);
			
			// Solving the x-coorinates using the quadratic formula
			intersections_x = Math2.solveQuadraticEquation(a, b, c);
			
			
			if(intersections_x.length == 0){
				// trace("non-vertical, no solutions");
				return false;
			} else if(intersections_x.length == 1){
				
				// One intersection
				// Calculating y
				// y = kx + y0
				var coord_y:Number = k*intersection[0] + y0;
				intersection = new Vector_2D(intersections_x[0], coord_y);
				if(pointOnTwoPointLine(intersection, line)){
					// trace("non-vertical, one solution");
					return true
				}
			} else {
				
				// Two intersections
				// Calculating y for both intersections
				// and checking if they are in the two-point boundaries
				// Calculating y
				// y = kx + y0
				var coord_y1:Number = k*intersections_x[0] + y0;
				var coord_y2:Number = k*intersections_x[1] + y0;
				intersection1 = new Vector_2D(intersections_x[0], coord_y1);
				intersection2 = new Vector_2D(intersections_x[1], coord_y2);
				if(pointOnTwoPointLine(intersection1, line) ||
				   pointOnTwoPointLine(intersection2, line)){
					
					// trace("non-vertical, two solutions");
					return true
				}
			}
			
			return false;
		} // End of checkLineCircle
		
		
		/*
		* Checks if a given point is inside of the given rectangle
		* Use pointInRectangle.png as a reference for the variable names
		*/
		public static function pointInRectangle(p:Vector_2D, rect:Rectangle):Boolean {
			
			var p0:Vector_2D = (rect.edge_array[0] as TwoPointLine).p1; // Upper left corner
			var p2:Vector_2D = (rect.edge_array[2] as TwoPointLine).p1; // Lower right corner
			var p3:Vector_2D = (rect.edge_array[3] as TwoPointLine).p1; // Lower left corner
			
			// p4 is the vector from p3 to p2
			// p5 is the vector from p3 to p
			// p6 is the vector from p3 to p0
			// p4 = -p3 + p2
			// p5 = -p3 + p
			// p6 = -p3 + p0
			var p4:Vector_2D = p3.negative().addVector(p2);
			var p5:Vector_2D = p3.negative().addVector(p);
			var p6:Vector_2D = p3.negative().addVector(p0);
			
			// xprime is the magnitude of p5 projected on p4
			// yprime is the magnitude of p5 projected on p0
			// xprime = (p4*p5)/magnitude(p4) (wikipedia)
			// yprime = (p6*p5)/magnitude(p6)
			var xprime:Number = Vector_2D.dotProduct(p4, p5)/p4.magnitude();
			var yprime:Number = Vector_2D.dotProduct(p6, p5)/p6.magnitude();
			
			// trace("xprime: " + xprime);
			// trace("yprime: " + yprime);
			// trace("p0.y: " + p0.y);
			// trace("p3.y: " + p3.y);
			// trace(yprime > 0 && yprime < (p0.y - p3.y));
			if(xprime > 0 && xprime < rect.rect_width &&
			   yprime > 0 && yprime < rect.rect_height){
				return true;
			}
			
			return false;
			
		} // End of pointInRectangle
		
		
		/*
		* -No need to check if the given point is actually on the line that goes through
		* the two points, as we've already checked that before calling this
		*
		* Checks the distance from the point to both points in
		* the two point line
		* 	-If the distance to both is less or equal to the distance between
		*	the end points in the two point line, then the point is on the line
		*
		* TODO:
		* -Change this to use Vector_2D instances instead of flash.geom.Point
		*/
		public static function pointOnTwoPointLine(point:Vector_2D, line:TwoPointLine):Boolean {
			var lineLength:Number = Point.distance(line.p1, line.p2);
			var distanceToPoint1:Number = Point.distance(point, line.p1);
			var distanceToPoint2:Number = Point.distance(point, line.p2);
			
			if(distanceToPoint1 <= lineLength && distanceToPoint2 <= lineLength){
				return true;
			}
			return false;
		} // End of pointOnTwoPointLine
		
		/*
		* TODO:
		* -Test that this works with circles
		*/
		public static function collisionTestBoundingRectangles(col1:Collider, col2:Collider):Boolean {
			
			if(col1.maxX > col2.minX && col1.minX < col2.maxX &&
			   col1.maxY > col2.minY && col1.minY < col2.maxY){
				return true;
			}
			return false;
		} // End of collisionTestBoundingRectangles

	}
	
}
