/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 03.06.13
 */
package com.grom.flashAtlasPacker
{
import com.grom.flashAtlasPacker.project.AtlasProject;

import com.grom.lib.settings.UserVar;

public class AppModel
{
	private var _projectFile:UserVar = new UserVar("project_file", null);
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
}
}
