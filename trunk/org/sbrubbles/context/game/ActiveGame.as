package org.sbrubbles.context.game 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.gameoflife.Block;
	import org.sbrubbles.gameoflife.Grid;
	import org.sbrubbles.Main;
	import org.sbrubbles.systems.Input;
	
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
		
		// === context operations ===
		public override function start():void
		{
			super.start() // can't forget this call!
			
			addChild(owner.gameState.grid)
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true)
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
		
		public override function terminate():void
		{
			removeEventListener(MouseEvent.CLICK, mouseClicked)
			
			super.terminate()
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
		
		// === mouse clicked ===
		private function mouseClicked(e:MouseEvent):void
		{
			var grid:Grid = owner.gameState.grid
			var x: Number = Math.floor(this.mouseX / grid.gridScale)
			var y: Number = Math.floor(this.mouseY / grid.gridScale)
			
			addAcornAt(grid, x, y)
		}
		
		/**
		 * Adds an acorn to the grid at the given coordinates.
		 * An acorn is the pattern below, with . representing an empty cell and x a live one:
		 * .x.....
		 * ...x...
		 * xx..xxx
		 * 
		 * The given coordinates indicate the top left block.
		 * 
		 * @param grid the grid.
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 */
		private function addAcornAt(grid:Grid, x:Number, y:Number):void
		{
			grid.setBlocksAs(Block.LIVE,
				new Point(x, y + 2),
				new Point(x + 1, y),
				new Point(x + 1, y + 2),
				new Point(x + 3, y + 1),
				new Point(x + 4, y + 2),
				new Point(x + 5, y + 2),
				new Point(x + 6, y + 2))
		}
	}
}