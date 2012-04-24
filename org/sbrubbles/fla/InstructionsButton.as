package org.sbrubbles.fla 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.sbrubbles.Main;
	import org.sbrubbles.systems.Contexts;
	
	/**
	 * Leads the player to the instructions context. Its visuals are defined 
	 * in the FLA.
	 * 
	 * @author Humberto Anjos
	 */
	public class InstructionsButton extends MovieClip
	{
		public function InstructionsButton() 
		{
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true)
		}
		
		private function mouseClicked(e:MouseEvent)
		{
			Contexts.goTo(Main.INSTRUCTIONS)
		}
	}

}