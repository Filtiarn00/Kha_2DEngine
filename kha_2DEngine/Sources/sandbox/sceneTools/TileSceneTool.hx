package sandbox.sceneTools;

import kha.Window;
import kha.Framebuffer;
import kha.Assets;
import kha.graphics2.Graphics;
import zui.*;
import zui.Canvas;

class TileSceneTool extends SceneTool
{
	public function new() 
	{
        super();
        name = "Tile";
	}

    public override function guiMainBarRenderer(ui:Zui,graphics:Graphics): Void 
	{
	}

	public override function guiPanelRenderer(ui:Zui,graphics:Graphics): Void 
	{
	}

    public override function OnSceneViewClick(): Void
    {
    }
}