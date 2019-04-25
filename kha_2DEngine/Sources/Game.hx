package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import entities.EntityManager;
import entities.Entity;
import components.Position2DComponent;
import systems.CharacterSystem;

class Game
{
    private var entityManager:EntityManager;
	private var entity:Entity;

	public function new()
	{	
        entityManager = new EntityManager();		
        System.notifyOnFrames(function (frames) { entityManager.render(frames); });
		Scheduler.addTimeTask(entityManager.update, 0, 1 / 60);

		entity = entityManager.createEntity();

		var p = new Position2DComponent();
		p.x = 0;
		p.y = 0;

		entityManager.addComponent(entity,p);


		entityManager.addSystem(new CharacterSystem());
	}

    public function update():Void 
	{
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
	}
}