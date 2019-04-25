package systems;

import Type.ValueType;
import kha.graphics2.Graphics;
import entities.Entity;
import entities.EntitySystem;
import entities.EntityComponent;
import components.Position2DComponent;

class CharacterSystem extends EntitySystem
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
        {
            positions.push(cast(entityManager.getComponent(i,new Position2DComponent()),Position2DComponent));
        }
    }

	public override function update():Void 
    {
        for (i in entities)
        {
            positions[i.getIndex()].x += 2.5;
            positions[i.getIndex()].y += 2.5;
        }
    }

	public override function render(graphics:Graphics):Void 
    {
        for (i in entities)
        {
            graphics.drawRect(positions[i.getIndex()].x,positions[i.getIndex()].y,20,20);
        }
    }
}