/*
Originally stolen from http://www.interactionfigure.nl/2008/conways-game-of-life-in-flash/, with several modifications.
I hope the author doesn't mind...
*/
package org.sbrubbles.gameoflife {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Represents a single block in a Conway's Game of Life grid.
	 * 
	 * @author Humberto Anjos
	 */
	public class Block {
		// === states ===
		/** The color (RGB) used for a LIVE block. */
		public static var LIVE:Number = 0x000000;
		
		/** The color (RGB) used for a DEAD block. */
		public static var DEAD:Number = 0xFFFFFF;
		
		/** The color (RGB) used for a END block. */
		public static var END:Number = 0x0000FF;
		
		// === fields ===
		private var _position:Point;
		private var _map:BitmapData;
		private var _neighbors:Array; // <Point>
		private var _currentState:Number;
		private var _nextState:Number;
		
		/**
		 * Makes a new block, which represents the pixel at the given position
		 * in the given canvas.
		 * 
		 * @param position this block's position.
		 * @param canvas the canvas where this block is drawn.
		 */
		public function Block(position:Point, map:BitmapData){
			_position = position;
			_map = map;
			
			_neighbors = [
				_position.add(new Point( -1, -1)),
				_position.add(new Point(0, -1)),
				_position.add(new Point(1, -1)),
				_position.add(new Point( -1, 0)),
				_position.add(new Point(1, 0)),
				_position.add(new Point( -1, 1)),
				_position.add(new Point(0, 1)),
				_position.add(new Point(1, 1))
			]
			
			var temp:Array = new Array();
			var r:Rectangle = map.rect;
			for(var i:uint = 0; i < _neighbors.length; i++) {
				if(r.containsPoint(_neighbors[i])) {
					temp.push(_neighbors[i]);
				}
			}
			
			_neighbors = temp;
			_currentState = DEAD;
		}
		
		// === operations ===
		/**
		 * Applies the Game of Life rules to calculate this block's next state,
		 * but without actually changing it; the new state will be changed only
		 * when update() is called.
		 * 
		 * The rules used here are:
		 * 1. Any live cell with fewer than two live neighbors dies, as if by loneliness.
		 * 2. Any live cell with more than three live neighbors dies, as if by overcrowding.
		 * 3. Any live cell with two or three live neighbors lives, unchanged, to the next generation.
		 * 4. Any dead cell with exactly three live neighbors comes to life.
		 * 5. Other states are left unchanged.
		 * 
		 * @return true if the next state is different from the current state; false otherwise.
		 * @see update
		 */
		public function checkRules():Boolean {
			var liveNeighborCount:Number = 0
			
			for(var i:uint = 0; i < _neighbors.length; i++) {
				if(_map.getPixel(_neighbors[i].x, _neighbors[i].y) == LIVE) {
					liveNeighborCount++
				}
			}
			
			if (_currentState == LIVE && liveNeighborCount < 2) { // loneliness
				_nextState = DEAD
			} else if (_currentState == LIVE && liveNeighborCount > 3) { // overcrowding
				_nextState = DEAD
			} else if (_currentState == LIVE && (liveNeighborCount == 2 || liveNeighborCount == 3)) { // unchanged
				_nextState = LIVE
			} else if (_currentState == DEAD && liveNeighborCount == 3) { // rise, my son
				_nextState = LIVE
			} else { // preserve the current state
				_nextState = _currentState
			}
			
			return _currentState != _nextState
		}
		
		/**
		 * Swaps the block to the new state, which must have been 
		 * pre-calculated before this invocation.
		 * 
		 * @see checkRules
		 */
		public function update():void {
			_map.setPixel(_position.x, _position.y, _nextState);
			_currentState = _nextState;
		}
		
		public function toggleState():void
		{
			if (state == LIVE) {
				state = DEAD
			} else if (state == DEAD) {
				state = LIVE
			}
		}
		
		// === properties ===
		/**
		 * @return this block's position in the grid.
		 */
		public function get position():Point {
			return _position;
		}
		
		/**
		 * @return this block's current state.
		 */
		public function get state():Number { return _currentState }
		
		/**
		 * Sets this block's current state as the given one.
		 * 
		 * @param state the new state
		 */
		public function set state(state:Number):void {
			_currentState = state;
			_map.setPixel(_position.x, _position.y, _currentState);
		}
	}
}