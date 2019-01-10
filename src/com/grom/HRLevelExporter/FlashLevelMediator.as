/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 03.01.14
 * Time: 21:46
 * To change this template use File | Settings | File Templates.
 */
package com.grom.HRLevelExporter
{
import com.grom.common.BaseMediator;
import com.grom.HRLevelExporter.events.PlayLevelSignal;
import com.grom.HRLevelExporter.model.LevelModel;
import com.grom.HRLevelExporter.project.LevelProject;
import com.grom.lib.debug.LogTracePolicy;
import com.grom.sys.FileUtils;

import flash.desktop.NativeProcess;
import flash.desktop.NativeProcessStartupInfo;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.net.FileFilter;

import com.grom.lib.debug.Log;

import spark.components.Alert;
import spark.events.IndexChangeEvent;

public class FlashLevelMediator extends BaseMediator
{
	[Inject]
	public var view:FlashLevelExporter;

	[Inject]
	public var project:LevelProject;

	override public function initialize():void
	{
		super.initialize();

		view.project = project;

		Log.addAdapter(new LogTracePolicy());
		Log.info("...init app");

		addContextListener(PlayLevelSignal.PLAY_LEVEL_SIGNAL, onPlayQueryEvent);

		view.buttonGameExec.addEventListener(MouseEvent.CLICK, onClickGameExec);
		view.buttonWorkingFolder.addEventListener(MouseEvent.CLICK, onClickWorkingFolder);

		view.listSelectedLevels.addEventListener(IndexChangeEvent.CHANGE, onSelectedLevelChanged);

		project.tryLoad();
	}

	private function onSelectedLevelChanged(event:IndexChangeEvent):void
	{
		var movie:MovieClip;
		var desc:LevelModel = view.listSelectedLevels.selectedItem;
		if (desc)
		{
			movie = project.getLevelMovie(desc._levelClass);
			if (!movie)
			{
				Alert.show("Level movie not found: " + desc._levelClass, "Error");
			}
		}

		view.levelPreview.level = movie;
	}

	private function onPlayQueryEvent(e:PlayLevelSignal):void
	{
		var path:File = new File(project.workFolder.value);
		var lm:LevelModel = e.levelModel;
		LevelExport.saveLevel("design_level.xml", path, project.getLevelMovie(lm._levelClass));


		if (!project.gamePath.value)
		{
			selectGameFile();
		}
		else if (!project.workFolder.value)
		{
			selectWorkingFolder();
		}
		else
		{
			runGame();
		}
	}

	private function runGame():void
	{
		if (project.fileName)
		{
			project.save();
		}

		Log.info("...running game: ", project.gamePath);

		if (!FileUtils.isExists(project.gamePath.value))
		{
			Alert.show("Game executable does not exist!", "Warning");
			return;
		}

		var processInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
		processInfo.executable = new File(project.gamePath.value);
		processInfo.workingDirectory = new File(project.workFolder.value);
		processInfo.arguments = new <String>["-level-design"];

		var process:NativeProcess = new NativeProcess();
		process.start(processInfo);
	}

	private function onClickGameExec(event:MouseEvent):void
	{
		selectGameFile();
	}

	public function selectGameFile():void
	{
		var file:File = new File();
		file.addEventListener(Event.SELECT, function ():void
		{
			project.gamePath.value = file.nativePath;
		});
		file.browseForOpen("Select game executable", [new FileFilter("Executable", "*.exe")]);
	}

	private function onClickWorkingFolder(event:MouseEvent):void
	{
		selectWorkingFolder();
	}

	public function selectWorkingFolder():void
	{
		var file:File = new File();
		file.addEventListener(Event.SELECT, function ():void
		{
			project.workFolder.value = file.nativePath;
		});
		file.browseForDirectory("Select working folder");
	}
}
}
