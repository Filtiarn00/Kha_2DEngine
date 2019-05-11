package khaEngine2D.game;

import kha.math.FastVector4;
import kha.Color;

import khaEngine2D.graphics.Camera;
import khaEngine2D.graphics.SpriteBatch;

class Scene
{
    private static var backgroundColor:Color = Color.Black;
	private static var bounds:FastVector4 = new FastVector4(0,0,2000,2000);

    public static function setBackgroundColor(color:Color): Void 
    {
        backgroundColor = color;
    	Camera.clearColor = color;
    }

	public static function getBackgroundColor(): Color 
	{
		return backgroundColor;
	}

	public static function setBounds(width:Float,height:Float): Void 
	{
		bounds.z = width;
		bounds.w = height;
	}

	public static function getBounds(): FastVector4 
	{
		return bounds;
	}

	public static function render():Void 
	{
		SpriteBatch.getGraphics().drawRect(bounds.x + 1,bounds.y + 1,bounds.z - 1,bounds.w - 2);
	}
}