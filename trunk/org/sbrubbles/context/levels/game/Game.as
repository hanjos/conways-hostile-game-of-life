package org.sbrubbles.context.levels.game 
{
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
		
		public override function start():void
		{
			super.start() // can't forget this call!
			
			var grid = getGrid()
			
			addChild(grid)
		}
		
		public override function update():void
		{
			_grid.tick()
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