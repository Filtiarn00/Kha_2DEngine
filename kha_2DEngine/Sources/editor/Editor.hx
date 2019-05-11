package editor;

import khaEngine2D.game.Game;
import kha.Color;
import kha.Window;
import kha.System;
import kha.Assets;
import kha.graphics2.Graphics;

//Core Kha
import kha.math.FastVector4;
import kha.Framebuffer;

//Library
import khaEngine2D.imgui.Imgui;
import khaEngine2D.imgui.ImguiThemes.TUITheme;

class Editor
{
	private var isPlaying:Bool;

	public function new()
	{
		System.notifyOnFrames(function (frames) {render(frames); });
		Assets.loadEverything(load);
		Game.get().doUpdate = false;
	}

	public function load():Void
	{
		Imgui.addFont("roboto",Assets.fonts.roboto);
	}

	public function render(frames: Array<Framebuffer>):Void 
	{
		var window = Window.get(0);
		var graphics = frames[0].g2;

		if (!isPlaying)
		{
			Imgui.begin(graphics,false);

			//MainBar
			Imgui.beginWindow(new FastVector4(0,0,window.width,25));
			Imgui.setTheme(normalTheme);
			Imgui.rect(new FastVector4(0,0,window.width,25));
			Imgui.setTheme(darkerTheme);
			Imgui.button('',new FastVector4(0,0,75,25),'Scene');
			Imgui.endWindow();

			//Tool Bar
			Imgui.beginWindow(new FastVector4(0,25,window.width - 300,25));
			Imgui.rect(new FastVector4(0,0,window.width - 300,25));
			Imgui.setTheme(playButton);
			Imgui.button('play_button',new FastVector4(0,0,40,25),'>');
			Imgui.setTheme(seperatorTheme);
			Imgui.rect(new FastVector4(40,0,1,25));
			Imgui.endWindow();

			//Panel
			Imgui.setTheme(darkerTheme);
			Imgui.beginWindow(new FastVector4(window.width - 300,0,300,window.height));
			Imgui.rect(new FastVector4(0,0,300,window.height));
			Imgui.button('',new FastVector4(0,0,150,25),'Properties');
			Imgui.setTheme(normalTheme);
			Imgui.button('',new FastVector4(150,0,150,25),'Test');
			Imgui.setTheme(borderTheme);
			Imgui.rect(new FastVector4(0,0,1,window.height));
			Imgui.endWindow();
		
			Imgui.end();
		}

		if (isPlaying)
		{
			//Tool Bar
			Imgui.setTheme(darkerTheme);
			Imgui.beginWindow(new FastVector4(window.width / 2 - 120,0,120,25));
			Imgui.rect(new FastVector4(0,0,window.width,25));
			Imgui.setTheme(stopButton);
			Imgui.button('stop_button',new FastVector4(0,0,40,25),'[]');
			Imgui.setTheme(seperatorTheme);
			Imgui.rect(new FastVector4(40,0,1,25));
			Imgui.endWindow();
		}

		//Read events
		switch (Imgui.getPressedId())
		{
			case 'play_button': isPlaying = true;
			case 'stop_button': isPlaying = false;
		}

		//Update game if we are playing
		Game.get().doUpdate = isPlaying;
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
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
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
		TEXT_HOVER_COLOR: 0xffcac9c7,
		TEXT_PRESSED_COLOR: 0xffcac9c7,
		NORMAL_COLOR: 0,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};

	public static var playButton: TUITheme = 
	{
		TEXT_SIZE:20,
		TEXT_NORMAL_COLOR: 0xff90D384,
		TEXT_HOVER_COLOR: 0xffcac9c7,
		TEXT_PRESSED_COLOR: 0xffcac9c7,
		NORMAL_COLOR: 0,
		HOVER_COLOR: 0xff3b3b3b,
		PRESSED_COLOR: 0xff1b1b1b,
	};
}