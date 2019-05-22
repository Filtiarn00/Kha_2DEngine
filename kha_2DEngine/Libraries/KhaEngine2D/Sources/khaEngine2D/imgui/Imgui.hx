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
    private static var toggledTheme = ImguiThemes.dark;

    //Fonts
    private static var fonts:Map<String,Font> = new Map<String,Font>();
    private static var currentFont:Font;

    //Input
    private static var mousePosition:FastVector2 = new FastVector2(-1,-1);
    private static var isMouseDown:Bool = false;
    private static var isMouseDownInGUI = false;
    private static var isMousePressed:Bool = false;

    //Window
    private static var windowRect:FastVector4 = new FastVector4(0,0);

    //Layout
    private static var layoutPosition:FastVector2 = new FastVector2(0,0);
    private static var doLayout:Bool = false;
    private static var layoutType:Int = 0;
    
    //States
    private static var toggleGroups:Map<String,Array<String>> = new Map<String,Array<String>>();
    private static var toggled:Map<String,String> = new Map<String,String>();
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

    public static function beginWindow(rect:FastVector4,?renderWindow:Bool):Void
    {
        graphics.scissor(cast(rect.x,Int),cast(rect.y,Int),cast(rect.z,Int),cast(rect.w,Int));

        var isInRect = isMouseInRect(getWorlRect(rect));
        graphics.color = theme.NORMAL_COLOR;
        graphics.fillRect(rect.x,rect.y,rect.z,rect.w);
        windowRect = rect;

        if (isInRect && isMouseDown)
            isMouseDownInGUI = true;

        graphics.color = Color.White;
    }

    public static function endWindow():Void
    {
        windowRect = new FastVector4(0,0,0,0);
        graphics.scissor(0,0,Window.get(0).width,Window.get(0).height);
    }

    public static function beginLayout(layoutType:Int):Void
    {
        Imgui.layoutType = layoutType;
        doLayout = true;
    }

    public static function endLayouy():Void
    {
        layoutPosition = new FastVector2(0,0);
        doLayout = false;
    }

    public static function continueLayout(rect:FastVector4):FastVector4
    {
        if (doLayout)
        {
            if (layoutType == 0)
            {
                rect.x += layoutPosition.x;
                layoutPosition.x += rect.z;
            }

            if (layoutType == 1)
            {
                rect.y += layoutPosition.y;
                layoutPosition.y += rect.w;
            }
        }

        return rect;
    }

    public static function button(id:String,rect:FastVector4,text:String,isAToggle:Bool,toggledGroupId:String,canUntoggle:Bool):Void
    {   
        rect = continueLayout(rect);

        var targetTheme = isAToggle && toggled.get(id) != null ? toggledTheme : theme;
        var isInRect = isMouseInRect(getWorlRect(rect));
        graphics.color = isInRect ?  (isMouseDown ? targetTheme.PRESSED_COLOR : targetTheme.HOVER_COLOR) : targetTheme.NORMAL_COLOR;
        graphics.fillRect(rect.x + windowRect.x,rect.y + windowRect.y,rect.z,rect.w);

        if (currentFont != null)
        {
            graphics.color = isInRect ?  (isMouseDown ? targetTheme.TEXT_PRESSED_COLOR : targetTheme.TEXT_HOVER_COLOR) : targetTheme.TEXT_NORMAL_COLOR;
            graphics.fontSize = targetTheme.TEXT_SIZE;

            var x  = windowRect.x + rect.x + (rect.z / 2) - cast(currentFont.width(graphics.fontSize,text),Float) / 2;
            var y = windowRect.y + rect.y + (rect.w / 2) - cast(currentFont.height(graphics.fontSize),Float) / 2;
            graphics.drawString(text,x,y);
        }

        if (isInRect && isMouseDown)
            isMouseDownInGUI = true;

        if (isInRect && isMouseDown && !isMousePressed)
        {
            pressedId = id;
            pressedThisFrame = true;
            isMousePressed = true;

            if (isAToggle)
            {
                if (toggled.get(id) == null)
                    toggled.set(id,id);
                else if (canUntoggle && toggled.get(id) != null)
                    toggled.remove(id);

                if (toggled.get(id) != null)
                {
                    var toggledGroup = toggleGroups.get(toggledGroupId);

                    if (toggledGroup != null)
                        for (i in toggledGroup)
                            if (i != id)
                                setIsToggled(i,false);
                }
            }
        }

        graphics.color = Color.White;
    }

    public static function text(rect:FastVector4,text:String):Void
    {
         rect = continueLayout(rect);

        if (currentFont != null)
        {
            graphics.color = theme.TEXT_NORMAL_COLOR;
            graphics.fontSize = theme.TEXT_SIZE;

            var x  = windowRect.x + rect.x;
            var y = windowRect.y + rect.y;
            
            graphics.drawString(text,x,y);
        }

        graphics.color = Color.White;
    }

    public static function rect(rect:FastVector4):Void
    {   
        rect = continueLayout(rect);
        var isInRect = isMouseInRect(getWorlRect(rect));

        graphics.color = theme.NORMAL_COLOR;
        graphics.fillRect(rect.x + windowRect.x,rect.y + windowRect.y,rect.z,rect.w);
        graphics.color = Color.White;

        if (isInRect && isMouseDown)
            isMouseDownInGUI = true;
    }

    public static function setTheme(theme:TUITheme,toggledTheme:TUITheme):Void
    {
        Imgui.theme = theme;
        Imgui.toggledTheme = toggledTheme;
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

    public static function addToggleGroup(key:String,ids:Array<String>) 
    {
        toggleGroups.set(key,ids);
    }

    public static function addToToggleGroup(groupId:String,elementId:String) 
    {
        if (toggleGroups.get(groupId) == null)
            toggleGroups.set(groupId,new Array());

        if (toggleGroups.get(groupId).indexOf(elementId) == - 1)
            toggleGroups.get(groupId).push(elementId);
    }

    public static function setIsToggled(key:String, state:Bool) 
    {
        if (state == false)
            toggled.remove(key);
        else toggled.set(key,key);
    }

    public static function getIsToggled(key:String):Bool
    {
        return toggled.get(key) != null;
    }

    private static function getWorlRect(rect:FastVector4):FastVector4
    {
        return new FastVector4(rect.x + windowRect.x,rect.y + windowRect.y, rect.z, rect.w);
    }

    public static function getIsMouseDownInGUI():Bool
    {
        return isMouseDownInGUI;
    }

    private static function onMouseDown(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = true;	
	}

    private static function onMouseUp(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = false;	
        isMouseDownInGUI = false;
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