package khaEngine2D.graphics;

import kha.Color;
import kha.System;
import kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.math.FastVector4;
import kha.math.FastVector2;

class Camera
{
	private static var i:Camera;

	public var bounds:FastVector4 = new FastVector4(0,0,0,0);
	public var view:FastVector4 = new FastVector4(0,0,0,0);
	public var position:FastVector2 = new FastVector2(0,0);
	public var clearColor:Color = Color.Black;

	private var transformation:FastMatrix3;

	public static function GetCamera():Camera
	{
		if (i == null)
			i = new Camera();

		return i;
	}

	public function new() 
	{
		i = this;
		transformation = FastMatrix3.identity();
	}

	public function set(graphics:Graphics):Void 
	{
		view.z = System.windowWidth();
		view.w = System.windowHeight();

		 //Clamp X position to fit in bounds
		 if (bounds.z > bounds.x)
		 {
        	if (position.x < view.x) position.x = view.x;
        	if (position.x > bounds.z - view.x) position.x =  bounds.z - view.x;
		 }

        //Clamp Y position to fit in bounds
		 if (bounds.w > bounds.y)
		 {
        	if (position.y < view.y) position.y = view.y;
        	if (position.y > bounds.w - view.y) position.y =  bounds.w - view.y;
		 }

		//Set View X and Y to center of view Z and W
		view.x = view.z * 0.5;
		view.y = view.w * 0.5;
		
		graphics.pushTransformation(transformation);
		graphics.translate(-position.x + view.x,-position.y + view.y);
	}
		
	public function getScreenToWorldSpace(x:Float, y:Float): FastVector2
	{
		x +=  position.x - view.z / 2;
        y +=  position.y - view.w / 2;
		return new FastVector2(x,y);
	}

	public function getViewWidth():Float 
	{
		return view.z;
	}

	public function getViewHeight():Float
	{
		return view.w;
	}

	public function unset(graphics:Graphics):Void 
	{
  		graphics.popTransformation();
	}

	public function isInView(x:Float, y:Float):Bool
	{
		var inBounds = true;

		//X Left Check
		if (inBounds) inBounds = x >= position.x - view.x;
		//X Right Check
		if (inBounds) inBounds = x <= position.x + view.z - view.x;
		//Y Up Check
		if (inBounds) inBounds = y >= position.y - view.y;
		//Y Bottom Check
		if (inBounds) inBounds = y <= position.y + view.w - view.y;

		return inBounds;
	}

}
