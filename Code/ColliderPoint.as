package Code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/*
	*
	*/
	public class ColliderPoint extends MovieClip {

		public function ColliderPoint() {
			
		}
		
		public function getGlobalCoord():Point{
			
			// Calculating the center of this point
			var localPoint:Point = new Point(x + width / 2, y + height / 2);
			// Returning the coordinates on the stage of the center of this point

			return this.localToGlobal(localPoint);
		}

	}
	
}
