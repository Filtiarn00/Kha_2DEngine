package sandbox;

import kha.Color;
//KHA
import kha.Window;
import kha.Framebuffer;
import kha.Assets;

//Game
import game.Game;

//ZUI
import zui.*;
import zui.Themes.TTheme;


//SANDBOX
import sandbox.sceneTools.SceneTool;
import sandbox.sceneTools.TileSceneTool;
import sandbox.sceneTools.EntitySceneTool;
import sandbox.uiElements.UIElement;
import sandbox.uiElements.Panel;
import sandbox.uiElements.MainBar;

class Editor 
{
	var ui:Zui;
	var uiElements:Array<UIElement> = new Array<UIElement>();

	public function new() 
	{
		Assets.loadEverything(loadingFinished);

		SceneTool.addTool(new TileSceneTool());
		SceneTool.addTool(new EntitySceneTool());
	}

	function loadingFinished() 
	{
		ui = new Zui({font: Assets.fonts.Roboto});

		uiElements.push(new MainBar());
		uiElements.push(new Panel());

		kha.System.notifyOnFrames(render);
	}

	public function render(framebuffers: Array<Framebuffer>): Void 
	{
		var window = Window.get(0);
		var graphics = framebuffers[0].g2;

		graphics.begin(false);
		for (i in uiElements)
			i.preGuiRenderer(ui,graphics);
        graphics.end();


		ui.begin(graphics);
		for (i in uiElements)
			i.guiRenderer(ui,graphics);
		ui.end();

		graphics.begin(false);
		for (i in uiElements)
			i.postGuiRenderer(ui,graphics);
        graphics.end();	

		SceneTool.getCurrentTool().OnSceneViewClick();
	}
}