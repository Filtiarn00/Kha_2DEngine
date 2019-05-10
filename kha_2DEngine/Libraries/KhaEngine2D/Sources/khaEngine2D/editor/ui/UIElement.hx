package khaEngine2D.editor.ui;

import kha.math.FastVector4;
import kha.graphics2.Graphics;
import kha.Color;

class UIElement
{
    public var rect:FastVector4;
    public var String:text;
	public var isPressed:Bool;
    public var isHovred:Bool;

    public var onClick:Void -> Void;

    public function new(rect:FastVector4, text:String)
	{
        this.rect = rect;
        this.text = text;
	}

    public function render(graphics:Graphics, editor:Editor)
    {
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