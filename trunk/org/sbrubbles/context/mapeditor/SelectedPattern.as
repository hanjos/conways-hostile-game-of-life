package org.sbrubbles.context.mapeditor 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.sbrubbles.gameoflife.Grid;
	import org.sbrubbles.gameoflife.Pattern;
	/**
	 * Represents the selected pattern.
	 * 
	 * @author Humberto Anjos
	 */
	public class SelectedPattern 
	{
		private static const SHADOW_COLOR:Number = 0xFFC0C0C0
		private static const TRANSPARENT_COLOR:Number = 0x00000000
		
		private var _grid:Grid
		private var _position:Point
		private var _pattern:Pattern
		
		public function SelectedPattern(grid:Grid) 
		{
			_grid = grid
		}
		
		public function update():void
		{
			if (pattern == null) {
				return // no pattern selected, nothing to do
			}
			
			// draw on the canvas, not the underlying map
			var canvas:BitmapData = _grid.canvas 

			// the grid only erases it on update, can't rely on it being 
			// called there
			canvas.fillRect(canvas.rect, TRANSPARENT_COLOR)
			
			// get the points to shadow
			var addOffset = function(item:Point, index:int, array:Array) { 
				return item.add(position) 
			}
			
			var points = pattern.offsets.map(addOffset)
			
			// draw them
			for each(var pp in points) {
				canvas.setPixel32(pp.x, pp.y, SHADOW_COLOR)
			}
		}
		
		// === properties ===
		public function get position():Point { return _position }
		public function set position(position:Point) { _position = position }
		
		public function get pattern():Pattern { return _pattern }
		public function set pattern(pattern:Pattern) { _pattern = pattern }
	}

}