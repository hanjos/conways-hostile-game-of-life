package org.sbrubbles.context.mapeditor 
{
	import flash.display.BitmapData;
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
		private var _selectedPattern:SelectedPattern
		
		public function MapEditor(owner:Main) 
		{
			super(owner)
		}
		
		public override function start():void
		{
			super.start()
			
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true)
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved, false, 0, true)
			
			_grid = new Grid()
			_selectedPattern = new SelectedPattern(_grid)
			_running = false
			
			addChild(_grid)
		}
		
		public override function update():void
		{
			super.update()
			
			if (_running) {
				_grid.update() // update the grid if running
			}
			
			_selectedPattern.update() // always update the shadow
			
			checkInput()
		}
		
		public override function terminate():void
		{
			removeEventListener(MouseEvent.CLICK, mouseClicked)
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoved)
			
			super.terminate()
		}
		
		private function checkInput()
		{
			if (Input.isPressed(Keyboard.G)) { // glider
				_selectedPattern.pattern = Pattern.GLIDER
			} else if (Input.isPressed(Keyboard.A)) { // acorn
				_selectedPattern.pattern = Pattern.ACORN
			} else if (Input.isPressed(Keyboard.O)) { // Gosper's glider gun
				_selectedPattern.pattern = Pattern.GOSPER_GLIDER_GUN
			} else if (Input.isPressed(Keyboard.E)) { // ending
				_selectedPattern.pattern = Pattern.SINGLE
			} else if (Input.isPressed(Keyboard.U)) { // unselect a pattern
				_selectedPattern.pattern = null
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
				var state = _selectedPattern.pattern == Pattern.SINGLE ? Block.END : Block.LIVE
				_selectedPattern.pattern.applyOn(state, _grid, x, y)
			}
		}
		
		private function mouseMoved(e:MouseEvent):void
		{
			var x:Number = Math.floor(this.mouseX / _grid.gridScale)
			var y:Number = Math.floor(this.mouseY / _grid.gridScale)
			
			_selectedPattern.position = new Point(x, y);
		}
	}
}