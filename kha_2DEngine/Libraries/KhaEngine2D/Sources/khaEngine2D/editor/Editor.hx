package khaEngine2D.editor;

//Core Kha
import kha.Assets;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;
import kha.math.FastVector4;

class Editor
{
	private static var i:Editor;

    private var isGamePlaying:Bool;

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

	public function load():Void
	{
		
	}

    public function update():Void 
	{
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
	}
}