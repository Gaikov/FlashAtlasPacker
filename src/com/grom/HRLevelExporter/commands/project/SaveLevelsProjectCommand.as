/**
 * Created by Roman.Gaikov on 1/15/2019
 */

package com.grom.HRLevelExporter.commands.project
{
import com.grom.HRLevelExporter.project.LevelProject;

import flash.events.Event;
import flash.filesystem.File;

import robotlegs.bender.bundles.mvcs.Command;

public class SaveLevelsProjectCommand extends Command
{
	[Inject]
	public var project:LevelProject;

	public function SaveLevelsProjectCommand()
	{
	}

	override public function execute():void
	{
		super.execute();

		if (!project.fileName)
		{
			var file:File = new File();
			file.addEventListener(Event.SELECT, function ():void
			{
				project.fileName = file.nativePath;
				project.save();
			});
			file.browseForSave("Save Project");
		}
		else
		{
			project.save();
		}
	}
}
}
