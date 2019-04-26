package;

import kha.Window;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import khaEngine2D.camera.Camera;
import khaEngine2D.input.Input;
import khaEngine2D.entities.EntityManager;
import khaEngine2D.entities.Entity;
import components.Position2DComponent;
import components.ActorInputComponent;
import components.ActorPlayerComponent;
import systems.ActorCameraSystem;
import systems.ActorPlayerSystem;
import systems.ActorMoverSystem;
import systems.ActorRenderSystem;

class Game
{
	private var camera:Camera;
	private var input:Input;
    private var entityManager:EntityManager;
	private var entity:Entity;

	public function new()
	{
		Scheduler.addTimeTask(update, 0, 1 / 60);
		System.notifyOnFrames(function (frames) {render(frames); });

		//Camera
		camera = new Camera();

		//Input
		input = new Input();

		//Entities
        entityManager = new EntityManager();		
   
		entity = entityManager.createEntity();

		entityManager.addComponent(entity,new Position2DComponent());
		entityManager.addComponent(entity,new ActorInputComponent());
		entityManager.addComponent(entity,new ActorPlayerComponent());

		entityManager.addSystem(new ActorPlayerSystem());
		entityManager.addSystem(new ActorMoverSystem());
		entityManager.addSystem(new ActorRenderSystem());
		entityManager.addSystem(new ActorCameraSystem()); 
	}

    public function update():Void 
	{
		entityManager.update();
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
		var graphics = frames[0].g2;
		graphics.begin();
		camera.set(graphics);
		entityManager.render(graphics);
		camera.unset(graphics);
		graphics.end();
	}
}