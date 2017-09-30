package Code {
	
	import flash.display.MovieClip;
	
	/*
	*
	*/
	public class ColliderPoint extends MovieClip {

		public var point:Vector_2D;

		public function ColliderPoint() {
			point = new Vector_2D(x + width / 2, y + height / 2);
		}

	}
	
}
