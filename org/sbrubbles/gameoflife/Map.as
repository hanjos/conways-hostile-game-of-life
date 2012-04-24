package org.sbrubbles.gameoflife 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * A pre-set grid configuration.
	 * 
	 * @author Humberto Anjos
	 */
	public class Map 
	{
		private var _width:int
		private var _height:int
		private var _states:Array // length width * height
		
		private var _start:Point
		
		public function Map(width:int, height:int) 
		{
			_width = width
			_height = height
			_start = new Point(0, 0)
			_states = []
			
			clear()
		}
		
		public function clear():void
		{
			_states.splice(0, _states.length) // clears the previous array
			
			for (var i:int = 0; i < width * height; i++) {
				_states.push(Block.DEAD)
			}
		}
		
		/**
		 * Clears the given grid and applies itself on it.
		 * 
		 * @param grid the grid to apply.
		 */
		public function applyOn(grid:Grid):void
		{
			if (grid == null) {
				throw new ArgumentError("the given grid cannot be null")
			}	
			
			// clear the grid
			grid.clearMap()
			
			// apply the positions on the grid
			for (var x:int = 0; x < width; x++) {
				for (var y:int = 0; y < height; y++) {
					grid.setBlocksAs(at(x, y), new Point(x, y))
				}
			}
		}
		
		/**
		 * @return the state of the given position.
		 */
		public function at(x:Number, y:Number):Number
		{
			return states[y * width + x]
		}
		
		/**
		 * Sets the given positions to the given state.
		 * 
		 * @return this instance.
		 */
		public function setAt(state:Number, ...positions):Map
		{
			for each(var p:Point in positions) { 
				states[p.y * width + p.x] = state
			}
			
			return this
		}
		
		// === properties ===
		public function get width():int { return _width }
		public function get height():int { return _height }
		public function get states():Array { return _states }
		public function get start():Point { return _start }
		public function set start(start:Point):void { _start = start }
	}

}