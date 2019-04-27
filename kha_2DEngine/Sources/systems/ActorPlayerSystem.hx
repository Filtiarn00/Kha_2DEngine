package systems;

import kha.graphics2.Graphics;
import kha.input.KeyCode;
import khaEngine2D.entities.Entity;
import khaEngine2D.entities.EntityComponent;
import khaEngine2D.entities.EntitySystem;
import khaEngine2D.input.Input;
import components.ActorInputComponent;
import components.ActorPlayerComponent;
import components.Position2DComponent;

class ActorPlayerSystem extends EntitySystem
{
    private var entityGroup:Array<EntityComponent>;
    private var entities:Array<Entity>;
    private var actorInputs:Array<ActorInputComponent>;

    public override function onCreate():Void 
    {
        entityGroup = [new ActorInputComponent(),new ActorPlayerComponent()];
    }

    public override function onChange():Void 
    {
        entities = world.getEntitiesWithComponents(entityGroup);
        actorInputs = new Array<ActorInputComponent>();

        for (i in entities)
             actorInputs.push(cast(world.getComponent(i,new ActorInputComponent()),ActorInputComponent));
    }

	public override function update():Void 
    {
        if (Input.I().isKeyDown(KeyCode.Return))
		{
			var i = 1000;
				while (i > 0)
				{
					var entity = world.createEntity();
					var position2DComponent = new Position2DComponent();
					position2DComponent.x = Math.floor(Math.random() * ( 1 + 2000 - 1) + 1);
					position2DComponent.y = Math.floor(Math.random() * ( 1 + 2000 - 1) + 1);
					world.addComponent(entity,position2DComponent);
                    world.addComponent(entity,new ActorInputComponent());
					i--;
				}
		}

         for (i in entities)
         {
             var actorInput = actorInputs[i.getIndex()];

             actorInput.xInput = 0;
             actorInput.yInput = 0;

            if (Input.I().isKeyDown(KeyCode.A))
                actorInput.xInput = -1;
            if (Input.I().isKeyDown(KeyCode.D))
                actorInput.xInput = 1;
            if (Input.I().isKeyDown(KeyCode.W))
                actorInput.yInput = -1;
            if (Input.I().isKeyDown(KeyCode.S))
                actorInput.yInput = 1;
         }
    }

	public override function render(graphics:Graphics):Void 
    {
    }
}