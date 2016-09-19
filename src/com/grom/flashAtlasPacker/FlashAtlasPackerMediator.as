/**
 * Created by roman.gaikov on 9/19/2016.
 */
package com.grom.flashAtlasPacker
{
import com.grom.flashAtlasPacker.project.AtlasProject;
import com.grom.flashAtlasPacker.project.ProjectFile;
import com.grom.flashAtlasPacker.settings.SettingsPopup;

import flash.events.MouseEvent;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FlashAtlasPackerMediator extends Mediator
{
	private var _model:AppModel;

	[Inject]
	public var view:FlashAtlasPacker;

	public function FlashAtlasPackerMediator()
	{
		_model = AppModel.instance;
	}

	override public function initialize():void
	{
		super.initialize();

		_model.project = ProjectFile.openDefaultProject();
		if (!_model.project)
		{
			_model.project = new AtlasProject();
		}

		view.buttonSettings.addEventListener(MouseEvent.CLICK, onClickSettings);
	}

	private function onClickSettings(event:MouseEvent):void
	{
		SettingsPopup.show();
	}
}
}
