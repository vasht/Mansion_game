﻿package Code {
	
	/*
	*
	*/
	public class RectangleObstacle extends LevelObject {
		
		
		/*
		* The constructor initializes the collider with the 
		* appropriate type.
		*/
		public function RectangleObstacle(){
			
			collider = new RectangleCollider(this);
		}

	}
	
}
