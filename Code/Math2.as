package Code {
	
	/*
	* This is a static class, with useful math functions.
	* It extends the default Math library.
	*/
	public class Math2 {

		
		
		/*
		* Solves a quadratic equation, using the quadratic formula
		* x = (-b +/-sqrt(b^2 - 4ac)) / 2a
		* Takes in the parameters a, b and c from the quadratic equation
		* ax^2 + bx + c = 0
		*
		* Returns an array with as many elements as there are solutions (0, 1 or 2)
		*/
		public static function solveQuadraticEquation(a:Number, b:Number, c:Number):Array {
			var solutions:Array = new Array();
			
			// Determining the amound of solutions
			
			// The discriminant
			var discriminant:Number = Math.pow(b, 2) - 4*a*c;
			
			if(discriminant < 0){
				
				// No solutions
				return solutions;
			} else if(discriminant == 0){
				
				// One solution
				var solution:Number = -b / (2*a);
				solutions.push(solution);
			} else {
				
				// Two solutions
				var solution1:Number = (-b + Math.sqrt(discriminant)) / 2*a;
				var solution2:Number = (-b - Math.sqrt(discriminant)) / 2*a;
				
				solutions.push(solution1);
				solutions.push(solution2);
			}
			
			return solutions;
		} // End of solveQuadraticEquation

	}
	
}
