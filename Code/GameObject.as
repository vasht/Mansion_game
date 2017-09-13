package Code{
	
	import flash.display.MovieClip;
	
	import Code.Tags;
	
	/*
	* Yea I know, I got the name from Unity, not very creative.
	* A GameObject is actually just a movie clip, but with tags.
	*/
	public class GameObject extends MovieClip{

		public var tags:Tags;

		public function GameObject() {
			tags = new Tags();
		}

	}
	
}
