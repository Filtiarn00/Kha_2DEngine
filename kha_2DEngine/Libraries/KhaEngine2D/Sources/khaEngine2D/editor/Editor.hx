package khaEngine2D.editor;

//Core Kha
import kha.Assets;
import kha.System;
import kha.Scheduler;
import kha.Framebuffer;

class Editor
{
	private static var i:Editor;
    private static var isPlaying:Bool;

	public static function getGame(): Editor
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
	}
}