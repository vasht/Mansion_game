package Code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/*
	*
	*/
	public class ColliderPoint extends MovieClip {

		public function ColliderPoint(){
			
		}
		
		/*
		* Returns the global coordinate of this collider point on the stage.
		* It negates the y-value because up is negative and down is positive in
		* actionscript.
		*/
		public function getGlobalCoord():Vector_2D{
			
			// Calculating the center of this point
			var localPoint:Point = new Point(x + width / 2, y + height / 2);
			// trace(this.name + ": " + "(" + localPoint.x + ", " + localPoint.y + ")");
			var globalVec2D:Vector_2D = new Vector_2D(this.parent.x + localPoint.x, 
													  this.parent.y + localPoint.y);
			// trace(this.name + ": " + "(" + globalPoint.x + ", " + globalPoint.y + ")");
			
			// Returning the coordinates on the stage of the center of this point
			return globalVec2D;
		}

	}
	
}
