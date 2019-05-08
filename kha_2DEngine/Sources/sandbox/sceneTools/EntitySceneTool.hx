package sandbox.sceneTools;

import khaEngine2D.graphics.Camera;
import kha.input.KeyCode;
import game.components.ActorPlayerComponent;
import game.components.ActorInputComponent;
import game.components.Position2DComponent;
import khaEngine2D.entities.Entity;
import kha.Window;
import kha.Framebuffer;
import kha.Assets;
import kha.graphics2.Graphics;
import zui.*;
import zui.Canvas;

import game.Game;

class EntitySceneTool extends SceneTool
{
	public function new() 
	{
        super();
        name = "Entity";
	}

    public override function guiMainBarRenderer(ui:Zui,graphics:Graphics): Void 
	{
	}

	public override function guiPanelRenderer(ui:Zui,graphics:Graphics): Void 
	{
        ui.image(Assets.images.Player_Sprite);
	}

    public override function OnSceneViewClick(): Void
    {
        var game = Game.getGame();
        var entityManager = game.entityManager;
        var input = game.input;
        var camera = Camera.GetCamera();

        if (input.getIsMousePressed())
        {
            var entity = entityManager.createEntity();

            var position2D = new Position2DComponent();
            position2D.x = camera.getScreenToWorldSpace(input.getMousePosition().x,input.getMousePosition().y).x;
            position2D.y = camera.getScreenToWorldSpace(input.getMousePosition().y,input.getMousePosition().y).y;

		    entityManager.addComponent(entity,position2D);
		    entityManager.addComponent(entity,new ActorInputComponent());
		    entityManager.addComponent(entity,new ActorPlayerComponent());
        }
    }
}