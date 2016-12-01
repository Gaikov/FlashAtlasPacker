/**
 * Created by roman.gaikov on 11/18/2016.
 */
package com.grom.FlashFontsExporter
{
import com.grom.FlashFontsExporter.mapping.SelectedFont;
import com.grom.ToolsCommon.swf.SWFUtils;
import com.grom.flashAtlasPacker.fonts.FontDesc;
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

import mx.collections.ArrayList;

import robotlegs.bender.bundles.mvcs.Mediator;

import spark.components.Alert;

import spark.events.IndexChangeEvent;

public class BitmapFontsMediator extends Mediator
{
	[Inject]
	public var view:BitmapFontsExporter;

	[Inject]
	public var model:FontsExporterModel;

	private var _loadedFontsMap:Object = {};

	public function BitmapFontsMediator()
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

		view.buttonNew.addEventListener(MouseEvent.CLICK, onClickNew);
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

		view.fontsList.dataProvider = model.selectedFontsList.value;
		view.fontsList.addEventListener(IndexChangeEvent.CHANGE, onChangeSelectedFont);

		loadFontsList();
	}

	private function onClickNew(event:MouseEvent):void
	{
		Log.info("create new project");
		view._model = null;
		model.NewProject();
		view._model = model;
	}

	private function onChangeSelectedFont(event:IndexChangeEvent):void
	{
		var selFont:SelectedFont = view.fontsList.selectedItem;
		view.fontPreview.fontDesc = _loadedFontsMap[selFont.id];
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
			loadFontsList();
		});

		browseProject.browseForOpen("Open SWF", [new FileFilter("Project files", "*.xml")]);
	}

	private function onClickGenerate(event:MouseEvent):void
	{
		Log.info("generation started...");

		var exporter:FontsExporter = new FontsExporter(model.outputPath, model.bmFontExec);
		var selectedFonts:ArrayList = model.selectedFontsList.value;

		var count:int = 0;
		for each (var selFont:SelectedFont in selectedFonts.source)
		{
			var desc:FontDesc = _loadedFontsMap[selFont.id] as FontDesc;
			if (selFont.selected && desc)
			{
				desc.fileName = selFont.exportFileName;
				exporter.registerFont(desc);
				count++;
			}
		}

		if (count > 0)
		{
			exporter.addEventListener(Event.COMPLETE, function ():void
			{
				view.buttonGenerate.enabled = true;
			});
			exporter.export();
			view.buttonGenerate.enabled = false;
		}
		else
		{
			Alert.show("Please select fonts for export", "Warning", Alert.OK);
		}
	}

	private function loadFontsList():void
	{
		if (!model.swfPath)
		{
			return;
		}

		var swfFile:File = new File(model.swfPath);
		if (!swfFile.exists)
		{
			return;
		}

		Log.info("loading fonts list...");
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
							var desc:FontDesc = new FontDesc(format.font, Math.round(int(format.size) * model.fontScale), uint(format.color), field.filters);
							_loadedFontsMap[desc.id] = desc;
							if (!model.selectedFontsList.findItem(function (font:SelectedFont):Boolean
									{
										return font.id == desc.id;
									}))
							{
								model.selectedFontsList.addItem(new SelectedFont(desc.id, desc.id));
							}
						}
						return true;
					});
				}
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
			loadFontsList();
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
