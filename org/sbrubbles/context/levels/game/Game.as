package org.sbrubbles.context.levels.game 
{
	import flash.geom.Point;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.Main;
	import flash.ui.Keyboard;
	
	/**
	 * The context holding the game.
	 * 
	 * @author Humberto Anjos
	 */
	public class Game extends Context
	{
		private var _grid:Grid
		private var _hero:Hero
		
		public function Game(main:Main) 
		{
			super(main);
		}
		
		// === context operations ===
		public override function start():void
		{
			super.start() // can't forget this call!
			
			var grid = loadMap(getGrid())
			var hero = getHero()
			
			addChild(grid)
		}
		
		public override function update():void
		{
			// update the world
			_grid.update()
			
			// update the hero
			_hero.update()
			
			// check if the hero's still alive
			if (_hero.health <= 0) {
				trace("hero is dead!")
			}
			
			// apply input
			if (main.input.isPressed(Keyboard.W)) { // go up
				_hero.position.y = Math.max(0, _hero.position.y - 1)
			}
			if (main.input.isPressed(Keyboard.A)) { // go left
				_hero.position.x = Math.max(0, _hero.position.x - 1)
			}
			if (main.input.isPressed(Keyboard.S)) { // go down
				_hero.position.y = Math.min(_grid.gridHeight - 1, _hero.position.y + 1)
			}
			if (main.input.isPressed(Keyboard.D)) { // go right
				_hero.position.x = Math.min(_grid.gridWidth - 1, _hero.position.x + 1)
			}
		}
		
		// === maps ===
		private function loadMap(grid:Grid):Grid
		{
			grid.setBlocksAs(Block.START,
				new Point(0, 0), new Point(0, 1), new Point(0, 2), new Point(0, 3),
				new Point(1, 0), new Point(1, 1), new Point(1, 2), new Point(1, 3),
				new Point(2, 0), new Point(2, 1), new Point(2, 2), new Point(2, 3),
				new Point(3, 0), new Point(3, 1), new Point(3, 2), new Point(3, 3))
				
			grid.setBlocksAs(Block.END,
				new Point(grid.gridWidth - 4, grid.gridHeight - 4), new Point(grid.gridWidth - 4, grid.gridHeight - 3), new Point(grid.gridWidth - 4, grid.gridHeight - 2), new Point(grid.gridWidth - 4, grid.gridHeight - 1),
				new Point(grid.gridWidth - 3, grid.gridHeight - 4), new Point(grid.gridWidth - 3, grid.gridHeight - 3), new Point(grid.gridWidth - 3, grid.gridHeight - 2), new Point(grid.gridWidth - 3, grid.gridHeight - 1),
				new Point(grid.gridWidth - 2, grid.gridHeight - 4), new Point(grid.gridWidth - 2, grid.gridHeight - 3), new Point(grid.gridWidth - 2, grid.gridHeight - 2), new Point(grid.gridWidth - 2, grid.gridHeight - 1),
				new Point(grid.gridWidth - 1, grid.gridHeight - 4), new Point(grid.gridWidth - 1, grid.gridHeight - 3), new Point(grid.gridWidth - 1, grid.gridHeight - 2), new Point(grid.gridWidth - 1, grid.gridHeight - 1))
			
			return grid
		}
		
		private function getGrid():Grid 
		{ 
			if (_grid == null) {
				_grid = new Grid(main.stage)
			}
			
			return _grid 
		}
		
		private function getHero():Hero
		{
			if (_hero == null) {
				_hero = new Hero(new Point(0, 0), getGrid(), 8)
			}
			
			return _hero
		}
	}
}