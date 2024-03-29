package org.sbrubbles.fla 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.sbrubbles.Main;
	import org.sbrubbles.systems.Contexts;
	
	/**
	 * Leads the player to a new game. Its visuals are defined in the FLA.
	 * 
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
			Contexts.goTo(Main.GAME)
		}
	}

}