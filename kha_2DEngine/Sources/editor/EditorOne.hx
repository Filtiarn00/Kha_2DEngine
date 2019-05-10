package editor;

//Core Kha
import kha.math.FastVector4;
import kha.Framebuffer;

//Library
import khaEngine2D.editor.Editor;
import khaEngine2D.editor.ui.UICanvas;
import khaEngine2D.editor.ui.UIButton;


class EditorOne extends Editor
{
    private var panelCanvas:UICanvas;

	public function new()
	{
		super();

        panelCanvas = addCanvas('Panel');
        panelCanvas.addUIElement(new UIButton(new FastVector4(0,0,50,50),'Test'));
	}

	public override function load():Void
	{
	}

    public override function update():Void 
	{
		super.update();
	}

	public override function render(frames: Array<Framebuffer>):Void 
	{
		super.render(frames);
	}
}