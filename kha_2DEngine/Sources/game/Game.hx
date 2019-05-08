package game;

//Core Kha
import kha.Assets;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;

//Library
import khaEngine2D.graphics.SpriteBatch;
import khaEngine2D.input.Input;
import khaEngine2D.entities.EntityManager;

//Game
import game.components.Position2DComponent;
import game.components.ActorInputComponent;
import game.components.ActorPlayerComponent;
import game.systems.ActorCameraSystem;
import game.systems.ActorPlayerSystem;
import game.systems.ActorMoverSystem;
import game.systems.ActorRenderSystem;

class Game
{
	private static var i:Game;

	public var input:Input;
    public var entityManager:EntityManager;

	public static function getGame(): Game
	{
		return i;
	}

	public function new()
	{
		Scheduler.addTimeTask(update, 0, 1 / 60);
		System.notifyOnFrames(function (frames) {render(frames); });
		Assets.loadEverything(load);

		//Input
		input = new Input();

		//Entities
        entityManager = new EntityManager();		

		//Crete Player entity
		entityManager.addSystem(new ActorPlayerSystem());
		entityManager.addSystem(new ActorMoverSystem());
		entityManager.addSystem(new ActorRenderSystem());
		entityManager.addSystem(new ActorCameraSystem());

		i = this;
	}

	public  function load():Void
	{
	}

    public function update():Void 
	{
		entityManager.update();
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
		SpriteBatch.begin(frames[0].g2);
		entityManager.render();
		SpriteBatch.end();
	}
}