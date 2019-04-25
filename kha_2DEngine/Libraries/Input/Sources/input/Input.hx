package input;

import kha.input.KeyCode;
import kha.input.Keyboard;

class Input 
{
    private static var i:Input;

    private var keyDowns:Map<KeyCode,Bool>;

    public static function I():Input
    {
        return i;    
    }

	public function new() 
    {
        i = this;

        keyDowns = new Map<KeyCode,Bool>();
		Keyboard.get().notify(onKeyDown, onKeyUp);
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
}
