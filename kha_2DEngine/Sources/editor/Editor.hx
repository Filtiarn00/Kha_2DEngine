package editor;

//Kha
import kha.math.FastVector2;
import kha.Window;
import kha.System;
import kha.Assets;
import kha.math.FastVector4;
import kha.Framebuffer;

//Engine
import khaEngine2D.game.Game;
import khaEngine2D.graphics.Camera;
import khaEngine2D.input.Input;
import khaEngine2D.imgui.Imgui;
import khaEngine2D.imgui.ImguiThemes.TUITheme;

//Editor
import editor.tools.EditorTool;
import editor.tools.TileSceneEditorTool;
import editor.tools.EntitySceneEditorTool;

class Editor
{
	private var isPlaying:Bool;
	private var windowSize:FastVector2 = new FastVector2();
	private var mouseWorldPosition:FastVector2 = new FastVector2();

	private var editorTools:Array<EditorTool> = new Array<EditorTool>();

	public function new()
	{
		windowSize.x = Window.get(0).width;
		windowSize.y = Window.get(0).height;

		System.notifyOnFrames(function (frames) {render(frames); });
		Assets.loadEverything(load);
		Game.get().doUpdate = false;

		editorTools.push(new TileSceneEditorTool());
		editorTools.push(new EntitySceneEditorTool());
	}

	public function load():Void
	{
		Imgui.addFont("roboto",Assets.fonts.roboto);

		Imgui.setIsToggled('scene_button',true);
		Imgui.setIsToggled('tile_button',true);
		Imgui.addToggleGroup('scene_tools',['tile_button','entity_button']);
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
		windowSize.x = Window.get(0).width;
		windowSize.y = Window.get(0).height;
		mouseWorldPosition = Camera.getScreenToWorldSpace(Input.getMousePosition());

		var graphics = frames[0].g2;

		if (!isPlaying)
			for (i in editorTools)
				i.checkViewportRender(graphics);

		Imgui.begin(graphics,false);

		//Main UI
		if (!isPlaying)
		{
			//MainBar
			Imgui.setTheme(normalTheme,normalTheme);
			Imgui.beginWindow(new FastVector4(0,0,windowSize.x,25));
			Imgui.setTheme(normalTheme,darkerTheme);
			Imgui.button('scene_button',new FastVector4(0,0,75,25),'Scene',true,'workplaces',false);
			Imgui.endWindow();

			//Tool Settings Bar
			{
				//Background
				Imgui.setTheme(darkerTheme,darkerTheme);
				Imgui.beginWindow(new FastVector4(0,25,windowSize.x - 300,25));
		
				//Scene
				if (Imgui.getIsToggled('scene_button'))
				{
					Imgui.setTheme(playButton,stopButton);
					Imgui.beginLayout(0);
					Imgui.button('play_button',new FastVector4(0,0,40,25),Imgui.getIsToggled('play_button') ? '[]' : '>',true,'',true);
					Imgui.setTheme(seperatorTheme,seperatorTheme);
					Imgui.rect(new FastVector4(0,0,1,25));
					Imgui.setTheme(toolButton,toolButtonToggled);
					Imgui.button('tile_button',new FastVector4(0,0,40,25),'T',true,'scene_tools',false);
					Imgui.button('entity_button',new FastVector4(0,0,40,25),'E',true,'scene_tools',false);
					Imgui.setTheme(seperatorTheme,seperatorTheme);
					Imgui.rect(new FastVector4(0,0,1,25));
					Imgui.endLayouy();
				}

				Imgui.endWindow();
			}

			//Viewport
			if (Imgui.getIsToggled('scene_button'))
			{
				//Viewport
				Imgui.setTheme(viewPortTextTheme,viewPortTextTheme);
				Imgui.beginWindow(new FastVector4(10,windowSize.y - 50,200,200));
				Imgui.beginLayout(1);
				Imgui.text(new FastVector4(0,0,200,16),'mouse: ' + mouseWorldPosition.x + ',' + mouseWorldPosition.y);
				Imgui.endLayouy();
				Imgui.endWindow();
			}

			//Properties
			Imgui.setTheme(darkerTheme,darkerTheme);
			Imgui.beginWindow(new FastVector4(windowSize.x - 300,0,300,(Std.int(windowSize.y / 1.5))));
			Imgui.text(new FastVector4(10,10,100,25),'Properties');
			Imgui.setTheme(borderTheme,normalTheme);
			Imgui.rect(new FastVector4(0,0,1,windowSize.y));
			Imgui.endWindow();

			//Outline
			Imgui.setTheme(darkerTheme,darkerTheme);
			Imgui.beginWindow(new FastVector4(windowSize.x - 300,(Std.int(windowSize.y / 1.5)),300,(Std.int(windowSize.y / 2.5))));
			Imgui.text(new FastVector4(10,10,100,25),'Outline');
			Imgui.setTheme(borderTheme,normalTheme);
			Imgui.rect(new FastVector4(0,0,1,windowSize.y));
			Imgui.rect(new FastVector4(0,0,windowSize.x,1));
			Imgui.endWindow();
		}

		//Is Playing UI
		if (isPlaying)
		{
			//Play Bar
			{
				//Background
				Imgui.setTheme(darkerTheme,darkerTheme);
				Imgui.beginWindow(new FastVector4(Std.int(windowSize.x / 2) - 60,0,120,25));
				Imgui.setTheme(playButton,stopButton);
				Imgui.button('play_button',new FastVector4(0,0,40,25),Imgui.getIsToggled('play_button') ? '[]' : '>',true,'',true);
				Imgui.setTheme(seperatorTheme,seperatorTheme);
				Imgui.rect(new FastVector4(40,0,1,25));
			}

			Imgui.endWindow();
		}
		
		Imgui.end();

		//Read events
		switch (Imgui.getPressedId())
		{
			case 'play_button': isPlaying = !isPlaying;
		}

		if (!isPlaying)
			for (i in editorTools)
				i.checkEditorRender(graphics);


		//Update game if we are playing
		Game.get().doUpdate = isPlaying;
	}

