/*
Code gleefully stolen from http://www.stdio.co.uk/blog/actionscript/conways-game-of-life/, 
and slightly adapted to take an outside stage.

I hope the author doesn't mind...
*/

/*
Conway's Game of Life using a convolution filter and a palette map.
 
In the game of life, cells live or die depending on how many live neighbours
they have. In this version, pixels represent cells and the eight pixels around
every pixel are considered to be the cell's neighbours.
 
A convolution filter takes the job of adding up each pixel's number of live
neighbours and setting the pixel's colour to a value that represents that
value. After this, the pixels are palette mapped so the correct pixels are
kept alive. The process is repeated to animate the Game of Life.
 
The four rules controlling the system are:
1. Fewer than two live neighbours and the cell dies (Loneliness)
2. Greater than three live neighbours and the cell dies (Overcrowding)
3. Exactly three live neighbours and the cell comes to life (Creation)
4. Exactly two live neighbours and the cell stays how it is (Stasis)
 
Alistair Macdonald
http://www.stdio.co.uk/blog
*/
 
package org.sbrubbles.context.levels {
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
	import flash.display.Stage;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.ConvolutionFilter;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    public class SimpleConway extends Sprite {
        
        private static const ALIVE_COLOUR:uint = 0xFFFF0000;
        private static const DEAD_COLOUR:uint = 0x00000000;
        private static const DISPLAY_SCALE:Number = 5;
        // Bitmap that is shown in the display list.
        private var displayContainer:Bitmap;
        // Bitmap that is used to hold the state of the pixels.
        private var state:BitmapData;
        // Filter used to determine how many 
        // alive neighbours a pixel has.
        private var countNeighbours:ConvolutionFilter;
        // Palette map array used to apply the rules of creation, destruction
        // and stasis on the state bitmap after countNeighbours has been applied.
        private var applyConwayRules:Array;
        // Pre-instantated objects do avoid object creation 
        // during the main event loop.
        private var point:Point = new Point();
        private var rect:Rectangle = new Rectangle();
 
		private var _stage:Stage
		
        public function SimpleConway(_stage:Stage) {
            var w:int = _stage.stageWidth / DISPLAY_SCALE;
            var h:int = _stage.stageHeight / DISPLAY_SCALE;
            
            rect.width = w;
            rect.height = h;
            
            state = new BitmapData(w, h, true, DEAD_COLOUR);
            displayContainer = new Bitmap(state);
            displayContainer.scaleX = DISPLAY_SCALE;
            displayContainer.scaleY = DISPLAY_SCALE;
            addChild(displayContainer);
            
            /* Convolution filter which counts the number of alive neighbours a pixel has. Note the value of 0.5 applied to the source pixel. This allows the filter to carry the state of the state of the source pixel through so the stasis rule can be applied. */
            countNeighbours = new ConvolutionFilter(3, 3, [1, 1, 1, 1, 0.5, 1, 1, 1, 1], 8, 0, false);
            // Palette map, used after applying countNeighbours to convert from 
            // the pixels' values to their alive or dead colours.
            applyConwayRules = new Array(256);
            // Set values which must be counted as alive. All other values
            // will be counted as dead.
            // source pixel is alive and has 2 alive neighbours (stasis)
            applyConwayRules[0x4D] = ALIVE_COLOUR;
            // source pixel is alive and has 3 alive neighbours (creation)
            applyConwayRules[0x6E] = ALIVE_COLOUR;
            // source pixel is dead and has 3 alive neighbours (creation)
            applyConwayRules[0x5E] = ALIVE_COLOUR;
            
            _stage.addEventListener(MouseEvent.CLICK, _onClick);
            _stage.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
        }
    
        private function _onClick(e:MouseEvent):void {
            // Draw the "acorn" shape at the mouse position. When scaled,
            // displayContainer can return sub-pixel mouse positions so
            // the value is rounded.
            var x:int = Math.round(displayContainer.mouseX);
            var y:int = Math.round(displayContainer.mouseY);
            state.lock();
            state.setPixel32(x, y, ALIVE_COLOUR);
            state.setPixel32(x-2, y-1, ALIVE_COLOUR);
            state.setPixel32(x-3, y+1, ALIVE_COLOUR);
            state.setPixel32(x-2, y+1, ALIVE_COLOUR);
            state.setPixel32(x+1, y+1, ALIVE_COLOUR);
            state.setPixel32(x+2, y+1, ALIVE_COLOUR);
            state.setPixel32(x+3, y+1, ALIVE_COLOUR);
            state.unlock();
        }
        
        private function _onEnterFrame(e:Event):void {
            state.lock();
            state.applyFilter(state, rect, point, countNeighbours);
            state.paletteMap(state, rect, point, applyConwayRules, applyConwayRules, applyConwayRules, applyConwayRules);
            state.unlock();
        }
    }
}