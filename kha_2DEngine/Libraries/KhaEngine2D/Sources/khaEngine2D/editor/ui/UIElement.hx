package khaEngine2D.editor.ui;

import kha.math.FastVector4;
import kha.graphics2.Graphics;
import kha.Color;

class UIElement
{
    public var rect:FastVector4;
	public var isPressed:Bool;
    public var isHovred:Bool;

    public var onClick:Void -> Void;
	public var colorFrame:Color = Color.White;
	public var colorOn:Color = Color.Green;
	public var colorOff:Color = Color.Black;

    public function new(rect:FastVector4)
	{
        this.rect = rect;
	}

    public function render(graphics:Graphics)
    {
        graphics.drawRect(0,0,0,0,1);
	}

    public function onMouseMove(x:Int, y:Int,z:Int,w:Int):Void
    {
        isHovred = x >= rect.x && x <= rect.x + rect.z && y >= rect.y && y <= rect.y + rect.w;
	}

    public function onMouseDown(button:Int, x:Int, y:Int):Void 
    {
        if (x >= rect.x && x <= rect.x + rect.z && y >= rect.y && y <= rect.y + rect.w)
            isPressed = true;
    }

    public function onMouseUp(button:Int, x:Int, y:Int):Void 
    {
        isPressed = false;
    }
}