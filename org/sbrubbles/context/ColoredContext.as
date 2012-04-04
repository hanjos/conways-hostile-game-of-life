package org.sbrubbles.context 
{
	import flash.display.Shape;
	import org.sbrubbles.Main;
	/**
	 * ...
	 * @author ...
	 */
	public class ColoredContext extends Context
	{
		private var _color:uint
		
		public function ColoredContext(main:Main, color:uint) 
		{
			super(main)
			
			_color = color
		}
		
		public override function start():void 
		{
			super.start()
			
			var bg:Shape = new Shape()
			bg.graphics.beginFill(_color)
			bg.graphics.drawRect(0, 0, main.stage.stageWidth, main.stage.stageHeight)
			bg.graphics.endFill()
			
			main.stage.addChild(bg)
		}
	}

}