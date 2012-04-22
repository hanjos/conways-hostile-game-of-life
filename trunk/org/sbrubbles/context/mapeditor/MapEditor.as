package org.sbrubbles.contexts.mapeditor 
{
	import flash.ui.Keyboard;
	import org.sbrubbles.context.Context;
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
		
		public function MapEditor(owner:Main) 
		{
			super(owner)
		}
		
		public override function start():void
		{
			super.start()
			
			_grid = new Grid(owner.stage)
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
		
		private function checkInput()
		{
			if (owner.input.isPressed(Keyboard.G)) { // glider
				_grid.selectedPattern = "glider"
			} else if (owner.input.isPressed(Keyboard.A)) { // acorn
				_grid.selectedPattern = "acorn"
			} else if (owner.input.isPressed(Keyboard.O)) { // Gosper's glider gun
				_grid.selectedPattern = "gosperGliderGun"
			} else if (owner.input.isPressed(Keyboard.S)) { // starting pad
				_grid.selectedPattern = "start"
			} else if (owner.input.isPressed(Keyboard.E)) { // ending
				_grid.selectedPattern = "end"
			} else if (owner.input.isPressed(Keyboard.U)) { // unselect a pattern
				_grid.selectedPattern = null
			} else if (owner.input.isPressed(Keyboard.C)) { // clear the grid and stop running
				_grid.clear()
				_running = false
			} else if (owner.input.isPressed(Keyboard.SPACE)) { // start/stop the running
				_running = !_running
			} else if (owner.input.isPressed(Keyboard.Q)) { // return to the main menu
				owner.contexts.goTo(Main.MAIN_MENU)
			}
		}
	}
}