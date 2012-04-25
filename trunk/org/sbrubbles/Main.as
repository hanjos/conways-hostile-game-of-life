package org.sbrubbles 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.sbrubbles.context.game.ActiveGame;
	import org.sbrubbles.context.game.DeadHero;
	import org.sbrubbles.context.game.Win;
	import org.sbrubbles.context.instructions.Instructions;
	import org.sbrubbles.context.mainmenu.MainMenu;
	import org.sbrubbles.context.mapeditor.MapEditor;
	import org.sbrubbles.gameoflife.Block;
	import org.sbrubbles.gameoflife.Map;
	import org.sbrubbles.gameoflife.Pattern;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.systems.GameState;
	import org.sbrubbles.systems.Input;
	import org.sbrubbles.systems.Maps;
	
	/**
	 * The main class in the FLA, used to start the game and provide global 
	 * systems for the contexts to use. 
	 * 
	 * @author Humberto Anjos
	 * @see Context
	 */
	public class Main extends MovieClip
	{
		// === context names ===
		public static const MAIN_MENU:String = "MAIN_MENU"
		public static const INSTRUCTIONS:String = "INSTRUCTIONS"
		public static const GAME:String = "ACTIVE_GAME"
		public static const DEAD_HERO:String = "DEAD_HERO"
		public static const WIN:String = "WIN"
		public static const MAP_EDITOR:String = "MAP_EDITOR"
		
		// === map names ===
		public static const GUNS_BLAZING:String = "guns_blazing"
		
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
			Contexts.register(INSTRUCTIONS, new Instructions(this))
			Contexts.register(GAME, new ActiveGame(this))
			Contexts.register(DEAD_HERO, new DeadHero(this))
			Contexts.register(WIN, new Win(this))
			Contexts.register(MAP_EDITOR, new MapEditor(this))
			
			// register all known maps
			Maps.register(GUNS_BLAZING, gunsBlazingMap())
			
			// load the only known map
			gameState.loadMap(GUNS_BLAZING)
			
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
		
		private function gunsBlazingMap():Map
		{
			var map:Map = new Map(100, 100)
			
			map.setAt(Block.LIVE, Pattern.PULSAR.startingFrom(17, 68))
			map.setAt(Block.LIVE, Pattern.PULSAR.startingFrom(23, 20))
			map.setAt(Block.LIVE, Pattern.PULSAR.startingFrom(20, 44))
			
			// spaceship travelling down
			var spaceshipGoingDown:Pattern = new Pattern([ 
				new Point(0, 3), new Point(1, 4), new Point(2, 4), new Point(3, 4),
				new Point(3, 3), new Point(3, 2), new Point(3, 1), new Point(2, 0)])
				
			map.setAt(Block.LIVE, spaceshipGoingDown.startingFrom(6, 70)) // XXX starting from x=6, y=70 the spaceship bounces off the glider gun harmlessly
			
			map.setAt(Block.LIVE, Pattern.GOSPER_GLIDER_GUN.startingFrom(17, 82))
			map.setAt(Block.LIVE, Pattern.GOSPER_GLIDER_GUN.startingFrom(23, 57))
			map.setAt(Block.LIVE, Pattern.GOSPER_GLIDER_GUN.startingFrom(31, 33))
			map.setAt(Block.LIVE, Pattern.GOSPER_GLIDER_GUN.startingFrom(41, 9))
			
			map.setAt(Block.END, Pattern.rectangle(2, 4).startingFrom(98, 79))
				
			map.start = new Point(0, 98)
			
			return map
		}
	}

}