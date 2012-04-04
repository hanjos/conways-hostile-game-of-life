package org.sbrubbles 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import org.sbrubbles.context.Context;
	
	/**
	 * ...
	 * @author Humberto Anjos
	 */
	public class Contexts
	{
		private var _current:Context
		private var _main:Main
		
		public function Contexts(main:Main) 
		{
			_current = null
			_main = main
		}
		
		public function update():void
		{
			if (_current == null)
				return;
				
			_current.update()
		}
		
		// properties
		public function get current():Context { return _current }
		public function set current(_curr:Context):void 
		{ 
			if (this._current != null) {
				this._current.terminate()
			}
			
			this._current = _curr
			
			if (this._current != null) {
				this._current.start()
			}
		}
	}

}