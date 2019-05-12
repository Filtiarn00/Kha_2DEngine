package khaEngine2D.game;

import kha.Color;

import khaEngine2D.graphics.Camera;
import khaEngine2D.graphics.SpriteBatch;

class Scene
{
    private static var backgroundColor:Color = Color.Black;

    public static function setBackgroundColor(color:Color): Void 
    {
        backgroundColor = color;
    	Camera.clearColor = color;
    }

	public static function getBackgroundColor(): Color 
	{
		return backgroundColor;
	}

	public static function render():Void 
	{
		SpriteBatch.getGraphics().color = 0xff505050;
		SpriteBatch.getGraphics().drawLine(-9999,0,9999,0,1);
		SpriteBatch.getGraphics().drawLine(0,-9999,0,9999,1);
		SpriteBatch.getGraphics().color = Color.White;
	}
}