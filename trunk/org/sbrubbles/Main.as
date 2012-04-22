package org.sbrubbles 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import org.sbrubbles.context.levels.ColoredContext;
	import org.sbrubbles.context.levels.game.GameState;
	import org.sbrubbles.context.levels.game.DeadHero;
	import org.sbrubbles.context.levels.game.ActiveGame;
	import org.sbrubbles.context.levels.game.Win;
	import org.sbrubbles.context.levels.mainmenu.MainMenu;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.systems.Input;
	
	/**
	 * The main class in the FLA, used to start the game and provide global 
	 * systems for the contexts to use. 
	 * 
	 * @author Humberto Anjos
	 * @see Context
	 */
	public class Main extends MovieClip
	{
		public static const MAIN_MENU:String = "MAIN_MENU"
		public static const ACTIVE_GAME:String = "ACTIVE_GAME"
		public static const DEAD_HERO:String = "DEAD_HERO"
		public static const WIN:String = "WIN"
		
		private var _contexts:Contexts
		private var _input:Input
		private var _gameState:GameState
		
		public function Main() 
		{
			_input = new Input(this)
			_contexts = new Contexts()
			_gameState = new GameState(stage)
			
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
			
			// register all game contexts
			_contexts.register(MAIN_MENU, new MainMenu(this))
			_contexts.register(ACTIVE_GAME, new ActiveGame(this))
			_contexts.register(DEAD_HERO, new DeadHero(this))
			_contexts.register(WIN, new Win(this))
			
			// active the main one
			_contexts.goTo(MAIN_MENU)
		}
		
		// === event handling ===
		private function update(e:Event):void 
		{
			// process global input
			_input.update()
			
			// update current context
            _contexts.update()
		}
		
		// === properties ===
		/** @return the context manager. */
		public function get contexts() { return _contexts }
		
		/** @return the input manager. */
		public function get input() { return _input }
		
		/** @return the shared game state. */
		public function get gameState() { return _gameState }
	}

}