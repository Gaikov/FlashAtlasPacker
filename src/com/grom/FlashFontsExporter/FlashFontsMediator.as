/**
 * Created by roman.gaikov on 11/18/2016.
 */
package com.grom.FlashFontsExporter
{
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.net.FileFilter;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FlashFontsMediator extends Mediator
{
	[Inject]
	public var view:FlashFontsExporter;

	[Inject]
	public var model:FlashFontsModel;

	public function FlashFontsMediator()
	{
	}

	override public function initialize():void
	{
		super.initialize();
		if (model.fileName)
		{
			model.load();
		}
		view._model = model;

		view.buttonSave.addEventListener(MouseEvent.CLICK, onClickSave);
		view.buttonBrowseSwf.addEventListener(MouseEvent.CLICK, onClickBrowseSwf);

	}

	private function onClickBrowseSwf(event:MouseEvent):void
	{
		var browseSwf:File = new File();
		browseSwf.addEventListener(Event.SELECT, function ():void
		{
			model.swfPath = browseSwf.nativePath;
		});

		browseSwf.browseForOpen("Open SWF", [new FileFilter("SWF file", "*.swf")]);
	}

	private function onClickSave(event:MouseEvent):void
	{
		if (!model.fileName)
		{
			var browseFile:File = new File();
			browseFile.addEventListener(Event.SELECT, function ():void
			{
				var fileName:String = browseFile.nativePath;
				if (!browseFile.extension)
				{
					fileName += ".xml";
				}

				model.fileName = fileName;
				model.save();
			});

			browseFile.browseForSave("Save Project");
		}
		else
		{
			model.save();
		}
	}
}
}
