package editor.tools;

import kha.graphics2.Graphics;

import khaEngine2D.imgui.Imgui;
import khaEngine2D.input.Input;
import khaEngine2D.graphics.Camera;
import khaEngine2D.graphics.SpriteBatch;
import khaEngine2D.graphics.TileManager;

class TileSceneEditorTool extends EditorTool
{
	public function new()
	{
        super();

        workspaceButtonId = 'scene_button';
        toolButtonId = 'tile_button';
    }

    public override function viewportRenderer(graphics:Graphics):Void 
    {
        var mouseWorldPosition = Camera.getScreenToWorldSpace(Input.getMousePosition());

        SpriteBatch.begin(false,graphics);
        TileManager.renderPreviewTile('test',mouseWorldPosition.x,mouseWorldPosition.y,0,0,16,16);
        SpriteBatch.end();
    }

    public override function editorRenderer(graphics:Graphics):Void 
    {
        var mouseWorldPosition = Camera.getScreenToWorldSpace(Input.getMousePosition());

		if (Input.getIsMouseDown() && !Imgui.getIsMouseDownInGUI())
		{
			TileManager.addTile('background',mouseWorldPosition.x,mouseWorldPosition.y,0,0);
		}
    }
}