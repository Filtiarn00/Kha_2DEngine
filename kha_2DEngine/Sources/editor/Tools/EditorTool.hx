package editor.tools;

import khaEngine2D.imgui.Imgui;
import kha.graphics2.Graphics;

class EditorTool
{
    private var workspaceButtonId:String;
    private var toolButtonId:String;

	public function new()
	{
    }

    public function checkViewportRender(graphics:Graphics):Void
    {
        if (Imgui.getIsToggled(workspaceButtonId) && Imgui.getIsToggled(toolButtonId))
            viewportRenderer(graphics);
    }

    public function checkEditorRender(graphics:Graphics):Void
    {
        if (Imgui.getIsToggled(workspaceButtonId) && Imgui.getIsToggled(toolButtonId))
            editorRenderer(graphics);
    }

    public function viewportRenderer(graphics:Graphics):Void 
    {
        
    }

    public function editorRenderer(graphics:Graphics):Void 
    {
        
    }
}