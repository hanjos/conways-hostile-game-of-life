/*
 * Shamelessly stolen and adapted from DreamKids (http://code.google.com/p/dreamkids/), 
 * who apparently have obtained it somewhere else too :) 
 */

/**
 * Input
 * 
 * @brief   class what handles the keyboardState of the keyboard keys
 * @author  Bruno Miguel de Oliveira Tamer <bmotamer@gmail.com>
 * @version 2012.01.01
 */
package org.sbrubbles
{
	/**
	 * Libraries
	 */
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public final class Input
	{
		/**
		 * Key states
		 */
		public static const RELEASED      : uint = 0; // <! Key is released
		public static const TRIGGERED     : uint = 1; // <! Key was pressed right now
		public static const PRESSED       : uint = 2; // <! Key is being pressed
		public static const REPEATED 	  : uint = 3; // <! Key is in the repeat cycle
		public static const JUST_RELEASED : uint = 4; // <! Key was released right now
		
		private static const keyboardState : Vector.<uint> = new Vector.<uint>(256, true); // <! Keyboard state
		
		/**
		 * Constructor. Does nothing, and shouldn't be called.
		 */
		public function Input() { }
		
		/**
		 * Adds Input's callbacks for key capturing.
		 * 
		 * @param stage the stage.
		 */
		public static function init(stage:Stage) 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,   onKeyUp);
		}
		
		/**
		 * Updates the keyboardState of the keys
		 */
		public static function update() : void
		{
			var keyState : uint;
			for (var i : int = 255; i >= 0; i--)
			{
				keyState = keyboardState[i];
				keyboardState[i] = keyState == JUST_RELEASED ? RELEASED : keyState == RELEASED ? RELEASED : PRESSED;
			}
		}
		
		/**
		 * Receives when a key was just pressed or repeated
		 * 
		 * @warning Method called automatically
		 * @param	Event
		 */
		private static function onKeyDown(event : KeyboardEvent) : void
		{
			const keyState : uint = keyboardState[event.keyCode];
			keyboardState[event.keyCode] = keyState == RELEASED ? TRIGGERED : keyState == PRESSED ? REPEATED : keyState;
		}
		
		/**
		 * Receives when a key was just released
		 * 
		 * @warning Method called automatically
		 * @param	Event
		 */
		private static function onKeyUp(event : KeyboardEvent) : void
		{
			keyboardState[event.keyCode] = JUST_RELEASED;
		}
		
		/**
		 * Verifies if a key is down
		 * 
		 * @param  Key code
		 * @return If the key is down 
		 */
		public static function isDown(code : uint) : Boolean
		{
			const keyState : uint = keyboardState[code];
			return !((keyState == RELEASED) || (keyState == JUST_RELEASED));
		}
		
		/**
		 * Verifies if any key is down
		 * 
		 * @return If there is any key down
		 */
		public static function isAnyKeyDown() : Boolean
		{
			var keyState : uint;
			for (var i : int = 255; i >= 0; i--)
			{
				keyState = keyboardState[i];
				if (!((keyState == RELEASED) || (keyState == JUST_RELEASED)))
					return true;
			}
			return false;
		}
		
		/**
		 * Verifies if the key was pressed right now
		 * 
		 * @param  Key code
		 * @return If the key was pressed right now
		 */
		public static function isTriggered(code : uint) : Boolean
		{
			return (keyboardState[code] == TRIGGERED);
		}
		
		/**
		 * Verifies if the key is being pressed
		 * 
		 * @param  Key code
		 * @return If the key is being pressed
		 */
		public static function isPressed(code : uint) : Boolean
		{
			return (keyboardState[code] == PRESSED);
		}
		
		/**
		 * Verifies if the key is in the repeat cycle
		 * 
		 * @param  Key code
		 * @return If the key is in the repeat cycle
		 */
		public static function isRepeated(code : uint) : Boolean
		{
			return (keyboardState[code] == REPEATED);
		}
		
		/**
		 * Verifies if the key was released right now
		 * 
		 * @param  Key code
		 * @return If the key was released right now
		 */
		public static function isJustReleased(code : uint): Boolean
		{
			return (keyboardState[code] == JUST_RELEASED);
		}
		
		/**
		 * Verifies if the key is released
		 * 
		 * @param  Key code
		 * @return If the key is released
		 */
		public static function isUp(code : uint) : Boolean
		{
			return keyboardState[code] == RELEASED;
		}
		
	}
	
}