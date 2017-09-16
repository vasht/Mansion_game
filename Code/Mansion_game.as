package Code{
	
	/*
	* The actual game.
	*/
	public class Mansion_game {
		
		public var updater:Updater;
		
		public function Mansion_game() {
			
			updater = new Updater();
		}
		
		public function init(referenceObject:Object):void{
			
			updater.init(referenceObject);
		}

	}
	
}
