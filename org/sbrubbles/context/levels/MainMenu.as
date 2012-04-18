package org.sbrubbles.context.levels 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.Main;
	
	/**
	 * The starting menu.
	 * 
	 * @author Humberto Anjos
	 */
	public class MainMenu extends Context
	{
		public function MainMenu(main:Main) 
		{
			super(main);
		}
		
		public override function start():void 
		{
			super.start()
			
			var title:TextField = getTitle();
			title.x = (main.stage.stageWidth - title.width)/2
			title.y = (main.stage.stageHeight - title.height)/2
			
			addChild(title);
			
			var subtitle:TextField = getSubtitle();
			subtitle.x = (main.stage.stageWidth - subtitle.width) / 2
			subtitle.y = title.y + title.height + 2
			
			addChild(subtitle);
		}
		
		private function getTitle():TextField
		{
			var title = new TextField();
            title.background = false;
            title.border = false;
			title.autoSize = TextFieldAutoSize.LEFT

            var format = new TextFormat();
			format.size = 25
			format.align = TextFormatAlign.CENTER
			format.bold = true

            title.defaultTextFormat = format
			title.text = "Conway's Hostile Game of Life"
			
			return title;
		}
		
		private function getSubtitle():TextField
		{
			var subtitle = new TextField();
            subtitle.background = false;
            subtitle.border = false;
			subtitle.autoSize = TextFieldAutoSize.LEFT

            var format = new TextFormat();
			format.size = 18
			format.align = TextFormatAlign.CENTER
			format.bold = true

            subtitle.defaultTextFormat = format
			subtitle.text = "Press SPACE to begin..."
			
			return subtitle;
		}
	}
}