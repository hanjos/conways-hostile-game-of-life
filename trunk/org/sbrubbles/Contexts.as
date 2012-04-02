package org.sbrubbles 
{
	import flash.display.MovieClip;
	import org.sbrubbles.context.Context;
	
	/**
	 * ...
	 * @author Humberto Anjos
	 */
	public class Contexts extends MovieClip 
	{
		private var _current:Context
		
		public function Contexts() 
		{
			current = null
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
			if (this._current != null)
				this._current.terminate()
				
			this._current = _curr
			
			if (this._current != null)
				this._current.start()
		}
	}

}