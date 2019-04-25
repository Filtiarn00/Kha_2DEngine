package camera;

import kha.graphics2.Graphics;
import kha.math.FastMatrix3;

class Camera
{
	public static var i:Camera;

	public var transformation:FastMatrix3;
	public var x:Float;
	public var y:Float;

	public static function I():Camera
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
  	graphics.transformation = transformation;
	  graphics.translate(-x,-y);
	}

	public function unset(graphics:Graphics):Void 
	{
  	graphics.popTransformation();
	}
}
