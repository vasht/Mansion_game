package Code {
	
	import flash.geom.Point;
	
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
				minX = (corners[0] as Point).x;
				minY = (corners[0] as Point).y;
				maxX = (corners[0] as Point).x;
				maxY = (corners[0] as Point).y;
				
				var corner:Point;
				for(var i=1; i<corners.length; i++){
					corner = corners[i] as Point;
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
