package;

import kha.System;
import Game;

class Main 
{
	public static function main() 
	{
		System.start({title: "Elements", width: 800, height: 600}, initialized);
	}

	private static function initialized(window:kha.Window):Void 
	{
		var game = new Game();
	}
}