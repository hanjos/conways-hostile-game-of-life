package org.sbrubbles.fla 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.sbrubbles.Main;
	import org.sbrubbles.systems.Contexts;
	
	/**
	 * Takes the player back to the main menu. Its visuals are defined in the 
	 * FLA.
	 * 
	 * @author Humberto Anjos
	 */
	public class ReturnToMainMenuButton extends MovieClip 
	{
		public function ReturnToMainMenuButton() 
		{
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true)
		}
		
		private function mouseClicked(e:MouseEvent)
		{
			Contexts.goTo(Main.MAIN_MENU)
		}
	}
}