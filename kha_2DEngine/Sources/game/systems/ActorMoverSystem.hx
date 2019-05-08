package game.systems;

import kha.graphics2.Graphics;
import khaEngine2D.entities.Entity;
import khaEngine2D.entities.EntitySystem;
import khaEngine2D.entities.EntityComponent;
import game.components.Position2DComponent;
import game.components.ActorInputComponent;

class ActorMoverSystem extends EntitySystem
{
    private var entityGroup:Array<EntityComponent>;
    private var entities:Array<Entity>;
    private var positions:Array<Position2DComponent>;
    private var actorInputs:Array<ActorInputComponent>;

    public override function onCreate():Void 
    {
        entityGroup = [new Position2DComponent(),new ActorInputComponent()];
    }

    public override function onChange():Void 
    {
        entities = world.getEntitiesWithComponents(entityGroup);
        positions = new Array<Position2DComponent>();
        actorInputs = new Array<ActorInputComponent>();

        for (i in entities)
        {
            positions.push(cast(world.getComponent(i,new Position2DComponent()),Position2DComponent));
            actorInputs.push(cast(world.getComponent(i,new ActorInputComponent()),ActorInputComponent));
        }
    }

	public override function update():Void 
    {
        for (i in entities)
        {
            positions[i.getIndex()].x += actorInputs[i.getIndex()].xInput * 3;
            positions[i.getIndex()].y += actorInputs[i.getIndex()].yInput * 3;
        }
    }

	public override function render():Void 
    {
    }
}