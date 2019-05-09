package khaEngine2D.game;

import kha.math.FastVector4;
import kha.Color;

import khaEngine2D.graphics.Camera;
import khaEngine2D.graphics.SpriteBatch;

class Scene
{
	private static var i:Scene;
    
    private var backgroundColor:Color = Color.Black;
	private var bounds:FastVector4 = new FastVector4(0,0,1000,1000);

	public static function getScene(): Scene
	{
		return i;
	}

	public function new()
	{
        i = this;
	}

    public function setBackgroundColor(color:Color): Void 
    {
        backgroundColor = color;

        var camera = Camera.GetCamera();
        if (camera != null)
            Camera.GetCamera().clearColor = color;
    }

	public function getBackgroundColor(): Color 
	{
		return backgroundColor;
	}

	public function setBounds(width:Float,height:Float): Void 
	{
		bounds.z = width;
		bounds.w = height;
	}

	public function getBounds(): FastVector4 
	{
		return bounds;
	}

	public function render():Void 
	{
		SpriteBatch.getGraphics().drawRect(0,0,bounds.z,bounds.w);
	}
}