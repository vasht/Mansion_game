package Code{
	
	import flash.events.Event;
	
	/*
	* The updater has an update function that is called once on
	* each frame. This function calls the update functions in
	* other classes that need to have something done on each
	* frame.
	*/
	public class Updater {
		
		public var controller:Controller;
		
		public function Updater() {
			
		}
		
		/*
		* Gives the updater a reference to the stage.
		*/
		public function init(referenceObject:Object):void{
			referenceObject.mainStage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		/*
		* This gets called on each frame.
		* It needs the event argument, because listener functions
		* have to take one parameter of type Event, otherwise
		* there's an error.
		*/
		public function update(event:Event = null){
			
		}

	}
	
}
