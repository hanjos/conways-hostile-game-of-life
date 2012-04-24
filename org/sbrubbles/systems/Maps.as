package org.sbrubbles.systems 
{
	import flash.utils.Dictionary;
	import org.sbrubbles.gameoflife.Map;
	/**
	 * Manages the game's maps.
	 * 
	 * @author Humberto Anjos
	 */
	public class Maps 
	{
		private static var _maps:Dictionary // <String, Map>
		
		/**
		 * Constructor. Does nothing, and shouldn't be called.
		 */
		public function Maps() { }
		
		/**
		 * Static constructor.
		 */
		{
			_maps = new Dictionary()
		}
		
		/**
		 * Registers a new map, accessible with the given name.
		 * 
		 * @param name the map's name.
		 * @param map the map. If null, removes the previous mapping.
		 * @return the map previously mapped to the given name, or null if there were none.
		 */
		public static function register(name:String, map:Map):Map
		{
			var old:Map = _maps[name] // save the old value
			
			if (map != null) { 
				_maps[name] = map
			} else { // just remove any mapping
				delete _maps[name]
			}
			
			return old
		}
		
		/**
		 * @param name the desired map's name.
		 * @return the map with the given name, or null if there is none.
		 */
		public static function named(name:String):Map
		{
			return _maps[name]
		}
		
		/**
		 * @return a list of all the registered map names.
		 */
		public static function get names():Vector.<String> 
		{
			var names:Vector.<String> = new Vector.<String>()
			
			for (var name:String in _maps) {
				names.push(name)
			}
			
			return names
		}
	}

}