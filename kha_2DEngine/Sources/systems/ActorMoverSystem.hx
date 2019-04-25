package systems;

import kha.graphics2.Graphics;
import entities.Entity;
import entities.EntitySystem;
import entities.EntityComponent;
import components.Position2DComponent;
import components.ActorInputComponent;
import kha.input.KeyCode;
import kha.input.Keyboard;
import input.Input;

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
        entities = entityManager.getEntitiesWithComponents(entityGroup);
        positions = new Array<Position2DComponent>();
        actorInputs = new Array<ActorInputComponent>();

        for (i in entities)
        {
            positions.push(cast(entityManager.getComponent(i,new Position2DComponent()),Position2DComponent));
            actorInputs.push(cast(entityManager.getComponent(i,new ActorInputComponent()),ActorInputComponent));
        }
    }

	public override function update():Void 
    {
        for (i in entities)
        {
            positions[i.getIndex()].x += actorInputs[i.getIndex()].xInput;
            positions[i.getIndex()].y += actorInputs[i.getIndex()].yInput;
        }
    }

	public override function render(graphics:Graphics):Void 
    {
    }
}