package Code{
	
	import Code.Controller;
	
	/*
	* The controller used to navigate menus.
	*/
	public class MenuController extends Controller{
		
		private static var theInstance:MenuController;
		
		/*
		* Since this class is supposed to be using the Singleton
		* pattern, this constructor should never be called outside
		* of the class.
		*/
		public function MenuController() {
			
		}
		
		/*
		*
		*/
		public static function getInstance():MenuController{
			if(theInstance == null){
				theInstance = new MenuController();
			}
			return theInstance;
		}

	}
	
}
