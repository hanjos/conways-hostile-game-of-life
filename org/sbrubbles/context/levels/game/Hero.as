package org.sbrubbles.context.levels.game 
{
	import flash.geom.Point;
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
			// draw on the grid
			draw()
			
			// check grid for "collision"
			var blocksBelow:Vector.<Block> = getBlocksBelow()
			var isLive:Function = function (item:Block, index:int, vector:Vector.<Block>) { return item != null && item.state == Block.LIVE } 
			
			if (blocksBelow.some(isLive)) { // hit detected!
				heal(-1)
			}
		}
		
		private function draw()
		{
			var x:Number = _position.x
			var y:Number = _position.y
			
			var argb:uint = addAlphaTo(_alpha, _color)
			_grid.canvas.setPixel32(x, y, argb); 	 _grid.canvas.setPixel32(x + 1, y, argb)
			_grid.canvas.setPixel32(x, y + 1, argb); _grid.canvas.setPixel32(x + 1, y + 1, argb)
		}
		
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
	}

}