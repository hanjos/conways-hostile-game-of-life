package org.sbrubbles.context.game 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.fla.WinWidget;
	import org.sbrubbles.Main;
	import org.sbrubbles.systems.Input;
	
	/**
	 * Game context shown when the player is successful.
	 * 
	 * @author Humberto Anjos
	 */
	public class Win extends Context
	{
		public function Win(owner:Main) 
		{
			super(owner)
		}
		
		// === context operations === 
		public override function start():void
		{
			super.start() // FAIL without this it doesn't work
			
			owner.gameState.grid.alpha = 0.5
			addChild(owner.gameState.grid)
			
			var widget = new WinWidget()
			widget.x = (owner.stage.stageWidth - widget.width) / 2
			widget.y = (owner.stage.stageHeight - widget.height) / 2
			
			addChild(widget)
		}
		
		public override function update():void
		{
			super.update()
			
			checkInput()
		}
		
		public override function terminate():void
		{
			owner.gameState.reset()
			
			super.terminate()
		}
		
		private function checkInput():void 
		{
			if (Input.isPressed(Keyboard.SPACE)) { // try again
				Contexts.goTo(Main.GAME)
			}
			
			if (Input.isPressed(Keyboard.Q)) { // go back to the main menu
				Contexts.goTo(Main.MAIN_MENU)
			}
		}
	}

}