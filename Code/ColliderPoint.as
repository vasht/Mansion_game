package Code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/*
	*
	*/
	public class ColliderPoint extends MovieClip {

		public function ColliderPoint() {
			
		}
		
		public function getGlobalCoord():Vector_2D{
			
			// Calculating the center of this point
			var localPoint:Point = new Point(x + width / 2, y + height / 2);
			var globalPoint:Point = this.localToGlobal(localPoint);
			var globalVec2D:Vector_2D = new Vector_2D(globalPoint.x, globalPoint.y);
			
			// Returning the coordinates on the stage of the center of this point
			return globalVec2D;
		}

	}
	
}
