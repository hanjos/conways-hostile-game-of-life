package org.sbrubbles.context.levels 
{
	import flash.display.Shape;
	import org.sbrubbles.Main;
	import org.sbrubbles.context.Context;
	
	/**
	 * ...
	 * @author Humberto Anjos
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
			bg.graphics.drawRect(0, 0, owner.stage.stageWidth, owner.stage.stageHeight)
			bg.graphics.endFill()
			
			addChild(bg)
		}
	}

}