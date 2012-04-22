package org.sbrubbles.context.levels.game 
{
	import flash.geom.Point;
	import org.sbrubbles.context.Context;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.levels.game.Block;
	import org.sbrubbles.context.levels.game.GameState;
	import org.sbrubbles.context.levels.game.Grid;
	import org.sbrubbles.Main;
	
	/**
	 * A game context representing the running game.
	 * 
	 * @author Humberto Anjos
	 * @see Game
	 */
	public class ActiveGame extends GameContext
	{
		public function ActiveGame(main:Main, gameState:GameState) 
		{
			super(main, gameState);
		}
		
		public override function start():void
		{
			super.start() // can't forget this call!
			
			addChild(gameState.grid)
		}
		
		public override function update():void
		{
			gameState.grid.update()
			
			// update the hero
			gameState.hero.update()
			
			// check if the hero's still alive
			if (gameState.hero.health <= 0) {
				owner.contexts.activate(Main.DEAD_HERO)
			}
			
			// check if the hero has achieved his objective
			var isEndArea:Function = function (item:Block, index:int, vector:Vector.<Block>) { return item != null && item.state == Block.END } 
			if (gameState.hero.getBlocksBelow().every(isEndArea)) {
				owner.contexts.activate(Main.WIN)
			}
			
			// apply input
			checkInput();
		}
		
		private function checkInput():void 
		{
			var grid = gameState.grid
			var hero = gameState.hero
			
			if (owner.input.isPressed(Keyboard.W)) { // go up
				hero.position.y = Math.max(0, hero.position.y - 1)
			}
			if (owner.input.isPressed(Keyboard.A)) { // go left
				hero.position.x = Math.max(0, hero.position.x - 1)
			}
			if (owner.input.isPressed(Keyboard.S)) { // go down
				hero.position.y = Math.min(grid.gridHeight - hero.height, hero.position.y + 1)
			}
			if (owner.input.isPressed(Keyboard.D)) { // go right
				hero.position.x = Math.min(grid.gridWidth - hero.width, hero.position.x + 1)
			}
			if (owner.input.isPressed(Keyboard.Q)) { // go back to the main menu
				gameState.reset()
				owner.contexts.activate(Main.MAIN_MENU)
			}
		}
	}

}