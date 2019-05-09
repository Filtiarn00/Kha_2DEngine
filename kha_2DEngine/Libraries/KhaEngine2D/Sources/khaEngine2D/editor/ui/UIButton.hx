package khaEngine2D.editor.ui;

import sandbox.uiElements.UIElement;
import kha.graphics2.Graphics;
import kha.Color;

class UIButton extends UIElement
{
    public function new(rect:FastVector4)
	{			
        super(rect);
	}

    public override function render(graphics:Graphics)
    {
        super.guiRenderer(graphics);
	}
}