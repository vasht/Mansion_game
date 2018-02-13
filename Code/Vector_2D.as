package Code {
	
	import flash.geom.Point;
	
	/*
	* Your typical 2D vector  with an x and a y value.
	* Also some functions for manipulating vectors.
	*/
	public class Vector_2D extends Point {

		
		public function Vector_2D(_x:Number = 0, _y:Number = 0){
			super(_x, _y);
		}
		
		/*
		* Negates the vector
		*/
		public function negative():Vector_2D {
			var negVec:Vector_2D = new Vector_2D(-x, -y);
			return negVec;
		}
		
		/*
		* Returns the magnitude of the vector, that is |v|
		* if v is a vector.
		*/
		public function magnitude():Number{
			return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
		}
		
		/*
		* -Adds the x and y of a given vector to the x and y
		* of this vector in a new vector. Then returns it.
		*/
		public function addVector(vec:Vector_2D):Vector_2D{
			var newVec:Vector_2D = new Vector_2D(x + vec.x, y + vec.y);
			return newVec;
		}
		
		
		/*
		* Returns the dot product of the given two vectors
		*/
		public static function dotProduct(v1:Vector_2D, v2:Vector_2D):Number{
			return v1.x*v2.x + v1.y*v2.y;
		}
		
		/*
		*
		*/
		public static function distance(v1:Vector_2D, v2:Vector_2D):Number {
			return Point.distance((v1 as Point), (v2 as Point)§);
		}
		
		/*
		*
		* Rotates the given point around a given pivot, by the 
		* the given amount. The angle to rotate is given in radians.
		*
		* a is the vector from origin to the original point
		* b is the vector from origin to the final rotated point
		* 
		* See image rotate_point_around_pivot.png for details
		*
		* alfa2 is the angle that the point should be rotated around the pivot
		* in degrees
		*/
		public static function rotatePointAroundPivot(p:Vector_2D, pivot:Vector_2D, alfa2:Number):Point{
			
			// Getting rid of extra revolutions
			alfa2 = alfa2%360;
			
			// Angles over 180 should be negative
			// E.g. 270 = -90 degrees
			if(alfa2 > 180){
				alfa2 = -360 + alfa2;
			} else if(alfa2 < -180){
				alfa2 = 360 + alfa2;
			}
			
			// Converting alfa2 to radians instead of degrees
			var alfa2_rads:Number = alfa2 * (Math.PI/180);
			
			// a is the vector from the pivot to the point p
			var a:Vector_2D = new Vector_2D(p.x - pivot.x, p.y - pivot.y);
			// Magnitude of a
			var a_mag:Number = a.magnitude();
			
			// Calculating alfa1_rads, the angle between a and the x-axis
			// alfa1_rads = arccos(a.x/|a|)
			var alfa1_rads:Number = Math.acos(a.x / a_mag);
			
			// Checking if the angle should be negative
			if(a.y < 0){
				alfa1_rads = -alfa1_rads;
			}
			
			// trace("alfa1_rads: " + alfa1_rads);
			// alfa3_rads is the angle between b and the x-axis
			var alfa3_rads:Number = alfa1_rads + alfa2_rads;
			// trace(alfa1_rads);
			// Calculating vector b
			var b:Point = new Point(a_mag*Math.cos(alfa3_rads), 
									a_mag*Math.sin(alfa3_rads));
			
			// Calculating the final coordinates after rotation
			var p2:Point = new Point(pivot.x + b.x, pivot.y + b.y);
			return p2;
		}
		
		
		/*
		* Priints the x and y values of this vector to the output console
		*/
		public function traceVector(){
			trace("(x: " + x + ", y: " + y + ")");
		}
	}
	
}
