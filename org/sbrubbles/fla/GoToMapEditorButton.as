package org.sbrubbles.fla 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.sbrubbles.Main;
	import org.sbrubbles.systems.Contexts;
	
	/**
	 * Sends the player to the map editor.
	 * 
	 * @author Humberto Anjos
	 */
	public class GoToMapEditorButton extends MovieClip 
	{
		public function GoToMapEditorButton() 
		{
			addEventListener(MouseEvent.CLICK, mouseClicked, false, 0, true)
		}
		
		private function mouseClicked(e:MouseEvent)
		{
			Contexts.goTo(Main.MAP_EDITOR)
		}
	}
}