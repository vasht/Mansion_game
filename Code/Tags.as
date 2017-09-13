package Code {
	
	/*
	* A Tags instance contains a list of strings, the tags.
	* Tags can be added, removed and checked for.
	*/
	public class Tags {

		private var tags:Array;

		public function Tags() {
			tags = new Array();
		}
		
		// Adds a tag to the list of tagss
		public function addTag(tag:String):void{
			tags.push(tag);
		}
		
		/*
		* Checks if the list of tags contains a given tag.
		* Returns true if the tag is found.
		* Returns false if the tag is not found.
		*/
		public function containsTag(tag:String):Boolean{
			
			for(var i=0; i<tags.length; i++){
				if(tags[i].toString() == tag){
					return true;
				}
			}
			return false;
		}
		
		/*
		// Add this if needed
		public function removeTag(tag:String):Void{
			
		}
		*/

	}
	
}
