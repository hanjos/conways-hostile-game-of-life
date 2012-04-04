package org.sbrubbles.context 
{
	import flash.display.MovieClip;
	import org.sbrubbles.Main;
	
	/**
	 * Uma classe abstrata representando um contexto.
	 * 
	 * @author Humberto Anjos
	 */
	public class Context extends MovieClip 
	{
		private var _main:Main
		
		public function Context(main:Main) {
			_main = main
		}
		
		public function start():void { main.addChild(this) }
		public function update():void { }
		public function terminate():void { main.removeChild(this) }
		
		// propriedades
		public function get main():Main { return _main }
		public function set main(_main:Main) { this._main = _main }
	}

}