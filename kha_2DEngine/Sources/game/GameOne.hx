package game;

import khaEngine2D.input.Input;
//Core Kha
import kha.Framebuffer;

//Library
import khaEngine2D.game.Game;
import khaEngine2D.game.Scene;
import khaEngine2D.entities.EntityManager;
import khaEngine2D.graphics.SpriteBatch;

//Game
import game.components.ActorInputComponent;
import game.components.ActorPlayerComponent;
import game.components.Position2DComponent;
import game.systems.ActorCameraSystem;
import game.systems.ActorPlayerSystem;
import game.systems.ActorMoverSystem;
import game.systems.ActorRenderSystem;

class GameOne extends Game
{
	public function new()
	{
		super();

		//Init our input
		Input.Init();

		var entity = EntityManager.createEntity();
		EntityManager.addComponent(entity,new ActorInputComponent());
		EntityManager.addComponent(entity,new ActorPlayerComponent());
		EntityManager.addComponent(entity,new Position2DComponent());

		//Add Systems
		EntityManager.addSystem(new ActorPlayerSystem());
		EntityManager.addSystem(new ActorMoverSystem());
		EntityManager.addSystem(new ActorRenderSystem());
		EntityManager.addSystem(new ActorCameraSystem());
	}

	public override function load():Void
	{
	}

    public override function update():Void 
	{
		super.update();

		if (doUpdate)
			EntityManager.update();
	}

	public override function render(frames: Array<Framebuffer>):Void 
	{
		super.render(frames);

		SpriteBatch.begin(frames[0].g2);
		Scene.render();
		EntityManager.render();
		SpriteBatch.end();
	}
}