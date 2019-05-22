package khaEngine2D.graphics;

import kha.math.Vector2i;
import kha.Color;
import kha.System;
import kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.math.FastVector4;
import kha.math.FastVector2;

class Camera
{
	public static var bounds:FastVector4 = new FastVector4(0,0,0,0);
	public static var view:FastVector4 = new FastVector4(0,0,0,0);
	public static var position:FastVector2 = new FastVector2(0,0);
	public static var clearColor:Color = Color.Black;

	private static var transformation:FastMatrix3 = FastMatrix3.identity();

	public static function set(graphics:Graphics):Void 
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
		
	public static function getScreenToWorldSpace(inPosition:FastVector2): FastVector2
	{
		var newPositionX = Std.int(position.x + inPosition.x - view.x);
		var newPositionY = Std.int(position.y + inPosition.y - view.y);
		return new FastVector2(newPositionX,newPositionY);
	}

	public static function getViewWidth():Float 
	{
		return view.z;
	}

	public static function getViewHeight():Float
	{
		return view.w;
	}

	public static function unset(graphics:Graphics):Void 
	{
  		graphics.popTransformation();
	}

	public static function isInView(x:Float, y:Float):Bool
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
