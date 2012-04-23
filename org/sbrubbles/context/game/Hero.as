package org.sbrubbles.context.game 
{
	import flash.geom.Point;
	import org.sbrubbles.gameoflife.Block;
	import org.sbrubbles.gameoflife.Grid;
	/**
	 * The hero controlled by the player.
	 * 
	 * @author Humberto Anjos
	 */
	public class Hero 
	{
		private var MAX_HEALTH:Number
		private var _width:int = 2
		private var _height:int = 2
		private var _color:uint = 0xFF0000
		private var _alpha:uint = 0xFF
		
		private var _position:Point
		private var _grid:Grid
		private var _health:Number
		
		public function Hero(position:Point, grid:Grid, maxHealth:Number) 
		{
			this._position = position
			this._grid = grid
			this.MAX_HEALTH = maxHealth
			this._health = maxHealth
		}
		
		// === operations ===
		public function update()
		{
			// draws itself on the grid
			draw()
		}
		
		private function draw()
		{
			var x:Number = _position.x
			var y:Number = _position.y
			
			var argb:uint = addAlphaTo(_alpha, _color)
			_grid.canvas.setPixel32(x, y, argb); 	 _grid.canvas.setPixel32(x + 1, y, argb)
			_grid.canvas.setPixel32(x, y + 1, argb); _grid.canvas.setPixel32(x + 1, y + 1, argb)
		}
		
		/**
		 * Heals the hero by the given amount, up to its maximum health. Or, 
		 * if the given amount is negative, decreases the hero's health down to
		 * 0.
		 * 
		 * @param hp the amount of health points healed.
		 */
		public function heal(hp:Number):void
		{
			_health = Math.min(MAX_HEALTH, Math.max(_health + hp, 0))
			_alpha = (uint) (0xFF * _health / MAX_HEALTH)
		}
		
		public function getBlocksBelow():Vector.<Block>
		{
			var x:Number = _position.x
			var y:Number = _position.y
			
			return _grid.getBlocksAt(new Point(x, y), new Point(x + 1, y), new Point(x, y + 1), new Point(x + 1, y + 1))
		}
		
		public function reset():void
		{
			_health = MAX_HEALTH
		}
		
		private function addAlphaTo(alpha:uint, rgb:uint):uint
		{
			return (alpha * (1 << 24)) | rgb
		}
		
		// === properties ===
		public function get position():Point { return _position }
		public function get grid():Grid { return _grid }
		public function get maxHealth():Number { return MAX_HEALTH }
		public function get health():Number { return _health }
		public function get width():Number { return _width }
		public function get height():Number { return _height }
	}

}