package Code {
	
	import flash.geom.Point;
	
	/*
	* Your typical 2D vector  with an x and a y value.
	* Also some functions for manipulating vectors.
	*
	* TODO:
	* 
	*/
	public class Vector_2D extends Point {

		
		public function Vector_2D(_x:Number, _y:Number){
			super(_x, _y);
		}
		
		/*
		* Negates the vector
		*/
		public function negative():Vector_2D {
			var negVec:Vector_2D = new Vector_2D(-x, -y);
			return negVec;
		}4
		
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

	}
	
}
