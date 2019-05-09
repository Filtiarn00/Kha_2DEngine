package game;

//Core Kha
import kha.Framebuffer;

//Library
import khaEngine2D.game.Game;

//Game
import game.systems.ActorCameraSystem;
import game.systems.ActorPlayerSystem;
import game.systems.ActorMoverSystem;
import game.systems.ActorRenderSystem;

class GameOne extends Game
{
	public function new()
	{
		super();

		//Crete Player entity
		entityManager.addSystem(new ActorPlayerSystem());
		entityManager.addSystem(new ActorMoverSystem());
		entityManager.addSystem(new ActorRenderSystem());
		entityManager.addSystem(new ActorCameraSystem());
	}

	public override function load():Void
	{
	}

    public override function update():Void 
	{
		super.update();
	}

	public override function render(frames: Array<Framebuffer>):Void 
	{
		super.render(frames);
	}
}