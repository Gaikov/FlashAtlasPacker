/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 11.12.13
 * Time: 18:40
 * To change this template use File | Settings | File Templates.
 */
package com.grom.HRLevelExporter.project
{
import com.grom.HRLevelExporter.model.LevelsListProjectVariable;
import com.grom.ToolsCommon.project.BaseProject;
import com.grom.ToolsCommon.project.BaseProjectVariable;
import com.grom.ToolsCommon.project.BoolProjectVar;
import com.grom.ToolsCommon.project.FileNameProjectVariable;
import com.grom.ToolsCommon.project.StringProjectVariable;
import com.grom.ToolsCommon.swf.SWFUtils;
import com.grom.flashAtlasPacker.Utils;

import flash.display.MovieClip;

import flash.events.Event;
import flash.filesystem.File;
import flash.utils.ByteArray;

import mx.collections.ArrayList;

import com.grom.lib.debug.Log;

public class LevelProject extends BaseProject
{
	private var _swfFileName:FileNameProjectVariable = new FileNameProjectVariable("swf_file_name");
	private var _exportPath:FileNameProjectVariable = new FileNameProjectVariable("export_path");
	private var _levelsList:LevelsListProjectVariable = new LevelsListProjectVariable("levels_list");
	private var _gamePath:FileNameProjectVariable = new FileNameProjectVariable("game_path");
	private var _workFolder:FileNameProjectVariable = new FileNameProjectVariable("working_folder");
	private var _levelStartNum:StringProjectVariable = new StringProjectVariable("level_start_num", "0");
	private var _previewBackground:StringProjectVariable = new StringProjectVariable("preview_background", "");
	private var _sortLevelsByPriority:BoolProjectVar = new BoolProjectVar("sort_levels_by_priority", true);
	private var _classesList:ArrayList = new ArrayList();
	private var _swfClassesMap:Object = {};

	public function LevelProject()
	{
		registerProjectVariable(_sortLevelsByPriority);
		registerProjectVariable(_swfFileName);
		registerProjectVariable(_previewBackground);
		registerProjectVariable(_exportPath);
		registerProjectVariable(_gamePath);
		registerProjectVariable(_workFolder);
		registerProjectVariable(_levelStartNum);
		registerProjectVariable(_levelsList);

		_swfFileName.addEventListener(BaseProjectVariable.CHANGED, function ():void
		{
			updateSWFClasses();
		})
	}

	override public function newProject():void
	{
		super.newProject();
		_classesList.removeAll();
		_swfClassesMap = {};
	}

	public function get previewBackground():StringProjectVariable
	{
		return _previewBackground;
	}

	public function get levelStartNum():StringProjectVariable
	{
		return _levelStartNum;
	}

	public function get gamePath():FileNameProjectVariable
	{
		return _gamePath;
	}

	public function get workFolder():FileNameProjectVariable
	{
		return _workFolder;
	}

	public function get exportPath():FileNameProjectVariable
	{
		return _exportPath;
	}

	public function get levelsList():LevelsListProjectVariable
	{
		return _levelsList;
	}

	public function get sortLevelsByPriority():BoolProjectVar
	{
		return _sortLevelsByPriority;
	}

	public function get swfFileName():FileNameProjectVariable
	{
		return _swfFileName;
	}

	[Bindable (event="ClassesListChanged")]
	public function get classesList():ArrayList
	{
		return _classesList;
	}

	private function updateSWFClasses():void
	{
		if (!swfFileName.value)
		{
			return;
		}

		var bytes:ByteArray = Utils.readFile(new File(swfFileName.value));
		if (bytes)
		{
			_classesList = new ArrayList(SWFUtils.getClassNames(bytes));

			SWFUtils.loadClasses(bytes, function(map:Object):void
			{
				_swfClassesMap = map;
				dispatchEvent(new Event("ClassesListChanged"));
			});
		}
		else
		{
			Log.error("Can't load swf: " + swfFileName.value);
		}
	}

	public function getLevelMovie(className:String):MovieClip
	{
		var cls:Class = _swfClassesMap[className];
		if (!cls)
		{
			return null;
		}
		return new cls();
	}
}
}
