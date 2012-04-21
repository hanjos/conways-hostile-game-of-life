package org.sbrubbles 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.levels.ColoredContext;
	import org.sbrubbles.context.levels.game.Game;
	import org.sbrubbles.context.levels.mainmenu.MainMenu;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.systems.Input;
	
	/**
	 * The main class in the FLA, used to start the game.
	 * 
	 * @author Humberto Anjos
	 */
	public class Main extends MovieClip
	{
		public static const MAIN_MENU:String = "MAIN_MENU"
		public static const GAME:String = "GAME"
		
		private var _contexts:Contexts
		private var _input:Input
		
		public function Main() 
		{
			_input = new Input(this)
			_contexts = new Contexts()
			
			start()
		}
		
		/**
		 * Loads and readies all of the game's systems, hooking up all the
		 * needed callbacks and creating and registering the contexts.
		 */
		private function start():void
		{
			// set the main update callback for all systems
			stage.addEventListener(Event.ENTER_FRAME, update, false, 0, true)
			
			// configure starting values for inputs
			// TODO
			
			// register all game contexts
			_contexts.register(MAIN_MENU, new MainMenu(this))
			_contexts.register(GAME, new Game(this))
			
			_contexts.register("G", new ColoredContext(this, 0x00FF00))
			_contexts.register("B", new ColoredContext(this, 0x0000FF))
			
			// active the main one
			_contexts.activate(MAIN_MENU)
			
			// draw
			draw()
		}
		
		private function draw():void
		{
			
		}
		
		// events
		private function update(e:Event):void 
		{
			// process global input
			_input.update()
			
			// update current context
            _contexts.update()
			
			// check input
			checkInput()
		}
		
		private function checkInput()
		{
			/* TODO remove */
			if (_input.isPressed(Keyboard.R)) {
				_contexts.activate(MAIN_MENU)
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