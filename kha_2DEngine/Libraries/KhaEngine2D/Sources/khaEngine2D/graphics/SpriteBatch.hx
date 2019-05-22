package khaEngine2D.graphics;

import kha.Window;
import kha.graphics2.Graphics;
import kha.Color;
import kha.Image;
import khaEngine2D.graphics.Camera;

class SpriteBatch
{
	private static var images:Array<Image> = new Array<Image>();

	
	private static var internalGraphics:Graphics;

	public static function getGraphics(): Graphics
	{
		return internalGraphics;
	}

	public static function begin(graphics:Graphics):Void
	{
		internalGraphics = graphics;
		
		internalGraphics.color = Color.White;
		internalGraphics.begin(Camera.clearColor);
		Camera.set(graphics);

		internalGraphics.scissor(0,0,Window.get(0).width,Window.get(0).height);
	}

	public static function DrawSprite(image:Image, worldPosX:Float, worldPosY:Float, originX:Float, originY:Float):Void
	{
		if (image != null && Camera.isInView(worldPosX,worldPosY))
			internalGraphics.drawImage(image,worldPosX - image.width * originX,worldPosY - image.height * originY);
	}

	public static function DrawSpriteSheet(image:Image, worldPosX:Float, worldPosY:Float, originX:Float, originY:Float, imageX:Float, imageY:Float, imageWidth:Float, imageHeight:Float):Void
	{
		if (image != null && Camera.isInView(worldPosX,worldPosY))
			internalGraphics.drawSubImage(image,worldPosX - imageWidth * originX,worldPosY - imageWidth * originY,imageX,imageY,imageWidth,imageHeight);
	}

	public static function end():Void
	{
		Camera.unset(internalGraphics);
		internalGraphics.end();
	}
}