	public static var viewPortTextTheme:TUITheme =
	{
		TEXT_SIZE:16,
		TEXT_NORMAL_COLOR: 0xff909090,
		TEXT_HOVER_COLOR: 0,
		TEXT_PRESSED_COLOR: 0,
		NORMAL_COLOR: 0,
		HOVER_COLOR: 0,
		PRESSED_COLOR: 0,
	}
	
	public static var normalTheme: TUITheme = 
	{
		TEXT_SIZE:16,
		TEXT_NORMAL_COLOR: 0xff627285,
		TEXT_HOVER_COLOR: 0xff627285,
		TEXT_PRESSED_COLOR: 0xff627285,
		NORMAL_COLOR: 0xff1A1D22,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};

	public static var darkerTheme: TUITheme = 
	{
		TEXT_SIZE:16,
		TEXT_NORMAL_COLOR: 0xff627285,
		TEXT_HOVER_COLOR: 0xff627285,
		TEXT_PRESSED_COLOR: 0xff627285,
		NORMAL_COLOR: 0xff101316,
		HOVER_COLOR: 0xff101316,
		PRESSED_COLOR: 0xff101316,
	};

	public static var seperatorTheme: TUITheme = 
	{
		TEXT_SIZE:16,
		TEXT_NORMAL_COLOR: 0xff627285,
		TEXT_HOVER_COLOR: 0xff627285,
		TEXT_PRESSED_COLOR: 0xff627285,
		NORMAL_COLOR: 0xff3C4651,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};

	public static var borderTheme: TUITheme = 
	{
		TEXT_SIZE:16,
		TEXT_NORMAL_COLOR: 0xff627285,
		TEXT_HOVER_COLOR: 0xff627285,
		TEXT_PRESSED_COLOR: 0xff627285,
		NORMAL_COLOR: 0xff000000,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};

	public static var stopButton: TUITheme = 
	{
		TEXT_SIZE:16,
		TEXT_NORMAL_COLOR: 0xffD38484,
		TEXT_HOVER_COLOR: 0xffD38484,
		TEXT_PRESSED_COLOR: 0xffD38484,
		NORMAL_COLOR: 0,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};

	public static var playButton: TUITheme = 
	{
		TEXT_SIZE:20,
		TEXT_NORMAL_COLOR: 0xff90D384,
		TEXT_HOVER_COLOR: 0xff90D384,
		TEXT_PRESSED_COLOR: 0xff90D384,
		NORMAL_COLOR: 0,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};

	public static var toolButton: TUITheme = 
	{
		TEXT_SIZE:18,
		TEXT_NORMAL_COLOR: 0xff627285,
		TEXT_HOVER_COLOR: 0xff627285,
		TEXT_PRESSED_COLOR: 0xff627285,
		NORMAL_COLOR: 0,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};

	public static var toolButtonToggled: TUITheme = 
	{
		TEXT_SIZE:18,
		TEXT_NORMAL_COLOR: 0xffDD7A37,
		TEXT_HOVER_COLOR: 0xffDD7A37,
		TEXT_PRESSED_COLOR: 0xffDD7A37,
		NORMAL_COLOR: 0,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};
}