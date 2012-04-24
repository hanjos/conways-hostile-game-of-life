package org.sbrubbles.context.mapeditor 
{
	import adobe.utils.ProductManager;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.context.Contexts;
	import org.sbrubbles.gameoflife.Block;
	import org.sbrubbles.gameoflife.Grid;
	import org.sbrubbles.gameoflife.Pattern;
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
			_patterns.glider = Pattern.GLIDER
			_patterns.acorn = Pattern.ACORN
			_patterns.gosperGliderGun = Pattern.GOSPER_GLIDER_GUN
			_patterns.end = Pattern.END
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
				_patterns[_selectedPattern].applyOn(_grid, x, y)
			}
		}
	}
}