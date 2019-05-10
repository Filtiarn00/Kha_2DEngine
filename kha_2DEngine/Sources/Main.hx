package;

import kha.System;
import game.GameOne;
import editor.EditorOne;

class Main 
{
	public static function main() 
	{
		System.start({title: "Kha2D - Sandbox", width: 800, height: 600}, initialized);
	}

	private static function initialized(window:kha.Window):Void 
	{
		var game = new GameOne();
		var editor = new EditorOne();
	}
}