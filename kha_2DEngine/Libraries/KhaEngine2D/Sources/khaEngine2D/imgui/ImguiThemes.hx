package khaEngine2D.imgui;

class ImguiThemes
{
	public static var dark: TUITheme = 
    {
		TEXT_SIZE:16,
		TEXT_NORMAL_COLOR: 0xffcac9c7,
		TEXT_HOVER_COLOR: 0xffcac9c7,
		TEXT_PRESSED_COLOR: 0xffcac9c7,
		NORMAL_COLOR: 0xff1A1D22,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};
}

typedef TUITheme = 
{
	var TEXT_SIZE:Int;
    var TEXT_NORMAL_COLOR: Int;
	var TEXT_HOVER_COLOR: Int;
	var TEXT_PRESSED_COLOR: Int;
	var NORMAL_COLOR: Int;
	var HOVER_COLOR: Int;
	var PRESSED_COLOR: Int;
}