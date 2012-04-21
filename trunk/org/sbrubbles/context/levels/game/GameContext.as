package org.sbrubbles.context.levels.game 
{
	import org.sbrubbles.context.Context;
	import org.sbrubbles.Main;
	/**
	 * Symbolizes contexts related to the execution of the actual game. This 
	 * class provides an extra property, gameState, which holds an object with
	 * all shared game data. For it to shared, however, every game context must
	 * use the same gameState instance.
	 * 
	 * @author Humberto Anjos
	 * @see GameState
	 * @see Context
	 */
	public class GameContext extends Context
	{
		private var _gameState:GameState
		
		public function GameContext(owner:Main, gameState:GameState) 
		{
			super(owner)
			_gameState = gameState
		}
		
		// === properties ===
		public function get gameState() { return _gameState }
		public function set gameState(gameState:GameState) { _gameState = gameState }
	}

}