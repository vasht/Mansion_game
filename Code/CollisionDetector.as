package Code {
	
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
		* Checks if any of the dynamic objects collided with
		* any of the other dynamic objects.
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
		*
		*/
		public function collisionTestRectangles(rectCollider1:RectangleCollider, 
												rectCollider2:RectangleCollider):Boolean{
			
			if(!collisionTestBoundingRectangles(rectCollider1, rectCollider2)){
				return false;
			}
			
			
			
			return true;
		}

		/*
		*
		*/
		public function collisionTestRectCirc(rectCollider:RectangleCollider, 
											  circleCollider:CircleCollider):Boolean{
			return true;
		}
		
		/*
		*
		*/
		public function collisionTestCircles(circleCollider1:CircleCollider, 
											 circleCollider2:CircleCollider):Boolean {
			return true;
		}
		
		/*
		* TODO:
		* -Make a test file, where you can click and drag the end points of two lines
		* and it shows wether they're touching or not
		* -Check if either of the lines is vertical
		* -Make it so if both of them are vertical, it checks their x-values are the same
		* -Make it so if they are both vertical, and have the same x-values, it checks
		* if they occupy the same interval
		* -Make it so that if only one of them is vertical, it calculates where the two lines
		* meet
		* 	-Write a function that takes a two point line and a point that's somewhere on the
		* 	line that goes through those two points, and checks whether it's between the two
		*	points or not
		* -Check if the lines are parallel
		* -Make it so if they're parallel, it checks if they have the same c parameter
		* -Make it so if they're parallel and have the same c parameter, it checks if 
		* they're actually touching
		* -Make this function do collision testing between two lines between two points
		* and return the result
		*/
		public function collisionTestTwoPointLines(line1:TwoPointLine, line2:TwoPointLine):Boolean {
			
			// Checking if either of the lines is vertical
			if(line1.p1.x == line1.p2.x){
				
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
		}
		
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
		* -No need to check if the given point is actuallu on the line that goes through
		* the two points, as we've already checked that before calling this
		*
		* TODO:
		* -Make this function check the distance from the point to both points in
		* the two point line
		* 	-If the distance to both is less or equal to the distance between
		*	the end points in the two point line, then the point is on the line
		*/
		public function pointOnTwoPointLine(point:Vector_2D, line:TwoPointLine):Boolean{
			  
		}
	}
	
}
