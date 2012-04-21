/*
Originally stolen from http://www.interactionfigure.nl/2008/conways-game-of-life-in-flash/, with several modifications.
I hope the author doesn't mind...
*/
package nl.interactionfigure.gameoflife {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Block {
		public static var LIVE:Number = 0x000000;
		public static var DEAD:Number = 0xFFFFFF;
		
		private var pPosition:Point;
		private var canvas:BitmapData;
		private var aOffsetPoints:Array;
		private var nCurrentColour:Number;
		private var nNextColour:Number;
		
		public function Block(_pos:Point, _canvas:BitmapData){
			pPosition = _pos;
			canvas = _canvas;
			
			aOffsetPoints = new Array();
			aOffsetPoints.push(pPosition.add(new Point(-1, -1)));
			aOffsetPoints.push(pPosition.add(new Point(0, -1)));
			aOffsetPoints.push(pPosition.add(new Point(1, -1)));
			aOffsetPoints.push(pPosition.add(new Point(-1, 0)));
			aOffsetPoints.push(pPosition.add(new Point(1, 0)));
			aOffsetPoints.push(pPosition.add(new Point(-1, 1)));
			aOffsetPoints.push(pPosition.add(new Point(0, 1)));
			aOffsetPoints.push(pPosition.add(new Point(1, 1)));
			
			var temp:Array = new Array();
			//var r:Rectangle = new Rectangle(1,1,canvas.rect.width -2,canvas.rect.height -2);
			var r:Rectangle = canvas.rect;
			for(var i:uint =0;i<aOffsetPoints.length;i++){
				if(r.containsPoint(aOffsetPoints[i])){
					temp.push(aOffsetPoints[i]);
				}
			}
			aOffsetPoints = temp;
			nCurrentColour = DEAD;
		}
		public function checkRules():void {
			/*
			   1. Any live cell with fewer than two live neighbours dies, as if by loneliness.
			   2. Any live cell with more than three live neighbours dies, as if by overcrowding.
			   3. Any live cell with two or three live neighbours lives, unchanged, to the next generation.
			   4. Any dead cell with exactly three live neighbours comes to life.
			*/
			var neighbourcount:Number = 0;
			
			for(var i:uint =0;i<aOffsetPoints.length;i++){
				if(canvas.getPixel(aOffsetPoints[i].x, aOffsetPoints[i].y) == LIVE){
					neighbourcount++;
				}
			}
			
			if((neighbourcount == 2) && (nCurrentColour == LIVE)){				
				nNextColour = LIVE;									
			} else if((neighbourcount == 3) && (nCurrentColour == LIVE)){				
				nNextColour = LIVE;									
			} else if((neighbourcount == 3) && (nCurrentColour == DEAD)){				
				nNextColour = LIVE;									
			} else {
				nNextColour = DEAD;	
			}
		}
		public function update():void {
			canvas.setPixel(pPosition.x, pPosition.y, nNextColour);
			nCurrentColour = nNextColour;
		}
		public function get position():Point {
			return pPosition;
		}
		public function setColor(color:Number):void {
			nCurrentColour = color;
			canvas.setPixel(pPosition.x, pPosition.y, nCurrentColour);
		}
		public function toggleColor():void {
			if(nCurrentColour == DEAD){
				nCurrentColour = LIVE;
			}else{
				nCurrentColour = DEAD;
			}
			canvas.setPixel(pPosition.x, pPosition.y, nCurrentColour);
		}
	}
}