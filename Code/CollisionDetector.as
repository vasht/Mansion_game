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
					if(!sol.collider.has_moved){
						sol.collider.updateCollider();
					}
					
					if(dyn == sol){ continue; }
					
					// We have two rectangle colliders
					if(dyn.collider.tags.containsTag("RectangleCollider") &&
					   sol.collider.tags.containsTag("RectangleCollider")){
						trace("lol");
						var rect1:Rectangle = (dyn.collider as RectangleCollider).rectangle;
						var rect2:Rectangle = (sol.collider as RectangleCollider).rectangle;
						
						// Calling collision() if they collided
						if(collisionTestRectangles(rect1, rect2)){
							collision(dyn, sol);
						}
					
					// We have one rectangle and one circle collider 
					} else if(dyn.collider.tags.containsTag("RectangleCollider") &&
							  sol.collider.tags.containsTag("CircleCollider") || 
							  dyn.collider.tags.containsTag("CircleCollider") &&
							  sol.collider.tags.containsTag("RectangleCollider")){
						
						var rect:Rectangle;
						var circle:Circle;
						
						if(dyn.collider.tags.containsTag("CircleCollider")){
							rect = (sol.collider as RectangleCollider).rectangle;
							circle = (dyn.collider as CircleCollider).circle;
						} else {
							rect = (dyn.collider as RectangleCollider).rectangle;
							circle = (sol.collider as CircleCollider).circle;
						}
						
						// Calling collision() if they collided
						if(collisionTestRectCirc(rect, circle)){
							collision(dyn, sol);
						}
						
					// We have two circle colliders
					} else if(dyn.collider.tags.containsTag("CircleCollider") &&
							  sol.collider.tags.containsTag("CircleCollider")){
						
						var circle1:Circle = (dyn.collider as CircleCollider).circle;
						var circle2:Circle = (sol.collider as CircleCollider).circle;
						
						// Calling collision() if they collided
						if(collisionTestCircles(circle1, circle2)){
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
		public function collisionTestRectangles(rect1:Rectangle, rect2:Rectangle):Boolean{
			
			
			return true;
		}

		/*
		*
		*/
		public function collisionTestRectCirc(rect:Rectangle, circle:Circle):Boolean{
			return true;
		}
		
		/*
		*
		*/
		public function collisionTestCircles(circle1:Circle, circle2:Circle):Boolean{
			return true;
		}
	}
	
}
