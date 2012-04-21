package org.sbrubbles.context 
{
	import flash.display.MovieClip;
	import org.sbrubbles.Main;
	
	/**
	 * An abstract class representing a game context.
	 * 
	 * @author Humberto Anjos
	 */
	public class Context extends MovieClip 
	{
		private var _owner:Main
		
		public function Context(owner:Main) {
			_owner = owner
		}
		
		/**
		 * Loads and readies all necessary resources to get this context ready 
		 * to run, being called upon activation.
		 */
		public function start():void { _owner.addChild(this) }
		
		/**
		 * Called every frame so that this context can update its internal 
		 * state.
		 */
		public function update():void { }
		
		/**
		 * Unloads all of this context's resources and gets it ready for being 
		 * swapped out.
		 */
		public function terminate():void { _owner.removeChild(this) }
		
		// propriedades
		public function get owner():Main { return _owner }
		public function set owner(_owner:Main) { this._owner = _owner }
	}

}