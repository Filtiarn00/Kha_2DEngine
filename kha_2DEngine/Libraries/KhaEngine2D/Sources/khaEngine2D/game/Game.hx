package khaEngine2D.game;

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

    private var scene:Scene;
	public var input:Input;
    public var entityManager:EntityManager;
	public var doUpdate = false;

	public static function getGame(): Game
	{
		return i;
	}

	public function new()
	{
        i = this;

		Scheduler.addTimeTask(update, 0, 1 / 60);
		System.notifyOnFrames(function (frames) {render(frames); });
		Assets.loadEverything(load);

        scene = new Scene();
		input = new Input();
        entityManager = new EntityManager();
	}

	public  function load():Void
	{
	}

    public function update():Void 
	{
		if (doUpdate)
			entityManager.update();
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
		SpriteBatch.begin(frames[0].g2);
		scene.render();
		entityManager.render();
		SpriteBatch.end();
	}
}