/**
 * Created by roman.gaikov on 9/19/2016.
 */
package com.grom.flashAtlasPacker.settings
{
import com.grom.flashAtlasPacker.AppModel;

import flash.events.Event;

import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.net.FileFilter;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SettingsPopupMediator extends Mediator
{
	public var model:AppModel;

	[Inject]
	public var view:SettingsPopup;

	public function SettingsPopupMediator()
	{
		model = AppModel.instance;
	}

	override public function initialize():void
	{
		super.initialize();

		view.buttonBrowseBMFont.addEventListener(MouseEvent.CLICK, onBrowseBMFont);
		updateView();
	}

	private function onBrowseBMFont(event:MouseEvent):void
	{
		var file:File = new File();
		file.addEventListener(Event.SELECT, function ():void
		{
			model.bmFontFile = file.nativePath;
			updateView();
		});
		file.browseForOpen("BMFont cli", [new FileFilter("application", "bmfont.exe")]);
	}

	private function updateView():void
	{
		view.inputBMFont.text = model.bmFontFile;
	}
}
}
