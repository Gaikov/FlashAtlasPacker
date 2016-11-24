/**
 * Created by roman.gaikov on 11/18/2016.
 */
package com.grom.FlashFontsExporter
{
import com.grom.ToolsCommon.swf.SWFUtils;
import com.grom.flashAtlasPacker.fonts.FontsExporter;
import com.grom.lib.debug.Log;
import com.grom.lib.utils.UDisplay;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.net.FileFilter;
import flash.text.TextField;
import flash.text.TextFormat;

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
		view.buttonOpen.addEventListener(MouseEvent.CLICK, onClickOpen);
		view.buttonBrowseSwf.addEventListener(MouseEvent.CLICK, onClickBrowseSwf);
		view.buttonBmFont.addEventListener(MouseEvent.CLICK, onClickBrowseBMFont);
		view.fontScale.addEventListener(Event.CHANGE, function ():void
		{
			model.fontScale = view.fontScale.value;
		});
		view.buttonBrowseOutput.addEventListener(MouseEvent.CLICK, onClickBrowseOutput);
		view.buttonGenerate.addEventListener(MouseEvent.CLICK, onClickGenerate);
	}

	private function onClickBrowseBMFont(event:MouseEvent):void
	{
		var bmFont:File = new File();
		bmFont.addEventListener(Event.SELECT, function ():void
		{
			model.bmFontExec = bmFont.nativePath;
		});

		bmFont.browseForOpen("Select BMFont executable", [new FileFilter("Executable", "*.exe")]);		
	}

	private function onClickOpen(event:MouseEvent):void
	{
		var browseProject:File = new File();
		browseProject.addEventListener(Event.SELECT, function ():void
		{
			model.fileName = browseProject.nativePath;
			model.load();
			view._model = null;
			view._model = model;
		});

		browseProject.browseForOpen("Open SWF", [new FileFilter("Project files", "*.xml")]);
	}

	private function onClickGenerate(event:MouseEvent):void
	{
		Log.info("generation started...");
		
		var exporter:FontsExporter = new FontsExporter(model.outputPath, model.bmFontExec);

		var swfFile:File = new File(model.swfPath);
		SWFUtils.loadClassesFromFile(swfFile, function (map:Object):void
		{
			if (map)
			{
				for each (var cls:Class in map)
				{
					UDisplay.traceChildren(new cls(), function (child:DisplayObject):Boolean
					{
						var field:TextField = child as TextField;
						if (field)
						{
							Log.info("process textfield: ", child.name);


							var format:TextFormat = field.getTextFormat();
							exporter.registerFont(format.font, Math.round(int(format.size) * model.fontScale), uint(format.color), field.filters);
						}
						return true;
					});
				}
				exporter.export();
			}
		});
	}

	private function onClickBrowseOutput(event:MouseEvent):void
	{
		var browseOut:File = new File();
		browseOut.addEventListener(Event.SELECT, function ():void
		{
			model.outputPath = browseOut.nativePath;
		});
		browseOut.browseForDirectory("Select output folder");
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
