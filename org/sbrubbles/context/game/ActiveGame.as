package org.sbrubbles.context.game 
{
	import flash.ui.Keyboard;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.context.Contexts;
	import org.sbrubbles.Main;
	import org.sbrubbles.Input;
	
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
			super.update()
			
			var grid:Grid = owner.gameState.grid
			var hero:Hero = owner.gameState.hero
			
			// update the grid
			grid.update()
			
			// update the hero
			hero.update()
			
			// check for collisions
			var blocksBelow:Vector.<Block> = hero.getBlocksBelow()
			var isLive:Function = function (item:Block, index:int, vector:Vector.<Block>) { 
				return item != null && item.state == Block.LIVE 
			} 
			
			if (blocksBelow.some(isLive)) { // hit detected!
				hero.heal(-1)
			}
			
			// check if the hero's still alive
			if (hero.health <= 0) {
				Contexts.goTo(Main.DEAD_HERO)
				return
			}
			
			// check if the hero has achieved his objective
			var isEndArea:Function = function (item:Block, index:int, vector:Vector.<Block>) { 
				return item != null && item.state == Block.END 
			} 
			
			if (blocksBelow.some(isEndArea)) { // win!
				Contexts.goTo(Main.WIN)
				return
			}
			
			// apply input
			checkInput();
		}
		
		private function checkInput():void 
		{
			var grid:Grid = owner.gameState.grid
			var hero:Hero = owner.gameState.hero
			
			if (Input.isPressed(Keyboard.W)) { // go up
				hero.position.y = Math.max(0, hero.position.y - 1)
			}
			if (Input.isPressed(Keyboard.A)) { // go left
				hero.position.x = Math.max(0, hero.position.x - 1)
			}
			if (Input.isPressed(Keyboard.S)) { // go down
				hero.position.y = Math.min(grid.gridHeight - hero.height, hero.position.y + 1)
			}
			if (Input.isPressed(Keyboard.D)) { // go right
				hero.position.x = Math.min(grid.gridWidth - hero.width, hero.position.x + 1)
			}
			if (Input.isPressed(Keyboard.Q)) { // go back to the main menu
				owner.gameState.reset()
				Contexts.goTo(Main.MAIN_MENU)
			}
		}
	}

}