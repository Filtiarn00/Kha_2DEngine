package khaEngine2D.input;

import kha.math.FastVector2;
import kha.input.Mouse;
import kha.input.KeyCode;
import kha.input.Keyboard;

class Input 
{
    private static var i:Input;

    private var keyDowns:Map<KeyCode,Bool>;
    private var mousePosition = new FastVector2(0,0);
    private var isMouseDown = false;
    private var isMousePressed = false;

    public static function I():Input
    {
        return i;    
    }

	public function new() 
    {
        i = this;

        keyDowns = new Map<KeyCode,Bool>();
		Keyboard.get().notify(onKeyDown, onKeyUp);
        Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, null);
	}

    public function getMousePosition() : FastVector2
    {
        return mousePosition;
    }

    public function isKeyDown(?keyCode:KeyCode):Bool
    {
        //Create keysDown in memory if we don't already have it
        if (!keyDowns.exists(keyCode))
            keyDowns.set(keyCode,false);

        return keyDowns[keyCode];
    }

	private function onKeyDown(keyCode:KeyCode):Void 
    {
        //Create keysDown in memory if we don't already have it
        if (!keyDowns.exists(keyCode))
            keyDowns.set(keyCode,false);

        keyDowns[keyCode] = true;
    }

    private function onKeyUp(keyCode:KeyCode):Void 
    {
        keyDowns[keyCode] = false;
    }   

    public function getIsMouseDown(): Bool 
    {
        return isMouseDown;
    }

    public function getIsMousePressed(): Bool 
    {
        if (!isMousePressed && isMouseDown)
        {
            isMousePressed = true;
            return true;
        }
        return false;
    }

    private function onMouseDown(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = true;	
	}

    private function onMouseUp(x:Int, y:Int, cx:Int):Void 
    {
        isMouseDown = false;	
        isMousePressed = false;
	}

    private function onMouseMove(x:Int, y:Int, cx:Int, cy:Int):Void 
    {
        mousePosition.x = x;
        mousePosition.y = y;	
	}
}
