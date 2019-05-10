package khaEngine2D.imgui;

import kha.Font;
import kha.Color;
import kha.input.Mouse;
import kha.math.FastVector2;
import kha.Window;
import kha.math.FastVector4;
import kha.graphics2.Graphics;
import khaEngine2D.imgui.ImguiThemes;

class Imgui
{
    private var font:Font;
    private var layoutRect:FastVector4 = new FastVector4(0,0);
    private var mousePosition:FastVector2 = new FastVector2(-1,-1);
    private var isMouseDown:Bool = false;
    private var theme = ImguiThemes.dark;

    public function new()
    {
         Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, null);
    }

    public function beginLayout(graphics:Graphics,rect:FastVector4)
    {
        graphics.scissor(cast(rect.x,Int),cast(rect.y,Int),cast(rect.z,Int),cast(rect.w,Int));
        layoutRect = rect;
    }

    public function endLayout(graphics:Graphics)
    {
        layoutRect = new FastVector4(0,0,0,0);
        graphics.scissor(0,0,Window.get(0).width,Window.get(0).height);
    }

    public function begin(graphics:Graphics,clear:Bool):Void
    {    
        graphics.begin(clear);
    }

    public function end(graphics:Graphics):Void
    {    
        graphics.end();
    }

    public function button(graphics:Graphics, rect:FastVector4):Void
    {    
        var color = theme.BUTTON_NORMAL_COLOR;

       if (isMouseInRect(getWorlRect(rect)))
       {
            color = theme.BUTTON_HOVER_COLOR;
            if (isMouseDown)
                color = theme.BUTTON_PRESSED_COLOR;
        }
    
        graphics.color = color;
        graphics.fillRect(rect.x + layoutRect.x,rect.y + layoutRect.y,rect.z,rect.w);
        graphics.color = Color.White;

        if (font != null)
        {
            graphics.font = font;
            graphics.fontSize = 16;
            graphics.drawString('test',rect.x,rect.y);
        }
    }

    public function setFont(font:Font):Void
    {
        this.font = font;
    }

    private function getWorlRect(rect:FastVector4):FastVector4
    {
        return new FastVector4(rect.x + layoutRect.x,rect.y + layoutRect.y, rect.z, rect.w);
    }

    private function onMouseDown(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = true;	
	}

    private function onMouseUp(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = false;	
	}

    private function onMouseMove(x:Int, y:Int, cx:Int, cy:Int):Void 
    {
        mousePosition.x = x;
        mousePosition.y = y;	
	}

    private function isMouseInRect(rect:FastVector4):Bool
    {
        return mousePosition.x >= rect.x && mousePosition.x <= rect.x + rect.z && mousePosition.y >= rect.y && mousePosition.y <= rect.y + rect.w;
    }
}