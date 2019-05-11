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
    //Graphics
    private static var graphics:Graphics;

    //Themeing
    private static var theme = ImguiThemes.dark;

    //Fonts
    private static var fonts:Map<String,Font> = new Map<String,Font>();
    private static var currentFont:Font;

    //Input
    private static var mousePosition:FastVector2 = new FastVector2(-1,-1);
    private static var isMouseDown:Bool = false;
    private static var isMousePressed:Bool = false;

    //Layout
    private static var windowRect:FastVector4 = new FastVector4(0,0);

    //States
    private static var pressedId:String;
    private static var pressedThisFrame:Bool;

    public static function begin(graphics:Graphics,clear:Bool):Void
    {    
        if (Imgui.graphics == null)
            Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, null);
        
        Imgui.graphics = graphics;
        graphics.begin(clear);
    }

    public static function end():Void
    {    
        graphics.end();
    }

    public static function beginWindow(rect:FastVector4)
    {
        graphics.scissor(cast(rect.x,Int),cast(rect.y,Int),cast(rect.z,Int),cast(rect.w,Int));
        windowRect = rect;
    }

    public static function endWindow()
    {
        windowRect = new FastVector4(0,0,0,0);
        graphics.scissor(0,0,Window.get(0).width,Window.get(0).height);
    }

    public static function button(id:String,rect:FastVector4,text:String):Void
    {   
        var inRect = isMouseInRect(getWorlRect(rect));
        graphics.color = inRect ?  (isMouseDown ? theme.PRESSED_COLOR : theme.HOVER_COLOR) : theme.NORMAL_COLOR;
        graphics.fillRect(rect.x + windowRect.x,rect.y + windowRect.y,rect.z,rect.w);

        if (currentFont != null)
        {
            graphics.color = inRect ?  (isMouseDown ? theme.TEXT_PRESSED_COLOR : theme.TEXT_HOVER_COLOR) : theme.TEXT_NORMAL_COLOR;
            graphics.fontSize = theme.TEXT_SIZE;

            var x  = windowRect.x + rect.x + (rect.z / 2) - cast(currentFont.width(graphics.fontSize,text),Float) / 2;
            var y = windowRect.y + rect.y + (rect.w / 2) - cast(currentFont.height(graphics.fontSize),Float) / 2;
            graphics.drawString(text,x,y);
        }

        if (inRect && isMouseDown && !isMousePressed)
        {
            pressedId = id;
            pressedThisFrame = true;
            isMousePressed = true;
        }

        graphics.color = Color.White;
    }

    public static function rect(rect:FastVector4):Void
    {   
        graphics.color = theme.NORMAL_COLOR;
        graphics.fillRect(rect.x + windowRect.x,rect.y + windowRect.y,rect.z,rect.w);
        graphics.color = Color.White;
    }

    public static function setTheme(theme:TUITheme):Void
    {
        Imgui.theme = theme;
    }

    public static function addFont(key:String,font:Font):Void 
    {
        if (fonts.get(key) == null)
        {
            if (currentFont == null)
            {
                currentFont = font;
                graphics.font = currentFont;
            }

            fonts.set(key,font);
        }
    }

    public static function setFont(key:String):Void
    {
        Imgui.currentFont = fonts.get(key);
        graphics.font = currentFont;
    }

    public static function getPressedId():String 
    {
        if (pressedThisFrame)
        {
            pressedThisFrame = false;
            return pressedId;
        }
        return '';
    }

    private static function getWorlRect(rect:FastVector4):FastVector4
    {
        return new FastVector4(rect.x + windowRect.x,rect.y + windowRect.y, rect.z, rect.w);
    }

    private static function onMouseDown(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = true;	
	}

    private static function onMouseUp(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = false;	
        isMousePressed = false;
        pressedThisFrame = false;
	}

    private static function onMouseMove(x:Int, y:Int, cx:Int, cy:Int):Void 
    {
        mousePosition.x = x;
        mousePosition.y = y;	
	}

    private static function isMouseInRect(rect:FastVector4):Bool
    {
        return mousePosition.x >= rect.x && mousePosition.x <= rect.x + rect.z && mousePosition.y >= rect.y && mousePosition.y <= rect.y + rect.w;
    }
}