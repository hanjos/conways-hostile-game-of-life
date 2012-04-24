package org.sbrubbles.systems 
{
	import flash.display.Stage;
	import flash.geom.Point;
	import org.sbrubbles.context.game.Hero;
	import org.sbrubbles.gameoflife.Block;
	import org.sbrubbles.gameoflife.Grid;
	import org.sbrubbles.gameoflife.Map;
	
	/**
	 * Holds game state shared between contexts.
	 * 
	 * @author Humberto Anjos
	 */
	public class GameState
	{
		private var _grid:Grid
		private var _hero:Hero
		private var _activeMap:String
		
		public function GameState()
		{
			reset()
		}
		
		/**
		 * Resets this object's fields to their original values.
		 */
		public function reset()
		{
			// clearing previous values
			if (_grid != null) {
				_grid.clear()
			}
			
			// setting the default ones
			_grid = new Grid()
			_hero = null
			
			// loading the map
			var map:Map = Maps.named(_activeMap)
			if (map != null) {
				map.applyOn(_grid)
				_hero = new Hero(map.start.clone(), _grid, 10) // FAIL Point is mutable; must make a clone
			}
		}
		
		public function loadMap(mapName:String):void
		{
			_activeMap = mapName
			
			reset()
		}
		
		// === properties ===
		public function get grid():Grid { return _grid }
		public function get hero():Hero { return _hero }
		public function get activeMap():String { return _activeMap }
	}
}