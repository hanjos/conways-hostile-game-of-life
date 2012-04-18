/*
Stolen from http://www.interactionfigure.nl/2008/conways-game-of-life-in-flash/, with some modifications.
I hope the author doesn't mind...
*/
package nl.interactionfigure.gameoflife {
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class EternalConway extends MovieClip {
		private static  var CANVAS_WIDTH:Number = 100;
		private static  var CANVAS_HEIGHT:Number = 66;
		private static  var SCALE:Number = 6;
		private static const LINE_RGB:uint = 0x000000;
		private static const LINE_ALPHA:Number = 0.2;

		private var canvas:BitmapData;
		private var nBlocksTotal:Number;
		private var aBlocks:Array;

		private var _stage:Stage
		
		public function EternalConway(_stage:Stage) {
			this._stage = _stage
			
			var lines:MovieClip = new MovieClip();
			
			lines.graphics.lineStyle(1,LINE_RGB, LINE_ALPHA);
			for (var i:uint =0; i<CANVAS_WIDTH; i++) {
				lines.graphics.moveTo(i*SCALE, 0);
				lines.graphics.lineTo(i*SCALE, CANVAS_HEIGHT * SCALE);
			}
			for (i =0; i<CANVAS_HEIGHT; i++) {
				lines.graphics.moveTo(0, i*SCALE);
				lines.graphics.lineTo(CANVAS_WIDTH * SCALE, i*SCALE);
			}
			//
			canvas = new BitmapData(CANVAS_WIDTH,CANVAS_HEIGHT,false,0xffffff);
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
			this.addEventListener(Event.ENTER_FRAME, updateFrame);
			_stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpped);
			
			this.addChildAt(lines,1);
		}
		
		private function clearCanvas(e:MouseEvent):void {
			for (var i:uint =0; i<nBlocksTotal; i++) {
				aBlocks[i].setColor(Block.DEAD);
			}
		}
		
		private function mouseUpped(e:MouseEvent):void {
			var p:Point = new Point(Math.floor(this.mouseX / SCALE), Math.floor(this.mouseY / SCALE));
			
			/*
			for (var i:uint =0; i<nBlocksTotal; i++) {
				if ((aBlocks[i].position.x == p.x) && (aBlocks[i].position.y == p.y)) {
					aBlocks[i].toggleColour();
				}
			}
			*/
			
			aBlocks[(p.y - 1) * CANVAS_WIDTH + p.x - 1].toggleColour()
		}
		
		private function updateFrame(e:Event):void {			
			/*
			for (var i:uint =0; i<nBlocksTotal; i++) {
				aBlocks[i].checkRules();
			}
			for (i =0; i<nBlocksTotal; i++) {
				aBlocks[i].setBlock();
			}
			*/
		}
	}
}