package org.sbrubbles.context.mainmenu 
{
	import org.sbrubbles.fla.IntroductionWidget; // defined in the FLA
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.gameoflife.Block;
	import org.sbrubbles.gameoflife.Grid;
	import org.sbrubbles.gameoflife.Pattern;
	import org.sbrubbles.Main;
	import org.sbrubbles.systems.Input;
	
	/**
	 * The starting menu. Informs what other contexts are available, and as a special treat holds a 
	 * live Game of Life instance running in the background.
	 * 
	 * @author Humberto Anjos
	 */
	public class MainMenu extends Context
	{
		private var _grid:Grid
		private var _menu:IntroductionWidget
		
		public function MainMenu(main:Main) 
		{
			super(main);
			
			_grid = new Grid()
			
			addEventListener(MouseEvent.CLICK, mouseClicked);
		}
		
		// builds the screen
		public override function start():void 
		{
			super.start()
			
			_grid.clearMap()
			_grid.alpha = 0.5
			
			addChild(_grid);
			
			var menu = new IntroductionWidget();
			menu.x = (owner.stage.stageWidth - menu.width) / 2
			menu.y = (owner.stage.stageHeight - menu.height) / 2
			
			addChild(menu);
		}
		
		public override function update():void
		{
			super.update() // FAIL do you HAVE to always call the super?
			
			// update the background grid
			_grid.update()
			
			// check input
			checkInput();
		}
		
		public override function terminate():void
		{
			// reset the game state before leaving
			owner.gameState.reset()
			
			super.terminate()
		}
		
		private function checkInput():void 
		{
			if (Input.isPressed(Keyboard.C)) { // clear the background
				_grid.clearMap()
			}
			
			if (Input.isPressed(Keyboard.E)) { // go to the map editor
				Contexts.goTo(Main.MAP_EDITOR)
			}
		}
		
		private function mouseClicked(e:MouseEvent):void 
		{
			var x: Number = Math.floor(this.mouseX / _grid.gridScale)
			var y: Number = Math.floor(this.mouseY / _grid.gridScale)
			
			if(Math.random() < 1/3) {
				Pattern.GLIDER.applyOn(Block.LIVE, _grid, x, y)
			} else if(Math.random() < 2/3){
				Pattern.ACORN.applyOn(Block.LIVE, _grid, x, y)
			} else {
				Pattern.GOSPER_GLIDER_GUN.applyOn(Block.LIVE, _grid, x, y)
			}
		}
	}
}