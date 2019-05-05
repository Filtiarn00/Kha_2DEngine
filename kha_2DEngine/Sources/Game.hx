package;

import kha.Color;
import kha.Assets;
import kha.input.KeyCode;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;

//Library
import khaEngine2D.graphics.Camera;
import khaEngine2D.graphics.SpriteBatch;
import khaEngine2D.input.Input;
import khaEngine2D.entities.EntityManager;

//Game
import components.Position2DComponent;
import components.ActorInputComponent;
import components.ActorPlayerComponent;
import systems.ActorCameraSystem;
import systems.ActorPlayerSystem;
import systems.ActorMoverSystem;
import systems.ActorRenderSystem;

class Game
{
	private var input:Input;
    private var entityManager:EntityManager;

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
		var entity = entityManager.createEntity();
		entityManager.addComponent(entity,new Position2DComponent());
		entityManager.addComponent(entity,new ActorInputComponent());
		entityManager.addComponent(entity,new ActorPlayerComponent());


		entityManager.addSystem(new ActorPlayerSystem());
		entityManager.addSystem(new ActorMoverSystem());
		entityManager.addSystem(new ActorRenderSystem());
		entityManager.addSystem(new ActorCameraSystem());
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