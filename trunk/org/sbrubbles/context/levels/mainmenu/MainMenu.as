package org.sbrubbles.context.levels.mainmenu 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import flash.display.BlendMode;
	import nl.interactionfigure.gameoflife.EternalConway;
	import org.sbrubbles.context.Context;
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
		private var background:EternalConway
		private var title:TextField
		private var subtitle:TextField
		
		public function MainMenu(main:Main) 
		{
			super(main);
		}
		
		public override function start():void 
		{
			super.start()
			
			var background = getBackground();
			background.clearCanvas() // ensures the background is cleaned
			
			addChild(background);
			
			var title:TextField = getTitle();
			title.x = (main.stage.stageWidth - title.width)/2
			title.y = (main.stage.stageHeight - title.height)/2
			
			addChild(title);
			
			var subtitle:TextField = getSubtitle();
			subtitle.x = (main.stage.stageWidth - subtitle.width) / 2
			subtitle.y = title.y + title.height + 2
			
			addChild(subtitle);
		}
		
		public override function update():void
		{
			super.update() // you HAVE to call the super, or Flash gets lost (?) #FAIL
			
			// update the background
			background.tick()
			
			// check input
			if (new Input(main).isPressed(Keyboard.C)) { // using main's input screws up everything, apparently... #FAIL
				background.clearCanvas()
			}
		}
		
		/**
		 * Returns the title, creating it lazily.
		 * 
		 * @return the non-null title.
		 */private function getTitle():TextField
		{
			if(title == null) {
				title = new TextField();
				title.background = true
				title.border = false
				title.type = TextFieldType.DYNAMIC // non-editable
				title.selectable = false
				title.autoSize = TextFieldAutoSize.LEFT
				title.alpha = 0.5

				var format = new TextFormat();
				format.size = 25
				format.align = TextFormatAlign.CENTER
				format.bold = true

				title.defaultTextFormat = format
				title.text = "Conway's Hostile Game of Life"
			}
			
			return title;
		}
		
		/**
		 * Returns the subtitle, creating it lazily.
		 * 
		 * @return the non-null subtitle.
		 */
		private function getSubtitle():TextField
		{
			if(subtitle == null) {
				subtitle = new TextField();
				subtitle.background = true
				subtitle.border = false
				subtitle.type = TextFieldType.DYNAMIC // non-editable
				subtitle.selectable = false
				subtitle.autoSize = TextFieldAutoSize.LEFT
				subtitle.alpha = 0.5

				var format = new TextFormat();
				format.size = 18
				format.align = TextFormatAlign.CENTER
				format.bold = true

				subtitle.defaultTextFormat = format
				subtitle.text = "Press SPACE to begin..."
			}
			
			return subtitle;
		}
		
		/**
		 * Returns the background, creating it lazily.
		 * 
		 * @return the non-null background.
		 */
		private function getBackground():EternalConway 
		{
			if (background == null)
				background = new EternalConway(main.stage)
				
			return background
		}
	}
}