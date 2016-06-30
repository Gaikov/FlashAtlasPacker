/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 03.01.14
 * Time: 21:46
 * To change this template use File | Settings | File Templates.
 */
package com.grom.HRLevelExporter
{
import com.grom.HRLevelExporter.events.PlayQueryEvent;
import com.grom.HRLevelExporter.model.LevelModel;
import com.grom.HRLevelExporter.project.LevelProject;

import flash.desktop.NativeProcess;
import flash.desktop.NativeProcessStartupInfo;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.filesystem.File;
import flash.net.FileFilter;

import net.maygem.cqrs.presenter.BasePresenter;
import net.maygem.lib.debug.Log;

public class FlashLevelPresenter extends BasePresenter
{
	public function FlashLevelPresenter(view:DisplayObject)
	{
		super(view);
	}
	
	public function get project():LevelProject
	{
		return FlashLevelExporter(view)._project;
	}

	override protected function registerEventListeners():void
	{
		super.registerEventListeners();
		registerEventListener(PlayQueryEvent, onPlayQueryEvent);
	}

	private function onPlayQueryEvent(e:PlayQueryEvent):void
	{
		var path:File = new File(project.exportPath);
		var lm:LevelModel = e.levelModel;
		LevelExport.saveLevel("design_level.xml", path, project.getLevelMovie(lm._levelClass));


		if (!project.gamePath)
		{
			selectGameFile();
		}
		else if (!project.workFolder)
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

		var processInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
		processInfo.executable = new File(project.gamePath);
		processInfo.workingDirectory = new File(project.workFolder);

		var process:NativeProcess = new NativeProcess();
		process.start(processInfo);
	}

	public function selectGameFile():void
	{
		var file:File = new File();
		file.addEventListener(Event.SELECT, function ():void
		{
			project.gamePath = file.nativePath;
		});
		file.browseForOpen("Select game executable", [new FileFilter("Executable", "*.exe")]);
	}

	public function selectWorkingFolder():void
	{
		var file:File = new File();
		file.addEventListener(Event.SELECT, function ():void
		{
			project.workFolder = file.nativePath;
		});
		file.browseForDirectory("Select working folder");
	}
}
}
