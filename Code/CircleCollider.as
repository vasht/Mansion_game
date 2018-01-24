package Code {
	
	import flash.geom.Point;
	
	/*
	*
	* TODO
	* -Make a new circle in the constructor, using the reference to
	* the solid object this belongs to, to get the collider_point_mc
	* instance, using that to get the center
	* -Make the updateCollider function update the min and max x and y properties
	*/
	public class CircleCollider extends Collider {
		
		public var circle:Circle;
		
		/*
		* Calls the super constructor and then adds the tag
		* RectangleCollider.
		* OBS! It's important that the super constructor is called
		* first, because it initializes the tags instance.
		*/
		public function CircleCollider(_solidObject:SolidObject) {
			
			super(_solidObject);
			tags.addTag("CircleCollider");
		}
		
		/*
		* Updates the collider to have the correct info from the
		* movie clip. 
		* It gets the center coordinates from the collider point in
		* the movie clip.
		* Finally it calls super.updateCollider(), because it sets 
		* has_moved to false
		*/
		public override function updateCollider():void {
			
			if(has_moved){
				
				var center:Vector_2D = (solidObject.getChildByName("collider_point_mc") 
										 as ColliderPoint).getGlobalCoord();
				var radius:Number = solidObject.width / 2;
				
				// Updating the min max x and y
				minX = center.x - radius;
				minY = center.y - radius;
				maxX = center.x + radius;
				maxY = center.y + radius;
				
				circle = new Circle(center, radius);
			}
			
			super.updateCollider();
		}

	}
	
}
