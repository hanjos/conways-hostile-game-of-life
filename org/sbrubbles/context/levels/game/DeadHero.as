package org.sbrubbles.context.levels.game 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.Main;
	
	/**
	 * A game context loaded when the hero dies.
	 * 
	 * @author Humberto Anjos
	 */
	public class DeadHero extends Context 
	{
		private var _title:TextField
		
		public function DeadHero(main:Main) 
		{
			super(main)
		}
		
		public override function start():void
		{
			super.start() // FAIL without this it doesn't work
			
			owner.gameState.grid.alpha = 0.5
			addChild(owner.gameState.grid)
			
			var title = getTitle()
			title.x = (owner.stage.stageWidth - title.width)/2
			title.y = (owner.stage.stageHeight - title.height) / 2
			
			addChild(getTitle())
		}
		
		public override function update():void
		{
			super.update()
			
			checkInput()
		}
		
		private function checkInput():void 
		{
			if (owner.input.isPressed(Keyboard.SPACE)) { // try again
				owner.gameState.reset()
				owner.contexts.goTo(Main.ACTIVE_GAME)
			}
			
			if (owner.input.isPressed(Keyboard.Q)) { // go back to the main menu
				owner.gameState.reset()
				owner.contexts.goTo(Main.MAIN_MENU)
			}
		}
		
		/**
		 * Returns the title, creating it lazily.
		 * 
		 * @return the non-null title.
		 */
		private function getTitle():TextField
		{
			if(_title == null) {
				_title = new TextField();
				_title.background = true
				_title.border = false
				_title.type = TextFieldType.DYNAMIC // non-editable
				_title.selectable = false
				_title.autoSize = TextFieldAutoSize.LEFT
				

				var format = new TextFormat();
				format.size = 50
				format.align = TextFormatAlign.CENTER
				format.bold = true

				_title.defaultTextFormat = format
				_title.text = "GAME OVER"
			}
			
			return _title;
		}
	}
}