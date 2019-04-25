package camera;

import kha.graphics2.Graphics;
import kha.math.FastMatrix3;

class Camera
{
	public static var i:Camera;

	public var transformation:FastMatrix3;
	public var x:Float = 0;
	public var y:Float = 0;
	public var viewX:Float = 0;
	public  var viewY:Float = 0;

	public static function GetCamera():Camera
	{
		return i;
	}

	public function new() 
	{
		i = this;
		transformation = FastMatrix3.identity();
	}

	public function set(graphics:Graphics):Void 
	{
		graphics.pushTransformation(transformation);
		graphics.translate(-x + viewX,-y + viewY);
	}

	public function unset(graphics:Graphics):Void 
	{
  		graphics.popTransformation();
	}
}
