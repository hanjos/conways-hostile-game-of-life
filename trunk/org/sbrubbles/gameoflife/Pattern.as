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
			= new Pattern(Block.LIVE, 
				new Point(1, 0),
				new Point(2, 1),
				new Point(0, 2),
				new Point(1, 2),
				new Point(2, 2))
		
		/**
		 * The pattern below, with . representing an empty cell and x a live 
		 * one:
		 * .x.....
		 * ...x...
		 * xx..xxx
		 */
		public static const ACORN:Pattern 
			= new Pattern(Block.LIVE,
				new Point(0, 2),
				new Point(1, 0),
				new Point(1, 2),
				new Point(3, 1),
				new Point(4, 2),
				new Point(5, 2),
				new Point(6, 2))
		
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
			= new Pattern(Block.LIVE,
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
				new Point(35, 3))

		public static const END:Pattern = new Pattern(Block.END, new Point(0, 0))

		private var _offsets:Array
		private var _state:Number // Block state
		
		/**
		 * @param state the state to apply to the points of the pattern.
		 * @param offsets Points representing offsets from the top-left corner.
		 */
		public function Pattern(state:Number, ...offsets) 
		{
			_state = state
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
		 */
		public function applyOn(grid:Grid, x:Number, y:Number)
		{
			var p = new Point(x, y)
			var args = offsets.map(function(item:Point, index:int, array:Array) { return item.add(p) }) // adding the offsets to the origin
			args.unshift(state) // putting the state first
			
			grid.setBlocksAs.apply(grid, args) // needed because of the varargs
		}
		
		// === properties ===
		private function get state():Number { return _state }
		private function get offsets():Array { return _offsets }
	}

}