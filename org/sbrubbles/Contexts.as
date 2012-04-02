package org.sbrubbles 
{
	import flash.display.MovieClip;
	
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
			if (current == null)
				return;
				
			current.update()
		}
		
		// properties
		public function get current():Context { return _current }
		public function set current(_current:Context) 
		{ 
			if (this._current != null)
				this._current.terminate()
				
			this._current = _current
			
			if (this._current != null)
				this._current.start()
		}
	}

}