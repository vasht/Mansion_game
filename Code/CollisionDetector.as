package Code {
	
	import flash.geom.Point;
	
	/*
	*
	* TODO:
	* -Make collisionTestRectCirc test if a rectangle and a circle are touching
	* 	-Test that it works
	* -Make collisionTestCircles test if two circles are touching
	* 	-Test that it works
	* -Test that collisionTestObjects goes through every pair of dynamic objects
	* -Test that this goes through every pair of dynamic object and 
	* solid object
	* -Make the collisionTestRectangleEdgesWithCircle go through the rectangle
	* edges and check if any are intersecting the circle
	*/
	public class CollisionDetector {
		
		private static var theInstance:CollisionDetector;
		
		public var solidObjects:Array;
		public var dynamicObjects:Array;

		public function CollisionDetector() {
			solidObjects = new Array();
			dynamicObjects = new Array();
		}
		
		public static function getInstance():CollisionDetector{
			if(theInstance == null){
				theInstance = new CollisionDetector();
			}
			return theInstance;
		}
		
		/*
		* This function is called once per frame. It calls
		* other functions that check for collisions between
		* solid objects.
		*/
		public function update(){
			collisionTest();
		}
		
		/*
		* Checks for collisions between all the solid
		* and dynamic objects.
		* If there is a collision methods in both objects
		* are called to let them know about it.
		* All solid objects must have a method that's
		* called when there's a collision.
		*/
		public function collisionTest():void{
			
			// Checking for collisions between the dynamic objects
			// collisionTestObjects(dynamicObjects, dynamicObjects);
			
			// Checking for collisions between the dynamic and solid objects
			collisionTestObjects(dynamicObjects, solidObjects);
		}
		
		/*
		* Called when there has been a collision.
		*/
		public function collision(sol1:SolidObject, sol2:SolidObject){
			
			if(sol1.tags.containsTag("MainCharacter")){
				DebugGUI.getInstance().mainCharacterTouching = true;
			}
			
			// Telling the objects about the collision
			sol1.collision(sol2);
			sol2.collision(sol1);
		} // End of collision()
		
		
		/*
		* Checks if any of the objects in the given array collided with
		* any of the objects in the second given array.
		*/
		public function collisionTestObjects(objects_list1:Array, objects_list2:Array){
			
			// trace("objects_list2: " + objects_list2);
			DebugGUI.getInstance().mainCharacterTouching = false;
			
			// Object from the first array
			for(var i=0; i<objects_list1.length; i++){
				
				var dyn:DynamicObject = objects_list1[i];
				
				// Object from the second array
				for(var j=0; j<objects_list2.length; j++){
					
					var sol:SolidObject = objects_list2[j];
					
					// Updating before checking if they're the same object,
					// to make sure that every object gets updated, including the
					// first one
					
					
					sol.collider.updateCollider();
					
					if(dyn == sol){ continue; }
					
					// We have two rectangle colliders
					if(dyn.collider.tags.containsTag("RectangleCollider") &&
					   sol.collider.tags.containsTag("RectangleCollider")){
						
						// Calling collision() if they collided
						if(collisionTestRectangles(dyn.collider as RectangleCollider, 
												   sol.collider as RectangleCollider)){
							collision(dyn, sol);
						}
					
					// We have one rectangle and one circle collider 
					} else if(dyn.collider.tags.containsTag("RectangleCollider") &&
							  sol.collider.tags.containsTag("CircleCollider") || 
							  dyn.collider.tags.containsTag("CircleCollider") &&
							  sol.collider.tags.containsTag("RectangleCollider")){
						
						var collision_happened:Boolean;
						
						if(sol.collider.tags.containsTag("CircleCollider")){
							
							collision_happened = collisionTestRectCirc(dyn.collider as RectangleCollider, 
																	   sol.collider as CircleCollider);
						} else {
							
							collision_happened = collisionTestRectCirc(sol.collider as RectangleCollider, 
																	   dyn.collider as CircleCollider);
						}
						
						// Calling collision() if they collided
						if(collision_happened){
							collision(dyn, sol);
						}
						
					// We have two circle colliders
					} else if(dyn.collider.tags.containsTag("CircleCollider") &&
							  sol.collider.tags.containsTag("CircleCollider")){
						
						// Calling collision() if they collided
						if(collisionTestCircles(dyn.collider as CircleCollider, 
												sol.collider as CircleCollider)){
							collision(dyn, sol);
						}
					} else {
						trace("There's something wrong in CollisionDetector.collisionTest" + 
							  "DynamicObjects().");
							  
						trace("Tags in dyn.collider: ");
						dyn.collider.tags.traceTags();
						trace("Tags in sol.collider: ");
						sol.collider.tags.traceTags();
					}
				}
				
			}
		} // End of CollisionTestObjects
		
		/*
		* Checks if two given rectangle colliders are touching
		* First checks if the bounding boxes are overlapping. If they're not,
		* it returns false.
		* Then it checks if any of the edges are overlapping. If at least one pair
		* of edges is overlapping, returns true.
		*/
		public function collisionTestRectangles(rectCollider1:RectangleCollider, 
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
		public function collisionTestRectCirc(rectCollider:RectangleCollider, 
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
		public function collisionTestCircles(circleCollider1:CircleCollider, 
											 circleCollider2:CircleCollider):Boolean {
			return true;
		} // End of collisionTestCircles
		
		/*
		* Goes through the edges of the two given rectangles and checks if they're 
		* intersecting.
		*/
		public function collisionTestRectangleEdges(rect1:Rectangle, rect2:Rectangle):Boolean {
			
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
		public function collisionTestRectangleEdgesWithCircle(rect:Rectangle, circ:Circle):Boolean {
			
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
		public function collisionTestTwoPointLines(line1:TwoPointLine, line2:TwoPointLine):Boolean {
			
			var p1:Point = line1.p1;
			var p2:Point = line1.p2;
			var p3:Point = line2.p1;
			var p4:Point = line2.p2;
			
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
		public function checkLinesVertical(line1:TwoPointLine, line2:TwoPointLine):Boolean {
			
			var p1:Point = line1.p1;
			var p2:Point = line1.p2;
			var p3:Point = line2.p1;
			var p4:Point = line2.p2;
			
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
		public function checkOneLineVertical(line1:TwoPointLine, line2:TwoPointLine):Vector_2D {
			
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
		public function checkParallelLines(line1:TwoPointLine, line2:TwoPointLine, 
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
		public function checkNonParallelNonVerticalLines(line1:TwoPointLine, line2:TwoPointLine,
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
		* -Make this work with vertical lines
		*/
		public function checkLineCircle(line:TwoPointLine, circ:Circle):Boolean {
			
			// Parameters for the quadratic formula
			var a:Number;
			var b:Number;
			var c:Number;
			
			
			// Check if the line is vertical
			if(line.p1.x == line.p2.x){
				
				// We only need to figure out the y-coordinates
				var intersections_y:Array;
				
				// Calculating the intersection points with the 
				// circle
				// More information in Geometrical_equations_considerations.txt
				// a = 1
				// b = -2(my)
				// c = (my)^2 - r^2
				a = 1;
				b = -2*circ.midPoint.y;
				c = Math.pow(circ.midPoint.y, 2) - Math.pow(circ.radius, 2);
				
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
					var intersection:Vector_2D = new Vector_2D(line.p1.x, intersections_y[0]);
					if(pointOnTwoPointLine(intersection, line)){
					   trace("vertical, one solution:");
					   trace(intersection);
						return true;
					}
				} else {
						
					// There are two solutions
					var intersection1:Vector_2D = new Vector_2D(line.p1.x, intersections_y[0]);
					var intersection2:Vector_2D = new Vector_2D(line.p1.x, intersections_y[1]);
					
					// trace(intersection1);
					// Checking if the intersections are within the scope of the
					// two-point line
					if(pointOnTwoPointLine(intersection1, line) ||
					   pointOnTwoPointLine(intersection2, line)){
						   
						// trace("Vertical, two solutions");
						return true;
					}
				}
				
				
			} else {
				
				// The x-coordinates of the intersection(s)
				var intersections_x:Array;
			
				// The incline of the line
				var k:Number = (line.p2.y - line.p1.y)/(line.p2.x - line.p1.x);
				
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
			}
			
			// Solving the x-coorinates using the quadratic formula
			intersections_x = Math2.solveQuadraticEquation(a, b, c);
			
			
			
			return false;
		}
		
		/*
		* Checks if a given point is inside of the given rectangle
		* Use pointInRectangle.png as a reference for the variable names
		*/
		public function pointInRectangle(p:Vector_2D, rect:Rectangle):Boolean {
			
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
		function pointOnTwoPointLine(point:Vector_2D, line:TwoPointLine):Boolean {
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
		public function collisionTestBoundingRectangles(col1:Collider, col2:Collider):Boolean {
			
			if(col1.maxX > col2.minX && col1.minX < col2.maxX &&
			   col1.maxY > col2.minY && col1.minY < col2.maxY){
				return true;
			}
			return false;
		} // End of collisionTestBoundingRectangles
	}
	
}
