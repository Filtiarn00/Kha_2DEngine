package systems;

import kha.Color;
import kha.graphics2.Graphics;
import khaEngine2D.entities.Entity;
import khaEngine2D.entities.EntitySystem;
import khaEngine2D.entities.EntityComponent;
import components.Position2DComponent;

class ActorRenderSystem extends EntitySystem
{
    private var entityGroup:Array<EntityComponent>;
    private var entities:Array<Entity>;
    private var positions:Array<Position2DComponent>;

    public override function onCreate():Void 
    {
        entityGroup = [new Position2DComponent()];
    }

    public override function onChange():Void 
    {
        entities = entityManager.getEntitiesWithComponents(entityGroup);
        positions = new Array<Position2DComponent>();

        for (i in entities)
            positions.push(cast(entityManager.getComponent(i,new Position2DComponent()),Position2DComponent));
    }

	public override function update():Void 
    {
    }

	public override function render(graphics:Graphics):Void 
    {
        //Debug borders of level
        graphics.color = Color.Red;
        graphics.drawRect(0,0,2000,2000,5);
        graphics.color = Color.White;

        //Draw Entities
        for (i in entities)
            graphics.drawRect(positions[i.getIndex()].x,positions[i.getIndex()].y,20,20);
    }
}