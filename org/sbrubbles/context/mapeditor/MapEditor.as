package org.sbrubbles.context.mapeditor 
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.gameoflife.Block;
	import org.sbrubbles.gameoflife.Grid;
	import org.sbrubbles.gameoflife.Pattern;
	import org.sbrubbles.systems.Input;
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
		private var _tooltip:TextField
		
		private var patt:String
		
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
			_tooltip = makeTooltip()
			
			addChild(_grid)
			addChild(_tooltip)
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
				
				patt = "glider"
			} else if (Input.isPressed(Keyboard.A)) { // acorn
				_selectedPattern.pattern = Pattern.ACORN
				
				patt = "acorn"
			} else if (Input.isPressed(Keyboard.O)) { // Gosper's glider gun
				_selectedPattern.pattern = Pattern.GOSPER_GLIDER_GUN
				
				patt = "Gosper's glider gun"
			} else if (Input.isPressed(Keyboard.E)) { // ending
				_selectedPattern.pattern = Pattern.SINGLE
				
				patt = "ending"
			} else if (Input.isPressed(Keyboard.U)) { // unselect a pattern
				_selectedPattern.pattern = null
				
				patt = "<no pattern>"
			} else if (Input.isPressed(Keyboard.C)) { // clear the grid and stop running
				_grid.clearMap()
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
				
				trace("added " + patt + " @ " + x + ", " + y)
			}
		}
		
		private function mouseMoved(e:MouseEvent):void
		{
			var x:Number = Math.floor(this.mouseX / _grid.gridScale)
			var y:Number = Math.floor(this.mouseY / _grid.gridScale)
			
			_selectedPattern.position = new Point(x, y);
			_tooltip.x = Math.min(this.mouseX, _grid.width - _tooltip.width)
			_tooltip.y = Math.max(this.mouseY + 2, _tooltip.height) - _tooltip.height - 2
			_tooltip.text = x + "," + y
		}
		
		private function makeTooltip():TextField
		{
			_tooltip = new TextField();
			_tooltip.background = true
			_tooltip.border = false
			_tooltip.type = TextFieldType.DYNAMIC // non-editable
			_tooltip.selectable = false
			_tooltip.autoSize = TextFieldAutoSize.LEFT

			var format = new TextFormat();
			format.size = 10
			format.align = TextFormatAlign.CENTER
			format.bold = true

			_tooltip.defaultTextFormat = format
			_tooltip.text = ""
			
			return _tooltip
		}
	}
}