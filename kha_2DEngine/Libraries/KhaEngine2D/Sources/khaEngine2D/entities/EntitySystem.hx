package khaEngine2D.entities;

import kha.graphics2.Graphics;

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

	public function render(graphics:Graphics):Void {}
}