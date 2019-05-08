package sandbox.sceneTools;

import kha.Window;
import kha.Framebuffer;
import kha.Assets;
import kha.graphics2.Graphics;
import zui.*;
import zui.Canvas;

class SceneTool
{
	private static var tools:Map<String,SceneTool> = new Map<String,SceneTool>();
	private static var toolNames:Array<String> = new Array<String>();
	private static var currentTool:SceneTool;

	private var name:String;
	
	public static function addTool(tool:SceneTool): Void
	{
		if (tools.get(tool.name) == null)
		{
			tools.set(tool.name,tool);
			toolNames.push(tool.name);
			if (currentTool == null)
				currentTool = tool;
		}
	}

	public static function setTool(name:String): Void
	{
		if (tools.get(name) != null)
			currentTool = tools.get(name);
	}

	public static function getToolNames(): Array<String>
	{
		return toolNames;
	}

	public static function getCurrentTool(): SceneTool
	{	
		return currentTool;
	}

	public function new() 
	{
	}

    public function guiMainBarRenderer(ui:Zui,graphics:Graphics): Void 
	{
	}

	public function guiPanelRenderer(ui:Zui,graphics:Graphics): Void 
	{
	}

	public function OnSceneViewClick(): Void
    {
    }
}