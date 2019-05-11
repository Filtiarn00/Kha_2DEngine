package game.systems;

import khaEngine2D.graphics.SpriteBatch;
import khaEngine2D.game.Scene;
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

        //Update position to target
        Camera.position.x += (positions[0].x - Camera.position.x) / 15;
        Camera.position.y += (positions[0].y - Camera.position.y) / 15;

        //Set Camera bounds
        Camera.bounds = new FastVector4(Scene.getBounds().x,Scene.getBounds().y,Scene.getBounds().z,Scene.getBounds().w);
    }

	public override function render():Void 
    {
    }
}