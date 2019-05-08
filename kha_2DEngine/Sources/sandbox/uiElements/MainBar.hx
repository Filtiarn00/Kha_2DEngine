package sandbox.uiElements;

import kha.Color;
import kha.Window;
import kha.Framebuffer;
import kha.Assets;
import kha.graphics2.Graphics;
import zui.*;

import sandbox.uiElements.UIElement;

class MainBar extends UIElement
{
    public function new() 
    {
        super();
    }

    public override function preGuiRenderer(ui:Zui,graphics:Graphics): Void
    {
        var window = Window.get(0);

        graphics.color = ui.ops.theme.SEPARATOR_COL;
        graphics.fillRect(0,0,100,26);

        graphics.color = ui.ops.theme.PANEL_BG_COL;
        graphics.fillRect(0,22,window.width,26);
    }

    public override function postGuiRenderer(ui:Zui,graphics:Graphics): Void
    {
        graphics.color = ui.ops.theme.ACCENT_COL;
        graphics.fillRect(0,22,102,1);
    }

	public override function guiRenderer(ui:Zui,graphics:Graphics): Void 
	{
        var window = Window.get(0);
    
        if (ui.window(Id.handle(), 100, 0, window.width, 26)) 
        {
			var htab = Id.handle({position: 0});
			if (ui.tab(htab, "Scene"))
            {
			}
			if (ui.tab(htab, "Entity")) 
            {
			}
			if (ui.tab(htab, "Code")) 
            {
			}
		}
	}
}