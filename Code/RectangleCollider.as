package Code {
	
	import Code.Rectangle;
	
	
	/*
	*
	*
	* TODO
	* -Get the corners from the solidObject reference
	* in the updateCollider function
	* -Make a new rectangle out of the aforementioned corners
	*/
	public class RectangleCollider extends Collider {
		
		public var rectangle:Rectangle;
		
		public function RectangleCollider(){
			tags.addTag("RectangleCollider");
		}
		
		/*
		*
		*/
		public override function updateCollider():void{
			
			if(has_moved){
				
				var corner1:Vector_2D = solidObject.collider_point_1_mc.getGlobalCoord();
				var corner2:Vector_2D = solidObject.collider_point_2_mc.getGlobalCoord();
				var corner3:Vector_2D = solidObject.collider_point_3_mc.getGlobalCoord();
				var corner4:Vector_2D = solidObject.collider_point_4_mc.getGlobalCoord();
				
				rectangle = new Rectangle(corner1, corner2, corner3, corner4);
			}
			
			super.updateCollider();
		}

	}
	
}
