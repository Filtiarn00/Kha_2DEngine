package khaEngine2D.entities;

class EntitySystem
{
	public var world:EntityWorld;

	public function new() 
	{
		onCreate();
	}

	public function onCreate():Void {}

	public function onChange():Void {}

	public function update():Void {}

	public function render():Void {}
}