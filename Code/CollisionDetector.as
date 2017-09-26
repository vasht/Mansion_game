package Code {
	
	/*
	*
	*/
	public class CollisionDetector{
		
		private static var theInstance:CollisionDetector;

		public function CollisionDetector() {
			
		}
		
		public static function getInstance():CollisionDetector{
			if(theInstance == null){
				theInstance = new CollisionDetector()
			}
			return theInstance;
		}

	}
	
}
