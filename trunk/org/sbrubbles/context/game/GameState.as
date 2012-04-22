package org.sbrubbles.context.game 
{
	import flash.display.Stage;
	import flash.geom.Point;
	
	/**
	 * Holds game state shared between contexts.
	 * 
	 * @author Humberto Anjos
	 */
	public class GameState
	{
		private var _grid:Grid
		private var _hero:Hero
		private var _stage:Stage
		
		public function GameState(stage:Stage)
		{
			_stage = stage
			
			reset()
		}
		
		/**
		 * Resets this object's fields to their original values.
		 */
		public function reset()
		{
			_grid = loadMap(new Grid(_stage))
			_hero = new Hero(new Point(0, 0), grid, 8)
		}
		
		private function loadMap(grid:Grid):Grid
		{
			grid.alpha = 1
			
			// the starting position
			grid.setBlocksAs(Block.START,
				new Point(0, 0), new Point(0, 1), new Point(0, 2), new Point(0, 3),
				new Point(1, 0), new Point(1, 1), new Point(1, 2), new Point(1, 3),
				new Point(2, 0), new Point(2, 1), new Point(2, 2), new Point(2, 3),
				new Point(3, 0), new Point(3, 1), new Point(3, 2), new Point(3, 3))
			
			// the end position
			grid.setBlocksAs(Block.END,
				new Point(grid.gridWidth - 4, grid.gridHeight - 4), new Point(grid.gridWidth - 4, grid.gridHeight - 3), new Point(grid.gridWidth - 4, grid.gridHeight - 2), new Point(grid.gridWidth - 4, grid.gridHeight - 1),
				new Point(grid.gridWidth - 3, grid.gridHeight - 4), new Point(grid.gridWidth - 3, grid.gridHeight - 3), new Point(grid.gridWidth - 3, grid.gridHeight - 2), new Point(grid.gridWidth - 3, grid.gridHeight - 1),
				new Point(grid.gridWidth - 2, grid.gridHeight - 4), new Point(grid.gridWidth - 2, grid.gridHeight - 3), new Point(grid.gridWidth - 2, grid.gridHeight - 2), new Point(grid.gridWidth - 2, grid.gridHeight - 1),
				new Point(grid.gridWidth - 1, grid.gridHeight - 4), new Point(grid.gridWidth - 1, grid.gridHeight - 3), new Point(grid.gridWidth - 1, grid.gridHeight - 2), new Point(grid.gridWidth - 1, grid.gridHeight - 1))
			
			return grid
		}
		
		// === properties ===
		public function get grid():Grid { return _grid }
		public function get hero():Hero { return _hero }
	}
}