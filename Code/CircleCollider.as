package Code {
	
	/*
	*
	* TODO
	* -Make a new circle in the constructor, using the reference to
	* the solid object this belongs to, to get the collider_point_mc
	* instance, using that to get the center
	*/
	public class CircleCollider extends Collider {
		
		public var circle:Circle;
		
		public function CircleCollider() {
			
			tags.addTag("CircleCollider");
		}
		
		/*
		*
		*/
		public override function updateCollider():void{
			
			if(has_moved){
				
				var center1:Vector_2D = solidObject.collider_point_mc.getGlobalCoord();
				var radius:Number = solidObject.width / 2;
				
				circle = new Circle(center1, radius);
			}
			
			super.updateCollider();
		}

	}
	
}
