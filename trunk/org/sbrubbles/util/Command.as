package org.sbrubbles.util 
{
	/**
	 * ...
	 * 
	 * @author Humberto Anjos
	 */
	public class Command 
	{
		private var _name:String
		private var _command:Function
		
		public function Command(name:String, command:Function) 
		{
			_name = name
			_command = command
		}
		
		// === operations ===
		public function call() 
		{
			_command.call()
		}
		
		// === properties ===
		public function get name():String { return _name }
		public function get command():Function { return _command }
	}

}