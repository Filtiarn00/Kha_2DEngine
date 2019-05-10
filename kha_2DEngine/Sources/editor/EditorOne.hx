package editor;

import kha.Assets;
import kha.graphics1.Graphics;
//Core Kha
import kha.math.FastVector4;
import kha.Framebuffer;

//Library
import khaEngine2D.editor.Editor;
import khaEngine2D.imgui.Imgui;

class EditorOne extends Editor
{
	private var imgui:Imgui = new Imgui();

	public function new()
	{
		super();
	}

	public override function load():Void
	{
		super.load();
	}

    public override function update():Void 
	{
		super.update();
	}

	public override function render(frames: Array<Framebuffer>):Void 
	{
		super.render(frames);

		var graphics = frames[0].g2;

		imgui.setFont(Assets.fonts.Roboto);

		imgui.begin(graphics,false);
		imgui.beginLayout(graphics,new FastVector4(100,100,300,300));
		imgui.button(graphics,new FastVector4(0,0,125,50));
		imgui.endLayout(graphics);
		imgui.end(graphics);
	}
}