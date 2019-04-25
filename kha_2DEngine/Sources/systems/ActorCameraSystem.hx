package systems;

import kha.graphics2.Graphics;
import camera.Camera;
import entities.Entity;
import entities.EntitySystem;
import entities.EntityComponent;
import components.Position2DComponent;
import components.ActorPlayerComponent;

class ActorCameraSystem extends EntitySystem
{
    private var entityGroup:Array<EntityComponent>;
    private var entities:Array<Entity>;
    private var positions:Array<Position2DComponent>;
    private var actorPlayers:Array<ActorPlayerComponent>;

    public override function onCreate():Void 
    {
        entityGroup = [new Position2DComponent(),new ActorPlayerComponent()];
    }

    public override function onChange():Void 
    {
        entities = entityManager.getEntitiesWithComponents(entityGroup);
        positions = new Array<Position2DComponent>();
        actorPlayers = new Array<ActorPlayerComponent>();

        for (i in entities)
        {
            positions.push(cast(entityManager.getComponent(i,new Position2DComponent()),Position2DComponent));
            actorPlayers.push(cast(entityManager.getComponent(i,new ActorPlayerComponent()),ActorPlayerComponent));
        }
    }

	public override function update():Void 
    {
    }

	public override function render(graphics:Graphics):Void 
    {
    }
}