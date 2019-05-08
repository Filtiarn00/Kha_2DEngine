package game.systems;

import kha.Image;
import kha.Color;
import kha.graphics2.Graphics;
import kha.Assets;

import khaEngine2D.graphics.SpriteBatch;
import khaEngine2D.entities.Entity;
import khaEngine2D.entities.EntitySystem;
import khaEngine2D.entities.EntityComponent;
import game.components.Position2DComponent;

class ActorRenderSystem extends EntitySystem
{
    private var entityGroup:Array<EntityComponent>;
    private var entities:Array<Entity>;
    private var positions:Array<Position2DComponent>;

    private var image:Image;

    public override function onCreate():Void 
    {
        entityGroup = [new Position2DComponent()];
    }

    public override function onChange():Void 
    {
        entities = world.getEntitiesWithComponents(entityGroup);
        positions = new Array<Position2DComponent>();

        for (i in entities)
            positions.push(cast(world.getComponent(i,new Position2DComponent()),Position2DComponent));
    }

	public override function update():Void 
    {
    }

	public override function render():Void 
    {
        if (image == null)
        {
            image = Assets.images.Player_Sprite;
        }
        
        for (i in positions)
            SpriteBatch.DrawSpriteSheet(image,i.x,i.y,0.5,0.5,0,0,48,48);
    }
}