package khaEngine2D.imgui;

class ImguiThemes
{
	public static var dark: TUITheme = 
    {
		BUTTON_TEXT_COLOR: 0xffcac9c7,
		BUTTON_NORMAL_COLOR: 0xff484848,
		BUTTON_HOVER_COLOR: 0xff3b3b3b,
		BUTTON_PRESSED_COLOR: 0xff1b1b1b,
	};
}

typedef TUITheme = 
{
    var BUTTON_TEXT_COLOR: Int;
	var BUTTON_NORMAL_COLOR: Int;
	var BUTTON_HOVER_COLOR: Int;
	var BUTTON_PRESSED_COLOR: Int;
}