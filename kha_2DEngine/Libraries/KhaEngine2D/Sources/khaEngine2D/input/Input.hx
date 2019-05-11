package khaEngine2D.input;

import kha.math.FastVector2;
import kha.input.Mouse;
import kha.input.KeyCode;
import kha.input.Keyboard;

class Input 
{
    private static var keyDowns:Map<KeyCode,Bool> = new Map<KeyCode,Bool>();
    private static var mousePosition = new FastVector2(0,0);
    private static var isMouseDown = false;
    private static var isMousePressed = false;

	public static function Init() 
    {
		Keyboard.get().notify(onKeyDown, onKeyUp);
        Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, null);
	}

    public static function getMousePosition() : FastVector2
    {
        return mousePosition;
    }

    public static function isKeyDown(?keyCode:KeyCode):Bool
    {
        //Create keysDown in memory if we don't already have it
        if (!keyDowns.exists(keyCode))
            keyDowns.set(keyCode,false);

        return keyDowns[keyCode];
    }

	private static function onKeyDown(keyCode:KeyCode):Void 
    {
        //Create keysDown in memory if we don't already have it
        if (!keyDowns.exists(keyCode))
            keyDowns.set(keyCode,false);

        keyDowns[keyCode] = true;
    }

    private static function onKeyUp(keyCode:KeyCode):Void 
    {
        keyDowns[keyCode] = false;
    }   

    public static function getIsMouseDown(): Bool 
    {
        return isMouseDown;
    }

    public static function getIsMousePressed(): Bool 
    {
        if (!isMousePressed && isMouseDown)
        {
            isMousePressed = true;
            return true;
        }
        return false;
    }

    private static function onMouseDown(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = true;	
	}

    private static function onMouseUp(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = false;	
        isMousePressed = false;
	}

    private static function onMouseMove(x:Int, y:Int, cx:Int, cy:Int):Void 
    {
        mousePosition.x = x;
        mousePosition.y = y;	
	}
}
