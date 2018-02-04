package Code {
	
	import Code.Geometry.CircleCollider;
	
	/*
	* This is a circular level object. It sets the collider
	* to be of the correct type.
	*/
	public class CircleObstacle extends LevelObject {
		
		/*
		* The constructor initializes the collider with the 
		* appropriate type.
		*/
		public function CircleObstacle(){
			
			collider = new CircleCollider(this);
		}

	}
	
}
