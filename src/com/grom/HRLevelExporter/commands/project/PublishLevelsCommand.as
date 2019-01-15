/**
 * Created by Roman.Gaikov on 1/11/2019
 */

package com.grom.HRLevelExporter.commands.project
{
import com.grom.HRLevelExporter.LevelExport;
import com.grom.HRLevelExporter.model.LevelModel;
import com.grom.HRLevelExporter.project.LevelProject;
import com.grom.lib.debug.Log;
import com.grom.lib.utils.UString;

import flash.events.Event;

import flash.filesystem.File;

import mx.collections.ArrayList;

import robotlegs.bender.bundles.mvcs.Command;

import spark.components.Alert;

public class PublishLevelsCommand extends Command
{
	[Inject]
	public var project:LevelProject;

	public function PublishLevelsCommand()
	{
	}

	override public function execute():void
	{
		if (!project.exportPath.value)
		{
			var file:File = new File();
			file.addEventListener(Event.SELECT, function ():void
			{
				project.exportPath.value = file.nativePath;
				exportLevels();
			});
			file.browseForDirectory("Export To...");
		}
		else
		{
			exportLevels();
		}
	}

	private function prepareList():Array
	{
		var list:ArrayList = project.levelsList.value;
		if (!project.sortLevelsByPriority.value)
		{
			return list.toArray();
		}

		return list.toArray().sort(function (i1:LevelModel, i2:LevelModel):int
		{
			var diff:int = i1._levelDifficult - i2._levelDifficult;
			if (diff != 0)
			{
				return diff;
			}

			var c1:String = i1._levelClass;
			var c2:String = i2._levelClass;

			if (c1 > c2)
			{
				return 1;
			}
			else if (c1 < c2)
			{
				return -1;
			}

			return 0;
		});
	}

	private function exportLevels():void
	{
		Log.info("exporting levels to: " + project.exportPath.value);

		var levels:Array = prepareList();
		var path:File = new File(project.exportPath.value);

		var levelNum:int = project.levelStartNum.value;
		for each (var lm:LevelModel in levels)
		{
			var levelName:String = "level" + UString.prefixZero(levelNum, 3) + ".xml";
			LevelExport.saveLevel(levelName, path, project.getLevelMovie(lm._levelClass));
			levelNum++;
		}

		Alert.show("Levels are published!");
	}
}
}
