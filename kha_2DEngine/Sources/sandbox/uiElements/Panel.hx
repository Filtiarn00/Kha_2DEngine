package sandbox.uiElements;

import kha.Window;
import kha.Framebuffer;
import kha.Assets;
import kha.graphics2.Graphics;
import zui.*;
import zui.Canvas;

import sandbox.sceneTools.SceneTool;

class Panel extends UIElement
{
	 public function new() 
    {
        super();
    }

    public override function preGuiRenderer(ui:Zui,graphics:Graphics): Void
    {
        var window = Window.get(0);

        graphics.color = ui.ops.theme.WINDOW_BG_COL;
        graphics.fillRect(window.width - 300,0,300,window.height);

    }

    public override function postGuiRenderer(ui:Zui,graphics:Graphics): Void
    {
		var window = Window.get(0);

        graphics.color = ui.ops.theme.ACCENT_COL;
        graphics.fillRect(window.width - 300,22,3,1);
    }

	public override function guiRenderer(ui:Zui,graphics:Graphics): Void 
	{
        var window = Window.get(0);

		if (ui.window(Id.handle(), window.width - 300, 0, 300, window.height)) 
        {
			var htab = Id.handle({position: 0});
			if (ui.tab(htab, "Editor"))
            {
                var v = Id.handle();
				ui.combo(v, SceneTool.getToolNames(), "Tools", true);
                SceneTool.getCurrentTool().guiPanelRenderer(ui,graphics);

                if (v.changed)
                    SceneTool.setTool(SceneTool.getToolNames()[v.position]);
			}
			if (ui.tab(htab, "Outline")) 
            {
			}
			if (ui.tab(htab, "Assets")) 
            {
			}
		}
	}
}