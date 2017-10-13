package Code {
	
	import Code.Rectangle;
	
	
	/*
	*
	*
	* TODO
	* 
	*/
	public class RectangleCollider extends Collider {
		
		public var rectangle:Rectangle;
		
		public function RectangleCollider(_solidObject:SolidObject){
			
			super(_solidObject);
			tags.addTag("RectangleCollider");
		}
		
		/*
		*
		*/
		public override function updateCollider():void{
			// trace(solidObject.getChildByName("corner_point_1_mc"));
			
			
			if(has_moved){
				
				var corners:Array = new Array();
				
				corners[0] = (solidObject.getChildByName("collider_point_1_mc") as ColliderPoint).getGlobalCoord();
				corners[1] = (solidObject.getChildByName("collider_point_2_mc") as ColliderPoint).getGlobalCoord();
				corners[2] = (solidObject.getChildByName("collider_point_3_mc") as ColliderPoint).getGlobalCoord();
				corners[3] = (solidObject.getChildByName("collider_point_4_mc") as ColliderPoint).getGlobalCoord();
				
				// trace("(" + (corners[0] as ColliderPoint).x + ", " + (corners[0] as ColliderPoint).y + ")");
				
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
