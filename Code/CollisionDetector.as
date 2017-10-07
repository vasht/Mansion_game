package Code {
	
	/*
	*
	* TODO
	* -Make collisionTestRectangles test if two rectangles are touching
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
			
			
			return collisionTestBoundingRectangles(rectCollider1, rectCollider2);
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
											 circleCollider2:CircleCollider):Boolean{
			return true;
		}
		
		/*
		* TODO
		* -Test that this works with rectangles
		* -Test that this works with circles
		*/
		public function collisionTestBoundingRectangles(col1:Collider, col2:Collider):Boolean {
			
			// trace("col1.maxX: " + col1.maxX);
			// trace("col1.minX: " + col1.minX);
			// trace("col1.maxY: " + col1.maxY);
			// trace("col1.minY: " + col1.minY);
			// trace("col2.maxY: " + col2.maxY);
			if(col1.maxX > col2.minX && col1.minX < col2.maxX &&
			   col1.maxY > col2.minY && col1.minY < col2.maxY){
				return true;
			}
			return false;
		}
	}
	
}
