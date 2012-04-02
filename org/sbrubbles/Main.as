package org.sbrubbles 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.sbrubbles.contexts.Context;
	import org.sbrubbles.context.Game;
	
	/**
	 * A classe chamada pelo FLA.
	 * 
	 * @author Humberto Anjos
	 */
	public class Main extends MovieClip
	{
		private var _container:DisplayObjectContainer
		private var _contexts:Contexts
		
		public function Main() 
		{
			_container = new MovieClip()
			_contexts = new Contexts()
			
			addChild(_container)
			
			start()
		}
		
		public function start():void
		{
			// set update callback
			stage.addEventListener(Event.ENTER_FRAME, update)
			
			// configure starting values for inputs
			
			// set context
			_contexts.current = new Game()
			
			// draw
			draw()
		}
		
		public function draw():void
		{
			
		}
		
		// events
		private function update(e:Event):void 
		{
			// process global input
			//Input.onUpdate();
			
			// update level
            _contexts.update();
		}
		
		// propriedades
		public function get container() { return _container }
		public function get contexts() { return _contexts }
	}

}