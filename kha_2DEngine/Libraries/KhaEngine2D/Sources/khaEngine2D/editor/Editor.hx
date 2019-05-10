package khaEngine2D.editor;

//Core Kha
import kha.Assets;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;
import kha.math.FastVector4;

import khaEngine2D.editor.ui.UIThemes.TUITheme;
import khaEngine2D.editor.ui.UIThemes;
import khaEngine2D.editor.ui.UIElement;
import khaEngine2D.editor.ui.UICanvas;

class Editor
{
	private static var i:Editor;

	private var uiCanvases:Map<String,UICanvas> = new Map<String,UICanvas>();
	private var theme:TUITheme = UIThemes.dark;
    private var isPlaying:Bool;

	public static function getEditor(): Editor
	{
		return i;
	}

	public function new()
	{
        i = this;

		Scheduler.addTimeTask(update, 0, 1 / 60);
		System.notifyOnFrames(function (frames) {render(frames); });
		Assets.loadEverything(load);
	}

	public  function load():Void
	{
	}

    public function update():Void 
	{
		
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
		var graphics = frames[0].g2;

		graphics.begin(false);
		for (i in uiCanvases)
			i.render(frames[0].g2,this);
		graphics.end();
	}

	public function addCanvas(key:String):UICanvas
	{
		if (uiCanvases.get(key) == null)
		{
			var uiCanvas = new UICanvas();
			uiCanvases.set(key,uiCanvas);
			return uiCanvas;
		}
		return null;
	}

	public function getCanvas(key:String):UICanvas
	{
		return (uiCanvases.get(key));
	}

	public function setTheme(theme:TUITheme) 
	{
		this.theme = theme;
	}

	public function getTheme():TUITheme
	{
		return theme;
	}
}