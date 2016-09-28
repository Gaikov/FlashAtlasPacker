/**
 * Created by roman.gaikov on 7/1/2016.
 */
package com.grom.flashAtlasPacker.fonts
{
import air.update.utils.FileUtils;

import com.grom.flashAtlasPacker.AppModel;
import com.grom.flashAtlasPacker.display.filters.FiltersInfoManager;
import com.grom.flashAtlasPacker.display.filters.IFilterInfo;
import com.grom.flashAtlasPacker.utils.Utils;
import com.grom.lib.debug.Log;
import com.grom.sys.ProcessRunner;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filters.BitmapFilter;

public class FontsExporter extends EventDispatcher
{
	static public const FONTS_FOLDER:String = "fonts";
	static public const TEMPLATE_FILE:String = "bmfont_template.bmfc";

	private var _fonts:Object = {};
	private var _exportQueue:Vector.<FontDesc> = new <FontDesc>[];

	private var _template:String;
	private var _outPath:File;
	private var _model:AppModel;
	private var _filterInfos:FiltersInfoManager = new FiltersInfoManager();

	public function FontsExporter(model:AppModel)
	{
		_model = model;
		var file:File = File.applicationDirectory.resolvePath(TEMPLATE_FILE);
		_template = FileUtils.readUTFBytesFromFile(file);

		_outPath = new File(_model.project.outputPath);
		_outPath = _outPath.resolvePath(FONTS_FOLDER);

		if (_outPath.exists && _outPath.isDirectory)
		{
			_outPath.deleteDirectory(true);
		}
		_outPath.createDirectory();
	}

	public function registerFont(font:String, size:int, color:uint, filters:Array):String
	{
		var name:String = getFontName(font, size, color, filters);
		var desc:FontDesc = _fonts[name];
		if (!desc)
		{
			_fonts[name] = new FontDesc(name, font, size, color, filters);
		}
		return name;
	}
	
	public function export():void
	{
		Log.info("...exporting fonts to: ", _outPath.nativePath);
		for each (var font:FontDesc in _fonts)
		{
			_exportQueue.push(font);
		}

		exportNextFont();
	}

	private function exportNextFont():void
	{
		var font:FontDesc = _exportQueue.shift();
		if (!font)
		{
			Log.info("export fonts completed!");
			dispatchEvent(new Event(Event.COMPLETE));
			return;
		}

		Log.info("exporting: ", font.name);

		var templateFile:File = prepareFontTemplate(font);

		var bmfont:ProcessRunner = new ProcessRunner(new File(_model.bmFontFile), _outPath);
		bmfont.addEventListener(Event.COMPLETE, function ():void
		{
			var filtersRenderer:FontFiltersRenderer = new FontFiltersRenderer(font, _outPath);
			filtersRenderer.addEventListener(Event.COMPLETE, function ():void
			{
				exportNextFont();
			});
			filtersRenderer.applyFilters();
		});

		var args:Vector.<String> = new <String>[];
		args.push("-c");
		args.push(templateFile.nativePath);
		args.push("-o");
		args.push(font.name + ".fnt");

		bmfont.run(args);
	}

	private function prepareFontTemplate(font:FontDesc):File
	{
		var templateFile:File = File.createTempFile();
		Log.info("prepare template: ", templateFile.nativePath);

		var template:String = _template.concat();
		template = template.replace("${font_family}", font.family);
		template = template.replace("${font_size}", font.size);

		var paddingLeft:int = 0;
		var paddingRight:int = 0;
		var paddingTop:int = 0;
		var paddingBottom:int = 0;

		for each (var filter:BitmapFilter in font.filters)
		{
			var info:IFilterInfo = _filterInfos.getFilterInfo(filter);

			paddingLeft += info.paddingLeft;
			paddingRight += info.paddingRight;
			paddingTop += info.paddingTop;
			paddingBottom += info.paddingBottom;
		}

		template = template.replace("${paddingLeft}", paddingLeft);
		template = template.replace("${paddingRight}", paddingRight);
		template = template.replace("${paddingUp}", paddingTop);
		template = template.replace("${paddingDown}", paddingBottom);

		Utils.writeFileText(templateFile, template);
		return templateFile;
	}


	private function getFontName(font:String, size:int, color:uint, filters:Array):String
	{
		var name:String = font + "_" + size + "_" + color.toString(16);
		name = name.replace(" ", "_");
		return name;
	}
}
}

