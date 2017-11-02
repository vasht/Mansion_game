package Code {
	
	import flash.geom.Point;
	
	/*
	*
	* TODO
	* -Make collisionTestRectangles check if any of the edges between two rectangles
	* are crossing each other
	* -Make collisionTestRectangles test if two rotated rectangles are touching
	* 	-Test if it works
	* -Make collisionTestRectCirc test if a rectangle and a circle are touching
	* 	-Test if it works
	* -Make collisionTestCircles test if two circles are touching
	* 	-Test if it works
	* -Test that collisionTestObjects goes through every pair of dynamic objects
	* -Test that this goes through every pair of dynamic object and 
	* solid object
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
		}
		
		/*
		* Checks if any of the objects in the given array collided with
		* any of the objects in the second given array.
		*/
		public function collisionTestObjects(objects_list1:Array, objects_list2:Array){
			
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
					if(sol.collider.has_moved){
						sol.collider.updateCollider();
					}
					
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
		*/
		public function collisionTestRectangles(rectCollider1:RectangleCollider, 
												rectCollider2:RectangleCollider):Boolean{
			
			// Checking if the bounding rectangles are overlapping
			if(!collisionTestBoundingRectangles(rectCollider1, rectCollider2)){
				return false;
			}
			
			
			
			return true;
		}

		/*
		* Checks if a given rectangle and circle collider are touching
		*/
		public function collisionTestRectCirc(rectCollider:RectangleCollider, 
											  circleCollider:CircleCollider):Boolean{
			return true;
		}
		
		/*
		* Checks if two given circle colliders are touching
		*/
		public function collisionTestCircles(circleCollider1:CircleCollider, 
											 circleCollider2:CircleCollider):Boolean {
			return true;
		}
		
		/*
		* TODO:
		* 	
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
			var iCoord:Point = new Point();
			
			// Checking if one of the lines is vertical
			if(p1.x == p2.x || p3.x == p4.x){
				
				// The points of whichever line is vertical
				var vp1:Point;
				var vp2:Point;
				// The points of whichever line is not vertical
				var nvp1:Point;
				var nvp2:Point;
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
				
			} else {
		
			// Neither line is vertical
			// Checking if the lines are parallel to each other
			// Incline of the lines
			var k1:Number = (p2.y - p1.y)/(p2.x - p1.x);
			var k2:Number = (p4.y - p3.y)/(p4.x - p3.x);
			k1 = Math.round(k1*100)/100;
			k2 = Math.round(k2*100)/100;
			if(k1 == k2){
				/*
				* The lines are parallel to each other
				* Checking if they're aligned by calculating y at x = 0 
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
				// trace("c1: " + c1);
				// trace("c2: " + c2);
				if(c1 == c2){
					// trace("lol");
					// Checking that the lines occupy the same interval
					if(pointOnTwoPointLine(p1, p3, p4) ||
					   pointOnTwoPointLine(p2, p3, p4)){
						touchingTextField.text = "true";
					}
				} else {
					touchingTextField.text = "false";
				}
				return;
			}
			
			// Calculating the inclines of both lines
			// k = (y2 - y1)/(x2 - x1)
			var k1:Number = (line1.p2.y - line1.p1.y) / (line1.p2.x - line1.p1.x);
			var k2:Number = (line2.p2.y - line2.p1.y) / (line2.p2.x - line2.p1.x);
			
			// Checking if the lines are parallel
			if(k1 == k2){
				
			}
			
			
			/*
			* 
			*/
			var collision_x:Number = 
			
			return true;
		} // End of collisionTestTwoPointLines
		
		public function checkLinesVertical(line1:TwoPointLine, line2:TwoPointLine):Boolean{
			
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
		} // End of checkLinesVertical
		
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
		}
		
		/*
		* 
		* -No need to check if the given point is actually on the line that goes through
		* the two points, as we've already checked that before calling this
		*
		* TODO:
		* -Make this function check the distance from the point to both points in
		* the two point line
		* 	-If the distance to both is less or equal to the distance between
		*	the end points in the two point line, then the point is on the line
		*/
		public function pointOnTwoPointLine(point:Point, line:TwoPointLine):Boolean{
			  
		}
	}
	
}
