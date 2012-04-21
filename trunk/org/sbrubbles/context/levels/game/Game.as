package org.sbrubbles.context.levels.game 
{
	import flash.geom.Point;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.Main;
	
	/**
	 * The context holding the game.
	 * 
	 * @author Humberto Anjos
	 */
	public class Game extends Context
	{
		private var _grid:Grid
		
		public function Game(main:Main) 
		{
			super(main);
		}
		
		// === context operations ===
		public override function start():void
		{
			super.start() // can't forget this call!
			
			var grid = loadMap(getGrid())
			
			addChild(grid)
		}
		
		public override function update():void
		{
			_grid.tick()
		}
		
		// === maps ===
		private function loadMap(grid:Grid):Grid
		{
			grid.setBlocksAs(Block.START,
				new Point(0, 0), new Point(0, 1), new Point(0, 2),
				new Point(1, 0), new Point(1, 1), new Point(1, 2),
				new Point(2, 0), new Point(2, 1), new Point(2, 2))
			
			return grid
		}
		
		private function getGrid():Grid 
		{ 
			if (_grid == null) {
				_grid = new Grid(main.stage)
			}
			
			return _grid 
		}
	}
}