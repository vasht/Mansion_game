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
			trace(solidObject);
			/*
			if(has_moved){
				
				var corners:Array = new Array();
				
				corners[0] = solidObject.collider_point_1_mc.getGlobalCoord();
				corners[1] = solidObject.collider_point_2_mc.getGlobalCoord();
				corners[2] = solidObject.collider_point_3_mc.getGlobalCoord();
				corners[3] = solidObject.collider_point_4_mc.getGlobalCoord();
				trace(corners[0]);
				// Updating the min max x and y
				minX = (corners[0] as Vector_2D).x;
				minY = -(corners[0] as Vector_2D).y;
				maxX = (corners[0] as Vector_2D).x;
				maxY = -(corners[0] as Vector_2D).y;
				
				for(var i=1; i<corners.length; i++){
					if((corners[i] as Vector_2D).x < minX){
						minX = corners[i];
					}
					if((corners[i] as Vector_2D).y < minY){
						minY = corners[i];
					}
					if((corners[i] as Vector_2D).x > maxX){
						maxX = corners[i];
					}
					if((corners[i] as Vector_2D).y > maxY){
						maxY = corners[i];
					}
				}
				
				rectangle = new Rectangle(corners[0], corners[1], corners[2], corners[3]);
				
				super.updateCollider();
			}*/
		}

	}
	
}
