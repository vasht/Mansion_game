package Code {
	
	import Code.Rectangle;
	
	
	/*
	*
	*
	* TODO:
	* -Make this save the rectangle as two-point lines
	* 
	*/
	public class RectangleCollider extends Collider {
		
		public var rectangle:Rectangle;
		
		/*
		* Calls the super constructor and then adds the tag
		* RectangleCollider.
		* OBS! It's important that the super constructor is called
		* first, because it initializes the tags instance.
		*/
		public function RectangleCollider(_solidObject:SolidObject){
			
			super(_solidObject);
			tags.addTag("RectangleCollider");
		}
		
		/*
		* Checks if the has_moved boolean property has been set to true
		* and updates the collider if so.
		* It also calls the super.updateCollider, because it sets has_moved
		* to false.
		*/
		public override function updateCollider():void{
			
			if(has_moved){
				
				// Array of Vector_2D instances containing the coordinates of
				// the corners of the rectangle
				var corners:Array = new Array();
				
				corners[0] = (solidObject.getChildByName("collider_point_1_mc") as ColliderPoint).getGlobalCoord();
				corners[1] = (solidObject.getChildByName("collider_point_2_mc") as ColliderPoint).getGlobalCoord();
				corners[2] = (solidObject.getChildByName("collider_point_3_mc") as ColliderPoint).getGlobalCoord();
				corners[3] = (solidObject.getChildByName("collider_point_4_mc") as ColliderPoint).getGlobalCoord();
				
				// trace("corner 1: (" + corners[1].x + ", " + corners[1].y + ")");
				
				// Updating the min max x and y
				minX = (corners[0] as Vector_2D).x;
				minY = (corners[0] as Vector_2D).y;
				maxX = (corners[0] as Vector_2D).x;
				maxY = (corners[0] as Vector_2D).y;
				
				var corner:Vector_2D;
				for(var i=1; i<corners.length; i++){
					corner = corners[i] as Vector_2D;
					if(corner.x < minX){
						minX = corners[i].x;
					}
					if(corner.y < minY){
						minY = corners[i].y;
					}
					if(corner.x > maxX){
						maxX = corners[i].x;
					}
					if(corner.y > maxY){
						maxY = corners[i].y;
					}
				}
				
				rectangle = new Rectangle(corners[0], corners[1], corners[2], corners[3]);
				
				super.updateCollider();
			}
		}

	}
	
}
