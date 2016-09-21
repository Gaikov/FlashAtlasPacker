/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 03.06.13
 */
package com.grom.flashAtlasPacker
{
import com.grom.flashAtlasPacker.project.AtlasProject;

import com.grom.lib.settings.UserVar;

import flash.filesystem.File;

public class AppModel
{
	private var _projectFile:UserVar = new UserVar("project_file", null);
	private var _bmFontFile:UserVar = new UserVar("bmfont_file", "");
	private var _project:AtlasProject;

	private static var _instance:AppModel;

	public function AppModel()
	{
	}

	public static function get instance():AppModel
	{
		if (!_instance)
		{
			_instance = new AppModel();
		}
		return _instance;
	}

	public function get bmFontFile():String
	{
		return _bmFontFile.value;
	}

	public function set bmFontFile(value:String):void
	{
		_bmFontFile.value = value;
	}

	[Bindable]
	public function get projectFile():String
	{
		return _projectFile.value;
	}

	public function set projectFile(value:String):void
	{
		_projectFile.value = value;
	}

	[Bindable]
	public function get project():AtlasProject
	{
		return _project;
	}

	public function set project(value:AtlasProject):void
	{
		_project = value;
	}

	public function get outPath():File
	{
		return new File(projectFile).parent;
	}
}
}
