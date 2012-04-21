package org.sbrubbles.context.levels.game.states 
{
	import flash.geom.Point;
	import org.sbrubbles.context.Context;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.levels.game.Block;
	import org.sbrubbles.context.levels.game.Game;
	import org.sbrubbles.context.levels.game.Grid;
	
	/**
	 * A Game subcontext representing the running game.
	 * 
	 * @author Humberto Anjos
	 * @see Game
	 */
	public class Playing extends Context
	{
		public function Playing(game:Game) 
		{
			super(game);
		}
		
		public override function start():void
		{
			super.start() // can't forget this call!
			
			// reset everything
			owner.reset()
			
			var grid = loadMap(owner.grid)
			
			addChild(grid)
			
			// reset the hero
			var hero = owner.hero
		}
		
		public override function update():void
		{
			owner.grid.update()
			
			// update the hero
			owner.hero.update()
			
			// check if the hero's still alive
			if (owner.hero.health <= 0) {
				trace("hero is dead!")
				owner.contexts.activate(Game.DEAD_HERO)
			}
			
			// apply input
			checkInput();
		}
		
		private function checkInput():void 
		{
			var grid = owner.grid
			var hero = owner.hero
			
			if (owner.input.isPressed(Keyboard.W)) { // go up
				hero.position.y = Math.max(0, hero.position.y - 1)
			}
			if (owner.input.isPressed(Keyboard.A)) { // go left
				hero.position.x = Math.max(0, hero.position.x - 1)
			}
			if (owner.input.isPressed(Keyboard.S)) { // go down
				hero.position.y = Math.min(grid.gridHeight - 1, hero.position.y + 1)
			}
			if (owner.input.isPressed(Keyboard.D)) { // go right
				hero.position.x = Math.min(grid.gridWidth - 1, hero.position.x + 1)
			}
		}
		
		// === maps ===
		private function loadMap(grid:Grid):Grid
		{
			grid.alpha = 1
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
	}

}