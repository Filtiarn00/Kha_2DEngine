package khaEngine2D.entities;

import kha.graphics2.Graphics;

class EntityManager
{
    private var worlds:Map<String,EntityWorld>;
    private var worldToEdit:EntityWorld;

    public function new()
	{		
        addWorld('Main');
	}

    public function update():Void 
	{   
        for (i in worlds)
            i.update();
	}

	public function render(graphics:Graphics):Void 
	{        
        for (i in worlds)
            i.render(graphics);
	}

    public function addWorld(key:String):Void
    {
        if (worlds == null)
            worlds = new Map<String,EntityWorld>();

        if (!worlds.exists(key))
        {
            worlds.set(key,new EntityWorld());
            worldToEdit = worlds[key];
        }
    }

    public function addSystem(system:EntitySystem):Void 
	{
        worldToEdit.addSystem(system);
	}

	public function removeSystem(system:EntitySystem):Void
	{
		worldToEdit.systems.remove(system);
	}

    public function createEntity():Entity
	{
        return worldToEdit.createEntity();
	}

    public function getEntitiesWithComponents(entityComponents:Array<EntityComponent>):Array<Entity>
    {
        return worldToEdit.getEntitiesWithComponents(entityComponents);
    }

    public function addComponent(entity:Entity,entityComponent:EntityComponent):Void
	{
        worldToEdit.addComponent(entity,entityComponent);
	}

    public function removeComponent(entity:Entity,entityComponent:EntityComponent):Void
	{
        worldToEdit.removeComponent(entity,entityComponent);
	}

    public function getComponent(entity:Entity,entityComponent:EntityComponent):EntityComponent
	{
        return worldToEdit.getComponent(entity,entityComponent);
	}

    public function hasComponents(entity:Entity,entityComponentsToCheckFor:Array<EntityComponent>):Bool
	{
        return worldToEdit.hasComponents(entity,entityComponentsToCheckFor);
	}

    public function hasComponent(entity:Entity, entityComponent:EntityComponent):Bool
	{	
        return hasComponent(entity,entityComponent);
	}
}