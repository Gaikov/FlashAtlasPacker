/**
 * Created by Roman.Gaikov on 1/10/2019
 */

package com.grom.HRLevelExporter.views.settings
{
import com.grom.HRLevelExporter.project.LevelProject;

import flash.events.Event;

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
		initListeners();
		updateView();
	}

	private function initListeners():void
	{
		view.sortLevelsCheck.addEventListener(Event.CHANGE, function ():void
		{
			project.sortLevelsByPriority.value = view.sortLevelsCheck.selected;
		});
	}

	private function updateView():void
	{
		view.sortLevelsCheck.selected = project.sortLevelsByPriority.value;
	}
}
}
