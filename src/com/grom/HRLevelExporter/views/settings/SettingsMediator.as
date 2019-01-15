/**
 * Created by Roman.Gaikov on 1/10/2019
 */

package com.grom.HRLevelExporter.views.settings
{
import com.grom.HRLevelExporter.project.LevelProject;
import com.grom.HRLevelExporter.project.LevelProjectUtils;
import com.grom.HRLevelExporter.views.ItemsSelectionPopup;

import flash.events.Event;
import flash.events.MouseEvent;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SettingsMediator extends Mediator
{
	[Inject]
	public var view:SettingsPopup;

	[Inject]
	public var project:LevelProject;

	public function SettingsMediator()
	{
	}

	override public function initialize():void
	{
		super.initialize();
		view.project = project;
		initListeners();
	}

	private function initListeners():void
	{
		view.sortLevelsCheck.addEventListener(Event.CHANGE, function ():void
		{
			project.sortLevelsByPriority.value = view.sortLevelsCheck.selected;
		});

		view.buttonBackground.addEventListener(MouseEvent.CLICK, function ():void
		{
			ItemsSelectionPopup.show(project.classesList, false, function (selected:Vector.<String>):void
			{
				project.previewBackground.value = selected;
			});
		});

		view.buttonGameExec.addEventListener(MouseEvent.CLICK, onClickGameExec);
		view.buttonWorkingFolder.addEventListener(MouseEvent.CLICK, onClickWorkingFolder);
	}

	private function onClickGameExec(event:MouseEvent):void
	{
		LevelProjectUtils.selectGameFile(project);
	}

	private function onClickWorkingFolder(event:MouseEvent):void
	{
		LevelProjectUtils.selectWorkingFolder(project);
	}
}
}
