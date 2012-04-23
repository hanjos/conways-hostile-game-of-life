package org.sbrubbles 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.sbrubbles.context.Contexts;
	import org.sbrubbles.context.game.ActiveGame;
	import org.sbrubbles.context.game.DeadHero;
	import org.sbrubbles.context.game.GameState;
	import org.sbrubbles.context.game.Win;
	import org.sbrubbles.context.mainmenu.MainMenu;
	import org.sbrubbles.context.mapeditor.MapEditor;
	
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
		public static const GAME:String = "ACTIVE_GAME"
		public static const DEAD_HERO:String = "DEAD_HERO"
		public static const WIN:String = "WIN"
		public static const MAP_EDITOR:String = "MAP_EDITOR"
		
		private var _gameState:GameState
		
		public function Main() 
		{
			_gameState = new GameState()
			
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
			
			// start input capturing
			Input.init(stage)
			
			// register all game contexts
			Contexts.register(MAIN_MENU, new MainMenu(this))
			Contexts.register(GAME, new ActiveGame(this))
			Contexts.register(DEAD_HERO, new DeadHero(this))
			Contexts.register(WIN, new Win(this))
			Contexts.register(MAP_EDITOR, new MapEditor(this))
			
			// go to the main menu
			Contexts.goTo(MAIN_MENU)
		}
		
		// === event handling ===
		private function update(e:Event):void 
		{
			// process global input
			Input.update()
			
			// update current context
            Contexts.update()
		}
		
		// === properties ===
		/** @return the shared game state. */
		public function get gameState():GameState { return _gameState }
	}

}