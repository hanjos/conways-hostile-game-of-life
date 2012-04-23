package org.sbrubbles.context.mapeditor 
{
	import flash.ui.Keyboard;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.context.Contexts;
	import org.sbrubbles.Main;
	import org.sbrubbles.Input;
	
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
			if (Input.isPressed(Keyboard.G)) { // glider
				_grid.selectedPattern = "glider"
			} else if (Input.isPressed(Keyboard.A)) { // acorn
				_grid.selectedPattern = "acorn"
			} else if (Input.isPressed(Keyboard.O)) { // Gosper's glider gun
				_grid.selectedPattern = "gosperGliderGun"
			} else if (Input.isPressed(Keyboard.S)) { // starting pad
				_grid.selectedPattern = "start"
			} else if (Input.isPressed(Keyboard.E)) { // ending
				_grid.selectedPattern = "end"
			} else if (Input.isPressed(Keyboard.U)) { // unselect a pattern
				_grid.selectedPattern = null
			} else if (Input.isPressed(Keyboard.C)) { // clear the grid and stop running
				_grid.clear()
				_running = false
			} else if (Input.isPressed(Keyboard.SPACE)) { // start/stop the running
				_running = !_running
			} else if (Input.isPressed(Keyboard.Q)) { // return to the main menu
				Contexts.goTo(Main.MAIN_MENU)
			}
		}
	}
}