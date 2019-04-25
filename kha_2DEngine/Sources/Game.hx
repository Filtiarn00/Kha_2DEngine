package;

import kha.System;
import kha.Scheduler;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import camera.Camera;
import input.Input;
import entities.EntityManager;
import entities.Entity;
import components.Position2DComponent;
import components.ActorInputComponent;
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

		var p = new Position2DComponent();
		p.x = 0;
		p.y = 0;

		entityManager.addComponent(entity,p);

		var a = new ActorInputComponent();
		a.xInput = 0;
		a.yInput = 0;

		entityManager.addComponent(entity,a);

		entityManager.addSystem(new ActorCameraSystem());
		entityManager.addSystem(new ActorPlayerSystem());
		entityManager.addSystem(new ActorMoverSystem());
		entityManager.addSystem(new ActorRenderSystem());
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