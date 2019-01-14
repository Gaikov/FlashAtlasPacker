/**
 * Created by Roman.Gaikov on 1/14/2019
 */

package com.grom.HRLevelExporter.project
{
import flash.events.Event;
import flash.filesystem.File;
import flash.net.FileFilter;

public class LevelProjectUtils
{
	static public function selectGameFile(project:LevelProject):void
	{
		var file:File = new File();
		file.addEventListener(Event.SELECT, function ():void
		{
			project.gamePath.value = file.nativePath;
		});
		file.browseForOpen("Select game executable", [new FileFilter("Executable", "*.exe")]);
	}

	static public function selectWorkingFolder(project:LevelProject):void
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
