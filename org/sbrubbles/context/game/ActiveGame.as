package org.sbrubbles.context.game 
{
	import flash.geom.Point;
	import org.sbrubbles.context.Context;
	import flash.ui.Keyboard;
	import org.sbrubbles.Main;
	
	/**
	 * A game context representing the running game.
	 * 
	 * @author Humberto Anjos
	 * @see Game
	 */
	public class ActiveGame extends Context
	{
		public function ActiveGame(main:Main) 
		{
			super(main);
		}
		
		public override function start():void
		{
			super.start() // can't forget this call!
			
			addChild(owner.gameState.grid)
		}
		
		public override function update():void
		{
			owner.gameState.grid.update()
			
			// update the hero
			owner.gameState.hero.update()
			
			// check if the hero's still alive
			if (owner.gameState.hero.health <= 0) {
				owner.contexts.goTo(Main.DEAD_HERO)
			}
			
			// check if the hero has achieved his objective
			var isEndArea:Function = function (item:Block, index:int, vector:Vector.<Block>) { return item != null && item.state == Block.END } 
			if (owner.gameState.hero.getBlocksBelow().every(isEndArea)) {
				owner.contexts.goTo(Main.WIN)
			}
			
			// apply input
			checkInput();
		}
		
		private function checkInput():void 
		{
			var grid = owner.gameState.grid
			var hero = owner.gameState.hero
			
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
				owner.gameState.reset()
				owner.contexts.goTo(Main.MAIN_MENU)
			}
		}
	}

}