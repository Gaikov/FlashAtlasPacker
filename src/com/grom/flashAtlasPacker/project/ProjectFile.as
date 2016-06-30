/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 03.06.13
 */
package com.grom.flashAtlasPacker.project
{
import com.grom.flashAtlasPacker.AppModel;

import flash.events.Event;
import flash.filesystem.File;

public class ProjectFile
{
	public static function saveProject(project:AtlasProject):void
	{
		if (AppModel.instance.projectFile)
		{
			saveToFile(new File(AppModel.instance.projectFile), project);
		}
		else
		{
			var file:File = new File();
			file.addEventListener(Event.SELECT, function ():void
			{
				saveToFile(file, project);
			});
			file.browseForSave("Save Project");
		}
	}

	static private function saveToFile(file:File, project:AtlasProject):void
	{
		project.write(file);
		AppModel.instance.projectFile = file.nativePath;
	}

	public static function openDefaultProject():AtlasProject
	{
		if (AppModel.instance.projectFile)
		{
			var p:AtlasProject = new AtlasProject();
			p.read(new File(AppModel.instance.projectFile));
			return p;
		}
		return null;
	}

	public static function openProject():void
	{
		var file:File = new File();
		file.addEventListener(Event.SELECT, function ():void
		{
			var p:AtlasProject = new AtlasProject();
			p.read(file);
			AppModel.instance.project = p;
			AppModel.instance.projectFile = file.nativePath;
		});
		file.browseForOpen("Open Project");
	}
}
}
