package org.sbrubbles.fla 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * Leads the player from the main menu screen to 
	 * @author Humberto Anjos
	 */
	public class PlayButton extends MovieClip 
	{
		public function PlayButton() 
		{
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true)
		}
		
		private function mouseClicked(e:MouseEvent)
		{
			trace("mouse clicked!")
		}
	}

}