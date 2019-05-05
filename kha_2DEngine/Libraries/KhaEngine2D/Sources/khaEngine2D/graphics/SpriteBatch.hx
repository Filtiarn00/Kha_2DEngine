package khaEngine2D.graphics;

import kha.System;
import kha.graphics2.Graphics;
import kha.graphics2.GraphicsExtension;
import kha.Color;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;
import kha.Image;
import khaEngine2D.graphics.Camera;

class SpriteBatch
{
	private static var images:Array<Image> = new Array<Image>();
	private static var internalGraphics:Graphics;
	private static var internalCamera:Camera;

	public static function begin(graphics:Graphics):Void
	{
		internalGraphics = graphics;
		internalCamera = Camera.GetCamera();

		internalGraphics.begin(internalCamera.clearColor);
		internalCamera.set(graphics);
	}

	public static function DrawSprite(image:Image, worldPosX:Float, worldPosY:Float, originX:Float, originY:Float):Void
	{
		if (image != null && internalCamera.isInView(worldPosX,worldPosY))
			internalGraphics.drawImage(image,worldPosX - image.width * originX,worldPosY - image.height * originY);
	}

	public static function DrawSpriteSheet(image:Image, worldPosX:Float, worldPosY:Float, originX:Float, originY:Float, imageX:Float, imageY:Float, imageWidth:Float, imageHeight:Float):Void
	{
		if (image != null && internalCamera.isInView(worldPosX,worldPosY))
			internalGraphics.drawSubImage(image,worldPosX - imageWidth * originX,worldPosY - imageWidth * originY,imageX,imageY,imageWidth,imageHeight);
	}

	public static function end():Void
	{
		internalCamera.unset(internalGraphics);
		internalGraphics.end();
	}
}
