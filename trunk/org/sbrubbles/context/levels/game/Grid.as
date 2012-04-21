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

	public class Grid extends MovieClip {
		private static  var CANVAS_WIDTH:Number = 100;
		private static  var CANVAS_HEIGHT:Number = 66;
		private static  var SCALE:Number = 6;
		private static const LINE_RGB:uint = 0x000000;
		private static const LINE_ALPHA:Number = 0.1;

		private var canvas:BitmapData;
		private var nBlocksTotal:Number;
		private var aBlocks:Array;

		private var _stage:Stage
		
		public function Grid(_stage:Stage) {
			this._stage = _stage
			
			var lines:MovieClip = new MovieClip();
			
			lines.graphics.lineStyle(1, LINE_RGB, LINE_ALPHA);
			for (var i:uint = 0; i < CANVAS_WIDTH+1; i++) {
				lines.graphics.moveTo(i*SCALE, 0);
				lines.graphics.lineTo(i*SCALE, CANVAS_HEIGHT * SCALE);
			}
			for (i = 0; i < CANVAS_HEIGHT+1; i++) {
				lines.graphics.moveTo(0, i*SCALE);
				lines.graphics.lineTo(CANVAS_WIDTH * SCALE, i*SCALE);
			}
			//
			canvas = new BitmapData(CANVAS_WIDTH, CANVAS_HEIGHT, false, 0xffffff);
			var bm:Bitmap = new Bitmap(canvas);
			bm.scaleX = bm.scaleY = SCALE;
			this.addChildAt(bm, 0);
			//
			nBlocksTotal = CANVAS_WIDTH * CANVAS_HEIGHT;
			var xstep:Number = 1;
			var ystep:Number = 1;
			aBlocks = new Array();

			for (i =0; i<nBlocksTotal; i++) {
				var p:Point = new Point(xstep,ystep);
				///////////////////////////////////
				var b:Block = new Block(p, canvas);
				aBlocks.push(b);
				/////////////////////////////////
				if ((xstep % CANVAS_WIDTH) == 0) {
					xstep = 0;
					ystep++;
				}
				xstep++;
			}
			//////
			_stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpped);
			
			this.addChildAt(lines,1);
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
		 * @return the block at the given coordinates.
		 */
		public function getBlockAt(x:Number, y:Number):Block
		{
			return aBlocks[(y - 1) * CANVAS_WIDTH + x - 1]
		}
		
		/**
		 * Updates the canvas to the new generation.
		 */
		public function tick():void 
		{	
			var changedBlocks:Array = []
			
			// first, let all blocks calculate their next state, and store the
			// ones who will change
			for (var i:uint = 0; i < nBlocksTotal; i++) {
				if (aBlocks[i].checkRules()) {
					changedBlocks.push(aBlocks[i])
				}
			}
			
			// then update all the blocks that changed
			for (var j:uint = 0; j < changedBlocks.length; j++) {
				changedBlocks[j].update();
			}
		}
		
		// === patterns ===
		/**
		 * Adds a glider to the canvas at the given coordinates. 
		 * A glider is the pattern below, with . representing an empty cell and x a live one:
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
			getBlockAt(x+1, y).state = Block.LIVE
			getBlockAt(x+2, y+1).state = Block.LIVE
			getBlockAt(x, y+2).state = Block.LIVE
			getBlockAt(x+1, y+2).state = Block.LIVE
			getBlockAt(x+2, y+2).state = Block.LIVE
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
			getBlockAt(x, y+2).state = Block.LIVE
			getBlockAt(x+1, y).state = Block.LIVE
			getBlockAt(x+1, y+2).state = Block.LIVE
            getBlockAt(x+3, y+1).state = Block.LIVE
            getBlockAt(x+4, y+2).state = Block.LIVE
            getBlockAt(x+5, y+2).state = Block.LIVE
            getBlockAt(x+6, y+2).state = Block.LIVE
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
	}
}