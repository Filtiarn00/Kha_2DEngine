package game;

import kha.Image;
import kha.Assets;
import khaEngine2D.input.Input;
//Core Kha
import kha.Framebuffer;

//Library
import khaEngine2D.game.Game;
import khaEngine2D.game.Scene;
import khaEngine2D.entities.EntityManager;
import khaEngine2D.graphics.SpriteBatch;
import khaEngine2D.graphics.TileManager;

//Game
import game.systems.ActorCameraSystem;
import game.systems.ActorPlayerSystem;
import game.systems.ActorMoverSystem;
import game.systems.ActorRenderSystem;

class GameOne extends Game
{
	private var i:Image;

	public function new()
	{
		super();

		//Init our input
		Input.Init();

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

		if (i == null)
		{
			i = Assets.images.Tileset_Test;

			TileManager.createTileset('test',i, 16,16);
			TileManager.createTileLayer('test','background');
		}

		SpriteBatch.begin(frames[0].g2);
		Scene.render();
		TileManager.render();
		EntityManager.render();
		SpriteBatch.end();
	}
}