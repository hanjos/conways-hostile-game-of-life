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
		private static const SHADOW_COLOR:Number = 0xFFC0C0C0
		private static const TRANSPARENT_COLOR:Number = 0x00000000
		
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
			_patterns.end = Pattern.SINGLE
		}
		
		public override function start():void
		{
			super.start()
			
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true)
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved, false, 0, true)
			
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
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoved)
			
			super.terminate()
		}
		
		private function checkInput()
		{
			if (Input.isPressed(Keyboard.G)) { // glider
				selectPattern("glider")
			} else if (Input.isPressed(Keyboard.A)) { // acorn
				selectPattern("acorn")
			} else if (Input.isPressed(Keyboard.O)) { // Gosper's glider gun
				selectPattern("gosperGliderGun")
			} else if (Input.isPressed(Keyboard.E)) { // ending
				selectPattern("end")
			} else if (Input.isPressed(Keyboard.U)) { // unselect a pattern
				selectPattern(null)
			} else if (Input.isPressed(Keyboard.C)) { // clear the grid and stop running
				_grid.clear()
				_running = false
			} else if (Input.isPressed(Keyboard.SPACE)) { // start/stop the running
				_running = !_running
			} else if (Input.isPressed(Keyboard.Q)) { // return to the main menu
				Contexts.goTo(Main.MAIN_MENU)
			}
		}
		
		private function selectPattern(patt:String):void
		{
			_selectedPattern = patt // save the selection
			drawShadowOf(patt) // update the shadow
		}
		
		private function mouseClicked(e:MouseEvent):void 
		{
			var x: Number = Math.floor(this.mouseX / _grid.gridScale)
			var y: Number = Math.floor(this.mouseY / _grid.gridScale)
			
			if (_selectedPattern == null) { // toggle the state of the underlying block
				_grid.getBlockAt(x, y).toggleState()
			} else { // apply the selected pattern
				var state = _selectedPattern == "end" ? Block.END : Block.LIVE
				_patterns[_selectedPattern].applyOn(state, _grid, x, y)
			}
		}
		
		private function mouseMoved(e:MouseEvent):void
		{
			drawShadowOf(_selectedPattern);
		}
		
		private function drawShadowOf(patt:String):void 
		{
			var canvas:BitmapData = _grid.canvas // draw on the canvas, not the underlying map
			
			// clear the canvas
			canvas.fillRect(canvas.rect, TRANSPARENT_COLOR)
			
			if (patt == null) {
				return // nothing else to do
			}
		
			// get the points to shadow
			var x:Number = Math.floor(this.mouseX / _grid.gridScale)
			var y:Number = Math.floor(this.mouseY / _grid.gridScale)
			var p:Point = new Point(x, y)
			var pattern:Pattern = _patterns[patt]
			
			var points = pattern.offsets.map(function(item:Point, index:int, array:Array) { return item.add(p) })
			
			// draw them
			for each(var pp in points) {
				canvas.setPixel32(pp.x, pp.y, SHADOW_COLOR)
			}
		}
	}
}