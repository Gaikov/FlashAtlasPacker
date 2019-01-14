/**
 * Created by Roman.Gaikov on 1/14/2019
 */

package com.grom.HRLevelExporter.commands
{
import com.grom.HRLevelExporter.LevelExport;
import com.grom.HRLevelExporter.events.PlayLevelSignal;
import com.grom.HRLevelExporter.model.LevelModel;
import com.grom.HRLevelExporter.project.LevelProject;
import com.grom.HRLevelExporter.project.LevelProjectUtils;
import com.grom.lib.debug.Log;
import com.grom.sys.FileUtils;

import flash.desktop.NativeProcess;

import flash.desktop.NativeProcessStartupInfo;
import flash.filesystem.File;

import robotlegs.bender.bundles.mvcs.Command;

import spark.components.Alert;

public class RunLevelCommand extends Command
{
	[Inject]
	public var project:LevelProject;

	[Inject]
	public var signal:PlayLevelSignal;

	public function RunLevelCommand()
	{
	}

	override public function execute():void
	{
		super.execute();

		var path:File = new File(project.workFolder.value);
		var lm:LevelModel = signal.levelModel;
		LevelExport.saveLevel("design_level.xml", path, project.getLevelMovie(lm._levelClass));


		if (!project.gamePath.value)
		{
			LevelProjectUtils.selectGameFile(project);
		}
		else if (!project.workFolder.value)
		{
			LevelProjectUtils.selectWorkingFolder(project);
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
}
}
