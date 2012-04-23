package org.sbrubbles.context.instructions 
{
	import org.sbrubbles.context.Context;
	import org.sbrubbles.fla.InstructionsWidget;
	import org.sbrubbles.Main;
	
	/**
	 * Displays a little tutorial for the game.
	 * 
	 * @author Humberto Anjos
	 */
	public class Instructions extends Context 
	{
		public function Instructions(owner:Main) 
		{
			super(owner);
		}
		
		public override function start():void
		{
			super.start()
			
			addChild(new InstructionsWidget())
		}
	}

}