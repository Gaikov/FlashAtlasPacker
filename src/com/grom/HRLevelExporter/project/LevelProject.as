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
	private var _classesList:ArrayList = new ArrayList();
	private var _swfClassesMap:Object = {};

	public function LevelProject()
	{
		registerProjectVariable(_swfFileName);
		registerProjectVariable(_exportPath);
		registerProjectVariable(_gamePath);
		registerProjectVariable(_workFolder);
		registerProjectVariable(_levelStartNum);
		registerProjectVariable(_levelsList);


		tryLoad();
	}

	[Bindable]
	public function get levelStartNum():int
	{
		return _levelStartNum.value;
	}

	public function set levelStartNum(value:int):void
	{
		_levelStartNum.value = value;
	}

	[Bindable]
	public function get gamePath():String
	{
		return _gamePath.value;
	}

	public function set gamePath(value:String):void
	{
		_gamePath.value = value;
	}

	[Bindable]
	public function get workFolder():String
	{
		return _workFolder.value;
	}

	public function set workFolder(value:String):void
	{
		_workFolder.value = value;
	}

	[Bindable]
	public function get exportPath():String
	{
		return _exportPath.value;
	}

	public function set exportPath(value:String):void
	{
		_exportPath.value = value;
	}

	public function get levelsList():LevelsListProjectVariable
	{
		return _levelsList;
	}

	[Bindable]
	public function get swfFileName():String
	{
		return _swfFileName.value;
	}

	public function set swfFileName(value:String):void
	{
		if (_swfFileName.value != value)
		{
			_swfFileName.value = value;
			updateSWFClasses();
		}
	}

	[Bindable (event="ClassesListChanged")]
	public function get classesList():ArrayList
	{
		return _classesList;
	}

	private function updateSWFClasses():void
	{
		var bytes:ByteArray = Utils.readFile(new File(swfFileName));
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
			Log.error("Can't load swf: " + swfFileName);
		}
	}

	public function getLevelMovie(className:String):MovieClip
	{
		var cls:Class = _swfClassesMap[className];
		return new cls();
	}

	override protected function onLoaded():void
	{
		if (swfFileName)
		{
			updateSWFClasses();
		}
	}
}
}
