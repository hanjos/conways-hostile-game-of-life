package org.sbrubbles.context.mainmenu 
{
	import org.sbrubbles.fla.IntroductionWidget; // defined in the FLA
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.context.Contexts;
	import org.sbrubbles.Main;
	import org.sbrubbles.Input;
	
	/**
	 * The starting menu. Informs what other contexts are available, and as a special treat holds a 
	 * live Game of Life instance running in the background.
	 * 
	 * @author Humberto Anjos
	 */
	public class MainMenu extends Context
	{
		private var _background:Grid
		private var _menu:IntroductionWidget
		
		public function MainMenu(main:Main) 
		{
			super(main);
		}
		
		// builds the screen
		public override function start():void 
		{
			super.start()
			
			var background = getBackground();
			background.clear()
			background.alpha = 0.5
			
			addChild(background);
			
			var menu = new IntroductionWidget();
			menu.x = (owner.stage.stageWidth - menu.width) / 2
			menu.y = (owner.stage.stageHeight - menu.height) / 2
			
			addChild(menu);
		}
		
		public override function update():void
		{
			super.update() // FAIL do you HAVE to always call the super?
			
			// update the background
			_background.tick()
			
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
				_background.clear()
			}
			
			if (Input.isPressed(Keyboard.E)) { // go to the map editor
				Contexts.goTo(Main.MAP_EDITOR)
			}
		}
		
		/**
		 * Returns the background, creating it lazily.
		 * 
		 * @return the non-null background.
		 */
		private function getBackground():Grid 
		{
			if (_background == null)
				_background = new Grid()
				
			return _background
		}
	}
}