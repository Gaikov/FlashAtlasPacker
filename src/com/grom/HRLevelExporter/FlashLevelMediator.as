/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 03.01.14
 * Time: 21:46
 * To change this template use File | Settings | File Templates.
 */
package com.grom.HRLevelExporter
{
import com.grom.HRLevelExporter.model.LevelModel;
import com.grom.HRLevelExporter.project.LevelProject;
import com.grom.common.BaseMediator;
import com.grom.lib.debug.Log;
import com.grom.lib.debug.LogTracePolicy;

import flash.display.MovieClip;

import spark.components.Alert;
import spark.events.IndexChangeEvent;

public class FlashLevelMediator extends BaseMediator
{
	[Inject]
	public var view:FlashLevelExporter;

	[Inject]
	public var project:LevelProject;

	override public function initialize():void
	{
		super.initialize();

		view.project = project;

		Log.addAdapter(new LogTracePolicy());
		Log.info("...init app");

		view.listSelectedLevels.addEventListener(IndexChangeEvent.CHANGE, onSelectedLevelChanged);

		project.tryLoad();
	}

	private function onSelectedLevelChanged(event:IndexChangeEvent):void
	{
		var movie:MovieClip;
		var desc:LevelModel = view.listSelectedLevels.selectedItem;
		if (desc)
		{
			movie = project.getLevelMovie(desc._levelClass);
			if (!movie)
			{
				Alert.show("Level movie not found: " + desc._levelClass, "Error");
			}
		}

		view.levelPreview.level = movie;
	}
}
}
