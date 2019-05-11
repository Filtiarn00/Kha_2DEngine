package khaEngine2D.entities;

class EntityManager
{
    private static var worlds:Map<String,EntityWorld> = new Map<String,EntityWorld>();
    private static var worldToEdit:EntityWorld;
    
    public function new()
	{		
        addWorld('Main');
	}

    public static function update():Void 
	{   
        for (i in worlds)
        {
            i.update();
            i.checkForChanges();
        }
	}

    public static function forceCheckForChanges() 
    {
        for (i in worlds)
            i.checkForChanges();
    }

	public static function render():Void 
	{        
        for (i in worlds)
            i.render();
	}

    public static function addWorld(key:String):Void
    {
         worlds = new Map<String,EntityWorld>();

        if (!worlds.exists(key))
        {
            worlds.set(key,new EntityWorld());
            worldToEdit = worlds[key];
        }
    }

    public static function addSystem(system:EntitySystem):Void 
	{
        if (worldToEdit == null)
            addWorld('main');

        worldToEdit.addSystem(system);
	}

	public static function removeSystem(system:EntitySystem):Void
	{
        if (worldToEdit == null)
            addWorld('main');

		worldToEdit.systems.remove(system);
	}

    public static function createEntity():Entity
	{
        if (worldToEdit == null)
            addWorld('main');

        return worldToEdit.createEntity();
	}

    public static function getEntitiesWithComponents(entityComponents:Array<EntityComponent>):Array<Entity>
    {
        return worldToEdit.getEntitiesWithComponents(entityComponents);
    }

    public static function addComponent(entity:Entity,entityComponent:EntityComponent):Void
	{
        worldToEdit.addComponent(entity,entityComponent);
	}

    public static function removeComponent(entity:Entity,entityComponent:EntityComponent):Void
	{
        worldToEdit.removeComponent(entity,entityComponent);
	}

    public static function getComponent(entity:Entity,entityComponent:EntityComponent):EntityComponent
	{
        return worldToEdit.getComponent(entity,entityComponent);
	}

    public static function hasComponents(entity:Entity,entityComponentsToCheckFor:Array<EntityComponent>):Bool
	{
        return worldToEdit.hasComponents(entity,entityComponentsToCheckFor);
	}

    public static function hasComponent(entity:Entity, entityComponent:EntityComponent):Bool
	{	
        return hasComponent(entity,entityComponent);
	}
}