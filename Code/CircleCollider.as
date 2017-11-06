package Code {
	
	import flash.geom.Point;
	
	/*
	*
	* TODO
	* -Make a new circle in the constructor, using the reference to
	* the solid object this belongs to, to get the collider_point_mc
	* instance, using that to get the center
	* -Make the updateCollider function update the min and max x and y properties
	*/
	public class CircleCollider extends Collider {
		
		public var circle:Circle;
		
		public function CircleCollider(_solidObject:SolidObject) {
			
			tags.addTag("CircleCollider");
			
			super(_solidObject);
		}
		
		/*
		*
		*/
		public override function updateCollider():void{
			
			if(has_moved){
				
				var center1:Point = (solidObject.getChildByName("collider_point_mc") 
										 as ColliderPoint).getGlobalCoord();
				var radius:Number = solidObject.width / 2;
				
				circle = new Circle(center1, radius);
			}
			
			super.updateCollider();
		}

	}
	
}
