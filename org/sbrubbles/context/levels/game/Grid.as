/*
Originally stolen from http://www.interactionfigure.nl/2008/conways-game-of-life-in-flash/, with several modifications.
I hope the author doesn't mind...
*/
package org.sbrubbles.context.levels.game {
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * Represents the game's world, which is a grid composed of blocks which 
	 * may hold several states.
	 * 
	 * @author Humberto Anjos
	 * @see Block
	 */
	public class Grid extends MovieClip {
		private static  var WIDTH:Number = 100;
		private static  var HEIGHT:Number = 100;
		private static  var SCALE:Number = 5;
		private static const LINE_RGB:uint = 0x000000;
		private static const LINE_ALPHA:Number = 0.1;

		private var _map:BitmapData;
		private var _canvas:BitmapData;
		private var nBlocksTotal:Number;
		private var aBlocks:Array;

		private var _stage:Stage
		
		public function Grid(_stage:Stage) {
			this._stage = _stage
			
			var lines:MovieClip = new MovieClip();
			
			lines.graphics.lineStyle(1, LINE_RGB, LINE_ALPHA);
			for (var i:uint = 0; i < WIDTH+1; i++) {
				lines.graphics.moveTo(i*SCALE, 0);
				lines.graphics.lineTo(i*SCALE, HEIGHT * SCALE);
			}
			for (i = 0; i < HEIGHT+1; i++) {
				lines.graphics.moveTo(0, i*SCALE);
				lines.graphics.lineTo(WIDTH * SCALE, i*SCALE);
			}
			//
			_map = new BitmapData(WIDTH, HEIGHT, false, 0xffffff);
			var bm:Bitmap = new Bitmap(_map);
			bm.scaleX = bm.scaleY = SCALE;
			this.addChildAt(bm, 0);
			//
			nBlocksTotal = WIDTH * HEIGHT;
			var xstep:Number = 0;
			var ystep:Number = 0;
			aBlocks = new Array();

			for (i = 0; i < nBlocksTotal; i++) {
				var p:Point = new Point(xstep, ystep);
				///////////////////////////////////
				var b:Block = new Block(p, _map);
				aBlocks.push(b);
				/////////////////////////////////
				
				xstep++;
				if ((xstep % WIDTH) == 0) {
					xstep = 0;
					ystep++;
				}
			}
			//////
			_stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpped);
			
			this.addChildAt(lines, 1);
			//
			_canvas = new BitmapData(WIDTH, HEIGHT, true, 0)
			var bm2:Bitmap = new Bitmap(_canvas)
			bm2.scaleX = bm2.scaleY = SCALE
			this.addChildAt(bm2, 2);
		}
		
		// === canvas operations ===
		/**
		 * Clears the canvas.
		 */
		public function clear():void {
			for (var i:uint = 0; i < nBlocksTotal; i++) {
				aBlocks[i].state = Block.DEAD;
			}
		}
		
		/**
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 * @return the block at the given coordinates or null if there is none.
		 */
		public function getBlockAt(x:Number, y:Number):Block
		{
			if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT)
				return null
				
			return aBlocks[y * WIDTH + x]
		}
		
		/**
		 * @param positions a series of points indicating the blocks to get.
		 * @return the blocks at the given coordinates, in the order given. 
		 */
		public function getBlocksAt(...positions):Vector.<Block>
		{
			var result:Vector.<Block> = new Vector.<Block>()
			
			for (var i:int = 0; i < positions.length; i++) {
				var p:Point = positions[i]
				
				result.push(getBlockAt(p.x, p.y))
			}
			
			return result
		}
		
		/**
		 * Sets the state of all the blocks in the given position to the given
		 * state.
		 * 
		 * @param state the new state.
		 * @param positions a series of Points holding the positions of the blocks.
		 */
		public function setBlocksAs(state:Number, ...positions):void
		{
			for (var i:uint = 0; i < positions.length; i++) {
				var block = getBlockAt(positions[i].x, positions[i].y)
				if (block != null && (block.state == Block.LIVE || block.state == Block.DEAD))
					block.state = state
			}
		}
		
		/**
		 * Updates the grid to the new generation, taking into account the 
		 * hero's presence.
		 */
		public function update():void 
		{	
			// first, update the map
			//// calculate all blocks' next states, and store those who'll 
			//// change
			var changed:Vector.<Block> = new Vector.<Block>()
			
			for (var i:uint = 0; i < nBlocksTotal; i++) {
				if (aBlocks[i].checkRules()) {
					changed.push(aBlocks[i])
				}
			}
			
			//// then update only the changed blocks
			for (var j:uint = 0; j < changed.length; j++) {
				changed[j].update()
			}
			
			// second, clear the canvas; the hero will draw himself here later 
			// on
			_canvas.fillRect(_canvas.rect, 0x00000000)
		}
		
		// === patterns ===
		/**
		 * Adds a glider to the canvas at the given coordinates. 
		 * A glider is the pattern below, with . representing an empty cell 
		 * and x a live one:
		 * .x.
		 * ..x
		 * xxx
		 * 
		 * The given coordinates indicate the top left block.
		 * 
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 */
		private function addGliderAt(x:Number, y:Number):void
		{
			setBlocksAs(Block.LIVE,
				new Point(x + 1, y),
				new Point(x + 2, y + 1),
				new Point(x, y + 2),
				new Point(x + 1, y + 2),
				new Point(x + 2, y + 2))
		}
		
		/**
		 * Adds an acorn to the canvas at the given coordinates.
		 * An acorn is the pattern below, with . representing an empty cell and x a live one:
		 * .x.....
		 * ...x...
		 * xx..xxx
		 * 
		 * The given coordinates indicate the top left block.
		 * 
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 */
		private function addAcornAt(x:Number, y:Number):void
		{
			setBlocksAs(Block.LIVE,
				new Point(x, y + 2),
				new Point(x + 1, y),
				new Point(x + 1, y + 2),
				new Point(x + 3, y + 1),
				new Point(x + 4, y + 2),
				new Point(x + 5, y + 2),
				new Point(x + 6, y + 2))
		}
		
		// === event handling ===
		private function mouseUpped(e:MouseEvent):void 
		{
			var x: Number = Math.floor(this.mouseX / SCALE)
			var y: Number = Math.floor(this.mouseY / SCALE)
			
			if(Math.random() > 0.5) {
				addGliderAt(x, y)
			} else {
				addAcornAt(x, y)
			}
		}
		
		// === properties ===
		public function get map():BitmapData { return _map }
		public function get canvas():BitmapData { return _canvas }
		public function get gridWidth():Number { return WIDTH }
		public function get gridHeight():Number { return HEIGHT }
	}
}