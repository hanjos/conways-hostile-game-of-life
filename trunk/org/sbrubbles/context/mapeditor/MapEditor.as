package org.sbrubbles.context.mapeditor 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.context.Contexts;
	import org.sbrubbles.gameoflife.Block;
	import org.sbrubbles.gameoflife.Grid;
	import org.sbrubbles.Input;
	import org.sbrubbles.Main;
	
	/**
	 * Provides a context for map creation.
	 * 
	 * @author Humberto Anjos
	 */
	public class MapEditor extends Context
	{
		private var _grid:Grid
		private var _running:Boolean
		private var _selectedPattern:String
		private var _patterns:Dictionary // <String, (Grid, Number, Number) -> void>
		
		public function MapEditor(owner:Main) 
		{
			super(owner)
			
			_selectedPattern = null
			_patterns = new Dictionary()
			_patterns.glider = addGliderAt
			_patterns.acorn = addAcornAt
			_patterns.gosperGliderGun = addGosperGliderGunAt
			_patterns.end = addEndingAt
		}
		
		public override function start():void
		{
			super.start()
			
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true)
			
			_grid = new Grid()
			_running = false
			
			addChild(_grid)
		}
		
		public override function update():void
		{
			super.update()
			
			if (_running) {
				_grid.update()
			}
			
			checkInput()
		}
		
		public override function terminate():void
		{
			removeEventListener(MouseEvent.CLICK, mouseClicked)
			
			super.terminate()
		}
		
		private function checkInput()
		{
			if (Input.isPressed(Keyboard.G)) { // glider
				_selectedPattern = "glider"
			} else if (Input.isPressed(Keyboard.A)) { // acorn
				_selectedPattern = "acorn"
			} else if (Input.isPressed(Keyboard.O)) { // Gosper's glider gun
				_selectedPattern = "gosperGliderGun"
			} else if (Input.isPressed(Keyboard.E)) { // ending
				_selectedPattern = "end"
			} else if (Input.isPressed(Keyboard.U)) { // unselect a pattern
				_selectedPattern = null
			} else if (Input.isPressed(Keyboard.C)) { // clear the grid and stop running
				_grid.clear()
				_running = false
			} else if (Input.isPressed(Keyboard.SPACE)) { // start/stop the running
				_running = !_running
			} else if (Input.isPressed(Keyboard.Q)) { // return to the main menu
				Contexts.goTo(Main.MAIN_MENU)
			}
		}
		
		private function mouseClicked(e:MouseEvent):void 
		{
			var x: Number = Math.floor(this.mouseX / _grid.gridScale)
			var y: Number = Math.floor(this.mouseY / _grid.gridScale)
			
			if (_selectedPattern == null) { // toggle the state of the underlying block
				_grid.getBlockAt(x, y).toggleState()
			} else { // apply the selected pattern
				_patterns[_selectedPattern](_grid, x, y)
			}
		}
		
		// === patterns ===
		/**
		 * Adds a glider to the grid at the given coordinates. 
		 * A glider is the pattern below, with . representing an empty cell 
		 * and x a live one:
		 * .x.
		 * ..x
		 * xxx
		 * 
		 * The given coordinates indicate the top left block.
		 * 
		 * @param grid the grid.
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 */
		private function addGliderAt(grid:Grid, x:Number, y:Number):void
		{
			grid.setBlocksAs(Block.LIVE,
				new Point(x + 1, y),
				new Point(x + 2, y + 1),
				new Point(x, y + 2),
				new Point(x + 1, y + 2),
				new Point(x + 2, y + 2))
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
		
		/**
		 * Adds an Gosper glider gun to the grid at the given coordinates.
		 * An Gsper glider gun is the pattern below, with . representing an 
		 * empty cell and x a live one:
		 * ........................x...........
		 * ......................x.x...........
		 * ............xx......xx............xx
		 * ...........x...x....xx............xx
		 * xx........x.....x...xx..............
		 * xx........x...x.xx....x.x...........
		 * ..........x.....x.......x...........
		 * ...........x...x....................
		 * ............xx......................
		 * 
		 * 
		 * The given coordinates indicate the top left block.
		 * 
		 * @param grid the grid.
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 */
		private function addGosperGliderGunAt(grid:Grid, x:Number, y:Number):void
		{	
			// left 2x2 square
			grid.setBlocksAs(Block.LIVE,
				new Point(x, y + 4),
				new Point(x, y + 5),
				new Point(x + 1, y + 4),
				new Point(x + 1, y + 5))
				
			// left trigger
			grid.setBlocksAs(Block.LIVE,
				new Point(x + 10, y + 4),
				new Point(x + 10, y + 5),
				new Point(x + 10, y + 6),
				new Point(x + 11, y + 3),
				new Point(x + 11, y + 7),
				new Point(x + 12, y + 2),
				new Point(x + 12, y + 8),
				new Point(x + 13, y + 2),
				new Point(x + 13, y + 8),
				new Point(x + 14, y + 5),
				new Point(x + 15, y + 3),
				new Point(x + 15, y + 7),
				new Point(x + 16, y + 4),
				new Point(x + 16, y + 5),
				new Point(x + 16, y + 6),
				new Point(x + 17, y + 5))
				
			// right trigger
			grid.setBlocksAs(Block.LIVE,
				new Point(x + 20, y + 2),
				new Point(x + 20, y + 3),
				new Point(x + 20, y + 4),
				new Point(x + 21, y + 2),
				new Point(x + 21, y + 3),
				new Point(x + 21, y + 4),
				new Point(x + 22, y + 1),
				new Point(x + 22, y + 5),
				new Point(x + 24, y),
				new Point(x + 24, y + 1),
				new Point(x + 24, y + 5),
				new Point(x + 24, y + 6))
			
			// right 2x2 square
			grid.setBlocksAs(Block.LIVE,
				new Point(x + 34, y + 2),
				new Point(x + 34, y + 3),
				new Point(x + 35, y + 2),
				new Point(x + 35, y + 3))
		}
		
		/**
		 * Sets the block in the given grid at the given coordinates as an end
		 * block.
		 * 
		 * @param grid the grid.
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 */
		public function addEndingAt(grid:Grid, x:Number, y:Number):void
		{
			grid.setBlocksAs(Block.END, new Point(x, y))
		}
	}
}