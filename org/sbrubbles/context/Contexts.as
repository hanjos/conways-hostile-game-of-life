package org.sbrubbles.context 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.Dictionary;
	import org.sbrubbles.Main;
	import org.sbrubbles.context.Context;
	
	/**
	 * Manages the game contexts, ensuring only one is active at a time, 
	 * starting and terminating them properly, and holding all known contexts.
	 * 
	 * @author Humberto Anjos
	 */
	public class Contexts
	{
		private static var _contexts:Dictionary // <String, Context>
		private static var _current:Context
		
		/**
		 * Constructor. Does nothing, and shouldn't be called.
		 */
		public function Contexts() { }
		
		/**
		 * Static constructor.
		 */
		{
			_contexts = new Dictionary()
			_current = null	
		}
		
		/**
		 * Updates the current context, or does nothing if no context is active.
		 */
		public static function update():void
		{
			if (_current == null)
				return;
				
			_current.update()
		}
		
		/**
		 * Registers a new context, accessible with the given id.
		 * 
		 * @param id the identifier.
		 * @param context the context. If null, removes the previous mapping.
		 * @return the context previously mapped to the given id, or null if there were none.
		 */
		public static function register(id:String, context:Context) :Context
		{
			var old:Context = _contexts[id]
			
			// the context being swapped out is the current one;
			// unload it
			if (current == old) {
				setCurrent(null)
			}
			
			if(context != null) {
				_contexts[id] = context
			} else { // remove it from the dictionary
				delete _contexts[id]
			}
			
			return old
		}
		
		/**
		 * Starts the context registered with id, terminating the 
		 * previously active context.
		 * 
		 * @param id the context to load.
		 */
		public static function goTo(id:String):void
		{
			// TODO error handling
			setCurrent(_contexts[id])
		}
		
		/**
		 * Terminates the current context, without starting a new one.
		 */
		public static function deactivate():void
		{
			setCurrent(null)
		}
		
		// properties
		
		/**
		 * @return the current active context, or null if no context is active.
		 */
		public static function get current():Context { return _current }
		private static function setCurrent(curr:Context) 
		{ 	// FAIL ActionScript doesn't like public getters and private setters
			if (_current != null) {
				_current.terminate()
			}
			
			_current = curr
			
			if (_current != null) {
				_current.start()
			}
		}
	}

}