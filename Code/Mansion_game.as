package Code{
	
	import Code.Controller;
	
	/*
	* The actual game.
	*/
	public class Mansion_game {
		
		public var updater:Updater;
		public var controller:Controller;
		
		public function Mansion_game() {
			
			updater = new Updater();
			controller = new Controller();
		}
		
		public function init(referenceObject:Object):void{
			
			updater.init(referenceObject);
			
		}

	}
	
}
