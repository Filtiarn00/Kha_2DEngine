package khaEngine2D.editor.ui;

import kha.math.FastVector4;
import kha.graphics2.Graphics;
import kha.Color;

import khaEngine2D.editor.ui.UIElement;

class UIButton extends UIElement
{
    public function new(rect:FastVector4)
	{			
        super(rect);
	}

    public override function render(graphics:Graphics)
    {
        super.render(graphics);

        graphics.drawRect(rect.x,rect.y,rect.z,rect.w,1);
	}
}