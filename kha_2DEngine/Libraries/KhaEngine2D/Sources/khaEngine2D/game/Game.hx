package khaEngine2D.game;

import kha.Window;
//Core Kha
import kha.Assets;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;

import khaEngine2D.game.Scene;
import khaEngine2D.input.Input;
import khaEngine2D.graphics.SpriteBatch;
import khaEngine2D.entities.EntityManager;

class Game
{
	private static var i:Game;

	public var doUpdate = true;

	public static function get(): Game
	{
		return i;
	}

	public function new()
	{
        i = this;

		Scheduler.addTimeTask(update, 0, 1 / 60);
		System.notifyOnFrames(function (frames) {render(frames); });
		Assets.loadEverything(load);
	}

	public  function load():Void
	{
	}

    public function update():Void 
	{
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
	}
}