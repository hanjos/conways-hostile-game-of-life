package org.sbrubbles.gameoflife 
{
	import flash.geom.Point;
	/**
	 * Represents a Game of Life pattern.
	 * 
	 * @author Humberto Anjos
	 */
	public class Pattern 
	{
		// === pre-built patterns ===
		/**
		 * The pattern below, with . representing an empty cell 
		 * and x a live one:
		 * .x.
		 * ..x
		 * xxx
		 */
		public static const GLIDER:Pattern 
			= new Pattern([
				new Point(1, 0),
				new Point(2, 1),
				new Point(0, 2),
				new Point(1, 2),
				new Point(2, 2)
			])
		
		/**
		 * The pattern below, with . representing an empty cell and x a live 
		 * one:
		 * .x.....
		 * ...x...
		 * xx..xxx
		 */
		public static const ACORN:Pattern 
			= new Pattern([
				new Point(0, 2),
				new Point(1, 0),
				new Point(1, 2),
				new Point(3, 1),
				new Point(4, 2),
				new Point(5, 2),
				new Point(6, 2)
			])
		
		/**
		 * The pattern below, with . representing an empty cell and x a live 
		 * one:
		 * ........................x...........
		 * ......................x.x...........
		 * ............xx......xx............xx
		 * ...........x...x....xx............xx
		 * xx........x.....x...xx..............
		 * xx........x...x.xx....x.x...........
		 * ..........x.....x.......x...........
		 * ...........x...x....................
		 * ............xx......................
		 */
		public static const GOSPER_GLIDER_GUN:Pattern 
			= new Pattern([
				// left 2x2 square
				new Point(0, 4),
				new Point(0, 5),
				new Point(1, 4),
				new Point(1, 5),
				
				// left trigger
				new Point(10, 4),
				new Point(10, 5),
				new Point(10, 6),
				new Point(11, 3),
				new Point(11, 7),
				new Point(12, 2),
				new Point(12, 8),
				new Point(13, 2),
				new Point(13, 8),
				new Point(14, 5),
				new Point(15, 3),
				new Point(15, 7),
				new Point(16, 4),
				new Point(16, 5),
				new Point(16, 6),
				new Point(17, 5),
				
				// right trigger
				new Point(20, 2),
				new Point(20, 3),
				new Point(20, 4),
				new Point(21, 2),
				new Point(21, 3),
				new Point(21, 4),
				new Point(22, 1),
				new Point(22, 5),
				new Point(24, 0),
				new Point(24, 1),
				new Point(24, 5),
				new Point(24, 6),
			
				// right 2x2 square
				new Point(34, 2),
				new Point(34, 3),
				new Point(35, 2),
				new Point(35, 3)
			])

		public static const SINGLE:Pattern = new Pattern([ new Point(0, 0) ])

		/**
		 * Returns a filled rectangle pattern, with the given dimensions.
		 * 
		 * @param width the width.
		 * @param height the height.
		 * @return a pattern with all points from (0, 0) to 
		 * (width-1, height-1) filled, forming a rectangle.
		 */
		public static function rectangle(width:int, height:int):Pattern
		{
			var args = []
			
			for (var i:int = 0; i < width; i++) {
				for (var j:int = 0; j < height; j++) {
					args.push(new Point(i, j))
				}
			}
			
			return new Pattern(args)
		}
		
		private var _offsets:Array
		private var _state:Number // Block state
		
		/**
		 * Creates a new pattern, holding the given points as relative 
		 * positions from the top-left corner.
		 * 
		 * @param offsets Points representing the offsets from the top-left 
		 * corner.
		 */
		public function Pattern(offsets:Array) 
		{
			_offsets = offsets
		}
		
		// === operations ===
		/**
		 * Adds a pattern to the grid at the given coordinates, which indicate 
		 * the top left block.
		 * 
		 * @param grid the grid.
		 * @param x the origin's x coordinate.
		 * @param y the origin's y coordinate.
		 * @return the points where the pattern was applied.
		 */
		public function applyOn(state:Number, grid:Grid, x:Number, y:Number):Array
		{
			var args = startingFrom(x, y)
			var result:Array = args.concat() // making a shallow copy to return
			
			args.unshift(state) // putting the state first
			
			grid.setBlocksAs.apply(grid, args) // needed because of the varargs
			
			return result
		}
		
		/**
		 * Returns the positions to be occupied by this pattern if applied from the given origin.
		 * 
		 * @param x the origin's x coordinate.
		 * @param y the origin's y coordinate.
		 * @return the positions to be occupied by this pattern if applied from the given origin.
		 */
		public function startingFrom(x:Number, y:Number):Array
		{
			var origin:Point = new Point(x, y)
			return offsets.map(function(item:Point, index:int, array:Array) { 
				return item.add(origin) 
			})
		}
		
		// === properties ===
		public function get offsets():Array { return _offsets }
	}

}