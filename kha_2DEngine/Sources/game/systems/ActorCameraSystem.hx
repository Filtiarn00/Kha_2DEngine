package game.systems;

import kha.math.FastVector4;
import khaEngine2D.graphics.Camera;
import khaEngine2D.entities.Entity;
import khaEngine2D.entities.EntitySystem;
import khaEngine2D.entities.EntityComponent;
import game.components.Position2DComponent;
import game.components.ActorPlayerComponent;

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
        entities = world.getEntitiesWithComponents(entityGroup);
        positions = new Array<Position2DComponent>();
        actorPlayers = new Array<ActorPlayerComponent>();

        for (i in entities)
        {
            positions.push(cast(world.getComponent(i,new Position2DComponent()),Position2DComponent));
            actorPlayers.push(cast(world.getComponent(i,new ActorPlayerComponent()),ActorPlayerComponent));
        }
    }

	public override function update():Void 
    {
        if (entities.length == 0)
            return;

        var camera = Camera.GetCamera();

        //Update position to target
        camera.position.x += (positions[0].x - camera.position.x) / 15;
        camera.position.y += (positions[0].y - camera.position.y) / 15;

        //Set Camera bounds
        camera.bounds = new FastVector4(0,0,0,0);
    }

	public override function render():Void 
    {
    }
}