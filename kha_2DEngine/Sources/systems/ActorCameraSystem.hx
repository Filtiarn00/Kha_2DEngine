package systems;

import kha.graphics2.Graphics;
import kha.math.FastVector4;
import khaEngine2D.camera.Camera;
import khaEngine2D.entities.Entity;
import khaEngine2D.entities.EntitySystem;
import khaEngine2D.entities.EntityComponent;
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
        if (entities.length == 0)
            return;

        var camera = Camera.GetCamera();

        //Update position to target
        camera.position.x += (positions[0].x - camera.position.x) / 15;
        camera.position.y += (positions[0].y - camera.position.y) / 15;

        //Set Camera bounds
        camera.bounds = new FastVector4(0,0,2000,2000);

        //Center camera
        camera.view.x = camera.view.z * 0.5;
        camera.view.y = camera.view.w * 0.5;
    }

	public override function render(graphics:Graphics):Void 
    {
    }
}