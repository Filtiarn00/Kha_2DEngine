package khaEngine2D.editor.ui;

import kha.math.FastVector4;
import kha.graphics2.Graphics;
import kha.Color;

import khaEngine2D.editor.ui.UIElement;

class UIButton extends UIElement
{
    public function new(rect:FastVector4, text:String)
	{			
        super(rect);
	}

    public override function render(graphics:Graphics, editor:Editor)
    {
        super.render(graphics,editor);

        var color = editor.getTheme().BUTTON_NORMAL_COLOR;

        if (isHovred)
            color = editor.getTheme().BUTTON_HOVER_COLOR;
        if (isPressed)
            color = editor.getTheme().BUTTON_PRESSED_COLOR;

        graphics.color = color;
        graphics.fillRect(rect.x,rect.y,rect.z,rect.w);

        graphics.color = editor.getTheme().BUTTON_TEXT_COLOR;
	}
}