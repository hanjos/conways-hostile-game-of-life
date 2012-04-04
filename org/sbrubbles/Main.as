package org.sbrubbles 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.ColoredContext;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.context.Game;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.systems.Input;
	
	/**
	 * A classe chamada pelo FLA.
	 * 
	 * @author Humberto Anjos
	 */
	public class Main extends MovieClip
	{
		private var _contexts:Contexts
		private var _input:Input
		
		public function Main() 
		{
			_input = new Input(this)
			_contexts = new Contexts(this)
			
			start()
		}
		
		public function start():void
		{
			// set update callback
			stage.addEventListener(Event.ENTER_FRAME, update, false, 0, true)
			
			// configure starting values for inputs
			
			// set context
			_contexts.register("R", new ColoredContext(this, 0xFF0000))
			_contexts.register("G", new ColoredContext(this, 0x00FF00))
			_contexts.register("B", new ColoredContext(this, 0x0000FF))
			
			_contexts.activate("R")
			
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
			_input.update()
			
			// update context
            _contexts.update()
			
			// check input
			checkInput()
		}
		
		private function checkInput()
		{
			/* TODO remove */
			if (_input.isPressed(Keyboard.R)) {
				_contexts.activate("R")
			} else if (_input.isPressed(Keyboard.G)) {
				_contexts.activate("G")
			} else if (_input.isPressed(Keyboard.B)) {
				_contexts.activate("B")
			} 
			/**/
		}
		
		// properties
		public function get contexts() { return _contexts }
		public function get input() { return _input }
	}

}