package khaEngine2D.editor.ui;

import kha.graphics2.Graphics;
import kha.input.Mouse;

class UICanvas
{
    private var uiElements:Array<UIElement> = new Array<UIElement>();

    public function new()
	{		
        Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, null);	
	}

    public function render(graphics:Graphics)
    {
        for (i in uiElements)
            i.render(graphics);
	}

    public function addUIElement(uiElement:UIElement) 
    {
        uiElements.push(uiElement);    
    }

    public function onMouseMove(x:Int, y:Int,z:Int,w:Int):Void
    {
        for (i in uiElements)
            i.onMouseMove(x,y,z,w);
	}

    public function onMouseDown(button:Int, x:Int, y:Int):Void 
    {
        for (i in uiElements)
            i.onMouseDown(button,x,y);
    }

    public function onMouseUp(button:Int, x:Int, y:Int):Void 
    {
        for (i in uiElements)
            i.onMouseUp(button,x,y);
    }
}