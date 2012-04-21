package org.sbrubbles.context.levels.game 
{
	import flash.geom.Point;
	import org.sbrubbles.context.Context;
	import org.sbrubbles.context.levels.game.states.DeadHero;
	import org.sbrubbles.context.levels.game.states.Playing;
	import org.sbrubbles.Main;
	import flash.ui.Keyboard;
	import org.sbrubbles.systems.Contexts;
	import org.sbrubbles.systems.Input;
	
	/**
	 * The context holding the game. Holds its own context manager, since the 
	 * game has its own subcontexts.
	 * 
	 * @author Humberto Anjos
	 */
	public class Game extends Context
	{
		public static const PLAYING = "PLAYING"
		public static const DEAD_HERO = "DEAD-HERO"
		
		private var _grid:Grid
		private var _hero:Hero
		private var _contexts:Contexts
		
		public function Game(main:Main) 
		{
			super(main);
			
			_contexts = new Contexts()
			_contexts.register(PLAYING, new Playing(this))
			_contexts.register(DEAD_HERO, new DeadHero(this))
			
			_contexts.activate(PLAYING)
		}
		
		// === context operations ===
		public override function update():void
		{
			// update the current context
			contexts.update()
		}
		
		/**
		 * Resets this object's fields to their original values.
		 */
		public function reset()
		{
			_grid = null
			_hero = null
		}
		
		// === properties ===
		public function get grid():Grid 
		{ 
			if (_grid == null) {
				_grid = new Grid(owner.stage)
			}
			
			return _grid 
		}
		
		public function get hero():Hero
		{
			if (_hero == null) {
				_hero = new Hero(new Point(0, 0), grid, 8)
			}
			
			return _hero
		}
		
		public function get contexts():Contexts { return _contexts }
		public function get input():Input { return owner.input }
	}
}