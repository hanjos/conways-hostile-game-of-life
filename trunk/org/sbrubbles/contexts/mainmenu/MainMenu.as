package org.sbrubbles.contexts.mainmenu 
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
	 * The starting menu. Informs what other contexts are available, and as a special treat holds a 
	 * live Game of Life instance running in the background.
	 * 
	 * @author Humberto Anjos
	 */
	public class MainMenu extends Context
	{
		private var _background:Grid
		private var _title:TextField
		private var _subtitle:TextField
		
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
			
			var title:TextField = getTitle();
			title.x = (owner.stage.stageWidth - title.width)/2
			title.y = (owner.stage.stageHeight - title.height)/2
			
			addChild(title);
			
			var subtitle:TextField = getSubtitle();
			subtitle.x = (owner.stage.stageWidth - subtitle.width) / 2
			subtitle.y = title.y + title.height + 2
			
			addChild(subtitle);
		}
		
		public override function update():void
		{
			super.update() // FAIL you HAVE to call the super, or Flash gets lost (?)
			
			// update the background
			_background.tick()
			
			// check input
			if (owner.input.isPressed(Keyboard.C)) { // ??? sometimes owner.input works, sometimes it doesn't, no idea why
				_background.clear()
			}
			
			if (owner.input.isPressed(Keyboard.SPACE)) { // go to the game
				owner.gameState.reset()
				owner.contexts.goTo(Main.ACTIVE_GAME)
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
				_title.alpha = 1

				var format = new TextFormat();
				format.size = 25
				format.align = TextFormatAlign.CENTER
				format.bold = true

				_title.defaultTextFormat = format
				_title.text = "Conway's Hostile Game of Life"
			}
			
			return _title;
		}
		
		/**
		 * Returns the subtitle, creating it lazily.
		 * 
		 * @return the non-null subtitle.
		 */
		private function getSubtitle():TextField
		{
			if(_subtitle == null) {
				_subtitle = new TextField();
				_subtitle.background = true
				_subtitle.border = false
				_subtitle.type = TextFieldType.DYNAMIC // non-editable
				_subtitle.selectable = false
				_subtitle.autoSize = TextFieldAutoSize.LEFT
				_subtitle.alpha = 1

				var format = new TextFormat();
				format.size = 18
				format.align = TextFormatAlign.CENTER
				format.bold = true

				_subtitle.defaultTextFormat = format
				_subtitle.text = "Press SPACE to begin..."
			}
			
			return _subtitle;
		}
		
		/**
		 * Returns the background, creating it lazily.
		 * 
		 * @return the non-null background.
		 */
		private function getBackground():Grid 
		{
			if (_background == null)
				_background = new Grid(owner.stage)
				
			return _background
		}
	}
}