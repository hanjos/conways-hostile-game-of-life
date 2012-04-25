package org.sbrubbles.context.mapeditor 
{
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
	import org.sbrubbles.gameoflife.Block;
	import org.sbrubbles.gameoflife.Grid;
	import org.sbrubbles.gameoflife.Pattern;
	import org.sbrubbles.Main;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.systems.Input;
	import org.sbrubbles.util.Command;
	
	/**
	 * Provides a context for map creation.
	 * 
	 * @author Humberto Anjos
	 */
	public class MapEditor extends Context
	{
		private var _grid:Grid
		private var _running:Boolean
		
		private var _input:Dictionary // <uint, Pattern>
		private var _selectedPattern:SelectedPattern
		private var _tooltip:TextField
		private var _help:TextField
		
		public function MapEditor(owner:Main) 
		{
			super(owner)
			
			_input = new Dictionary()
		}
		
		public override function start():void
		{
			super.start()
			
			_input[Keyboard.G] = new Command("Glider", function () { _selectedPattern.pattern = Pattern.GLIDER } )
			_input[Keyboard.A] = new Command("Acorn", function () { _selectedPattern.pattern = Pattern.ACORN } )
			_input[Keyboard.O] = new Command("Gosper's glider gun", function () { _selectedPattern.pattern = Pattern.GOSPER_GLIDER_GUN } )
			_input[Keyboard.E] = new Command("End", function () { _selectedPattern.pattern = Pattern.SINGLE } )
			_input[Keyboard.B] = new Command("Beehive", function () { _selectedPattern.pattern = Pattern.BEEHIVE } )
			_input[Keyboard.S] = new Command("Spaceship", function () { _selectedPattern.pattern = Pattern.SPACESHIP } )
			_input[Keyboard.P] = new Command("Pulsar", function () { _selectedPattern.pattern = Pattern.PULSAR } )
			_input[Keyboard.U] = new Command("Unselect", function () { _selectedPattern.pattern = null } )
			_input[Keyboard.C] = new Command("Clear map", function () { _grid.clearMap(); _running = false } )
			_input[Keyboard.SPACE] = new Command("Pause", function () { _running = !_running } )
			_input[Keyboard.Q] = new Command("Quit", function () { Contexts.goTo(Main.MAIN_MENU) } )
			_input[Keyboard.H] = new Command("Help", 
				function () { 
					if(! _help.visible) {
						_running = false
						_tooltip.visible = false
						_help.visible = true 
					} else {
						_help.visible = false
						_tooltip.visible = true
					}
				})
			
			_grid = new Grid()
			_selectedPattern = new SelectedPattern(_grid)
			_running = false
			_tooltip = newTooltip()
			_help = newHelpWidget()
			_help.x = (_grid.width - _help.width) / 2
			_help.y = (_grid.height - _help.height) / 2
			
			addChild(_grid)
			addChild(_tooltip)
			addChild(_help)
			
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true)
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved, false, 0, true)
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
			// evaluate any commands
			for (var key in _input) { 
				if (Input.isPressed(key)) {
					_input[key].call()
				}
			}
		}
		
		private function mouseClicked(e:MouseEvent):void 
		{
			if(!_help.visible) {
				var x: Number = Math.floor(this.mouseX / _grid.gridScale)
				var y: Number = Math.floor(this.mouseY / _grid.gridScale)
				
				if (_selectedPattern.pattern == null) { // toggle the state of the underlying block
					_grid.getBlockAt(x, y).toggleState()
				} else { // apply the selected pattern
					var state = _selectedPattern.pattern == Pattern.SINGLE ? Block.END : Block.LIVE
					_selectedPattern.pattern.applyOn(state, _grid, x, y)
				}
			}
		}
		
		private function mouseMoved(e:MouseEvent):void
		{
			if(!_help.visible) {
				var x:Number = Math.floor(this.mouseX / _grid.gridScale)
				var y:Number = Math.floor(this.mouseY / _grid.gridScale)
				
				_selectedPattern.position = new Point(x, y);
				_tooltip.x = Math.max(this.mouseX - _tooltip.width, 0)
				_tooltip.y = Math.max(this.mouseY - _tooltip.height, 0)
				_tooltip.text = x + "," + y
			}
		}
		
		private function newTooltip():TextField
		{
			var t:TextField = new TextField();
			t.background = true
			t.backgroundColor = 0xFFFFE0
			t.border = false
			t.type = TextFieldType.DYNAMIC // non-editable
			t.selectable = false
			t.autoSize = TextFieldAutoSize.LEFT

			var format:TextFormat = new TextFormat();
			format.size = 10
			format.align = TextFormatAlign.CENTER
			format.bold = true

			t.defaultTextFormat = format
			t.text = ""
			
			return t
		}
		
		private function newHelpWidget():TextField
		{
			var t:TextField = new TextField()
			t.background = true
			t.backgroundColor = 0x404040
			t.alpha = 0.8
			t.border = true
			t.borderColor = 0xFFFF80
			t.textColor = 0xFFFF80
			t.type = TextFieldType.DYNAMIC // non-editable
			t.selectable = false
			t.autoSize = TextFieldAutoSize.LEFT
			t.multiline = true
			t.visible = false
			
			var format:TextFormat = new TextFormat();
			format.font = "Verdana"
			format.size = 15

			t.defaultTextFormat = format
			var text:String = "<html><p align='center'>Inputs</p><br/><p>"
			
			for(var key in _input) {
				text += "<b>" + (key == Keyboard.SPACE ? "SPACE" : String.fromCharCode(key)) + "</b>:" + _input[key].name + "<br/>"
			}
			
			text += "</p><br/><p align='center'>Press H to go back</p>"
			text += "</html>"
			
			t.htmlText = text
			
			return t
		}
	}
}