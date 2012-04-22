package org.sbrubbles.context 
{
	import flash.display.MovieClip;
	import org.sbrubbles.Main;
	
	/**
	 * A context is a component which provides a screen for interaction with 
	 * the user. The game is essentially a group of contexts, loosely bound to
	 * each other, with only one active at a time. 
	 * 
	 * This class provides methods for lifecycle management.
	 * 
	 * @author Humberto Anjos
	 * @see Contexts
	 */
	public class Context extends MovieClip 
	{
		private var _owner:Main
		
		/**
		 * Creates a new context, owned by the given Main object.
		 * 
		 * @param owner
		 */
		public function Context(owner:Main) {
			_owner = owner
		}
		
		// === lifecycle management ===
		/**
		 * Loads and readies all necessary resources to get this context ready 
		 * to run, being called upon activation. 
		 * 
		 * Every subclass which overrides this method should call super.start()
		 * before its own code.
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
		 * 
		 * Every subclass which overrides this method should call 
		 * super.terminate() before its own code.
		 */
		public function terminate():void { _owner.removeChild(this) }
		
		// === properties ===
		public function get owner():Main { return _owner }
	}

}