package {
	import flash.display.MovieClip;
	
	public class Stage_reference_test extends MovieClip{

		public function Stage_reference_test() {
			
		}
		
		public function traceParent(){
			trace(this.parent);
			trace(this.stage);
			trace(this.parent.stage);
			trace(this.stage == this.parent.stage);
		}

	}
	
}
