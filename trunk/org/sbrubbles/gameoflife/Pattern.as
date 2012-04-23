package org.sbrubbles.gameoflife 
{
	import flash.geom.Point;
	/**
	 * Stores a Game of Life pattern.
	 * 
	 * @author Humberto Anjos
	 */
	public class Pattern 
	{
		private var _offsets:Array
		private var _state:Number // Block state
		
		public function Pattern(state:Number, ...offsets) 
		{
			_state = state
			_offsets = offsets
		}
		
		// === operations ===
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