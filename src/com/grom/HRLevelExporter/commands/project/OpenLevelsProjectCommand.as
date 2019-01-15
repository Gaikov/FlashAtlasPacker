/**
 * Created by Roman.Gaikov on 1/15/2019
 */

package com.grom.HRLevelExporter.commands.project
{
import com.grom.HRLevelExporter.project.LevelProject;

import flash.events.Event;
import flash.filesystem.File;
import flash.net.FileFilter;

import robotlegs.bender.bundles.mvcs.Command;

public class OpenLevelsProjectCommand extends Command
{
	[Inject]
	public var project:LevelProject;

	public function OpenLevelsProjectCommand()
	{
	}

	override public function execute():void
	{
		super.execute();

		var file:File = new File();
		file.addEventListener(Event.SELECT, function ():void
		{
			project.fileName = file.nativePath;
			project.tryLoad();
		});
		file.browseForOpen("Open levels project", [new FileFilter("Project file", "*.xml")]);
	}
}
}
