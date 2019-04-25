package entities;

import kha.graphics2.Graphics;
import entities.Entity;
import entities.EntityComponent;

class EntityManager
{
    public var systems:Array<EntitySystem>;
    private var entities:Array<Entity>;
    private var entityComponents:Map<Int,Array<EntityComponent>>;
    private var activeEntity:Entity;
    private  var isDirty:Bool;

    public function new()
	{		
        systems = new Array<EntitySystem>();
        entities = new Array<Entity>();
        entityComponents = new Map<Int,Array<EntityComponent>>();

        isDirty = true;
	}

    public function update():Void 
	{
        for (i in systems)
        {
            if (isDirty)
                i.onChange();

			i.update();
        }

        isDirty = false;
	}

	public function render(graphics:Graphics):Void 
	{
        for (i in systems)
            i.render(graphics);
	}

    public function addSystem(system:EntitySystem):Void 
	{
		system.entityManager = this;
        system.onCreate();
		systems.push(system);
	}

	public function removeSystem(system:EntitySystem):Void
	{
		systems.remove(system);
	}

    public function createEntity():Entity
	{
		//Create a new entity and set its index
		var v:Entity = new Entity(entities.length);

        //Add entity to entities list
        entities.push(v);

        //Create component array for this entity
        entityComponents[v.getIndex()] = new Array<EntityComponent>();
		
		//Return entity
		return v;
	}

    public function getEntitiesWithComponents(entityComponents:Array<EntityComponent>):Array<Entity>
    {
		var entitiesWithComponents:Array<Entity> = new Array<Entity>();

        for (i in entities)
			if (hasComponents(i,entityComponents))
				entitiesWithComponents.push(i);

		return entitiesWithComponents;
    }

    public function addComponent(entity:Entity,entityComponent:EntityComponent):Void
	{
        entityComponents[entity.getIndex()].push(entityComponent);		
	}

    public function removeComponent(entity:Entity,entityComponent:EntityComponent):Void
	{
        if (hasComponent(entity,entityComponent))
            entityComponents[entity.getIndex()].remove(entityComponent);	
	}

    public function getComponent(entity:Entity,entityComponent:EntityComponent):EntityComponent
	{
        for (i in entityComponents[entity.getIndex()])
            if (Type.getClassName(Type.getClass(i)) == Type.getClassName(Type.getClass(entityComponent)))
                return i;

        return null;
	}

    public function hasComponents(entity:Entity,entityComponentsToCheckFor:Array<EntityComponent>):Bool
	{
        for (i in entityComponentsToCheckFor)
            if (!hasComponent(entity,i))
                return false;

		return true;
	}

    public function hasComponent(entity:Entity, entityComponent:EntityComponent):Bool
	{	
        for (i in entityComponents[entity.getIndex()])
            if (Type.getClassName(Type.getClass(i)) == Type.getClassName(Type.getClass(entityComponent)))
                return true;

        return false;
	}
}