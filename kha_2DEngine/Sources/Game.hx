package;

import components.ActorInputComponent;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import input.Input;
import entities.EntityManager;
import entities.Entity;
import components.Position2DComponent;
import systems.ActorPlayerSystem;
import systems.ActorMoverSystem;
import systems.ActorRenderSystem;

class Game
{
	private var input:Input;
    private var entityManager:EntityManager;
	private var entity:Entity;

	public function new()
	{	
		//Input
		input = new Input();

		//Entities
        entityManager = new EntityManager();		
        System.notifyOnFrames(function (frames) { entityManager.render(frames); });
		Scheduler.addTimeTask(entityManager.update, 0, 1 / 60);

		entity = entityManager.createEntity();

		var p = new Position2DComponent();
		p.x = 0;
		p.y = 0;

		entityManager.addComponent(entity,p);

		var a = new ActorInputComponent();
		a.xInput = 0;
		a.yInput = 0;

		entityManager.addComponent(entity,a);

		entityManager.addSystem(new ActorPlayerSystem());
		entityManager.addSystem(new ActorMoverSystem());
		entityManager.addSystem(new ActorRenderSystem());
	}

    public function update():Void 
	{
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
	}
}