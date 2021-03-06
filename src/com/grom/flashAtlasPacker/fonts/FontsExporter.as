/**
 * Created by roman.gaikov on 7/1/2016.
 */
package com.grom.flashAtlasPacker.fonts
{

import air.update.utils.FileUtils;

import com.grom.flashAtlasPacker.display.filters.FiltersInfoManager;
import com.grom.flashAtlasPacker.display.filters.IFilterInfo;
import com.grom.flashAtlasPacker.utils.Utils;
import com.grom.lib.debug.Log;
import com.grom.lib.utils.UMath;
import com.grom.sys.ProcessRunner;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filters.BitmapFilter;

import spark.components.Alert;

public class FontsExporter extends EventDispatcher
{
	static public const FONTS_FOLDER:String = "fonts";
	static public const TEMPLATE_FILE:String = "bmfont_template.bmfc";

	private var _fonts:Object = {};
	private var _exportQueue:Vector.<FontDesc> = new <FontDesc>[];

	private var _template:String;
	private var _outPath:File;
	private var _bmFontExec:String;
	private var _scale:Number = 1;

	public function FontsExporter(outputPath:String, bmFontExec:String)
	{
		_bmFontExec = bmFontExec;

		var file:File = File.applicationDirectory.resolvePath(TEMPLATE_FILE);
		_template = FileUtils.readUTFBytesFromFile(file);

		_outPath = new File(outputPath);
		_outPath = _outPath.resolvePath(FONTS_FOLDER);

		if (_outPath.exists && _outPath.isDirectory)
		{
			_outPath.deleteDirectory(true);
		}
		_outPath.createDirectory();
	}

	public function get isAllowedTool():Boolean
	{
		return com.grom.sys.FileUtils.isExists(_bmFontExec);
	}

	public function set scale(value:Number):void
	{
		_scale = value;
	}

	public function registerFont(desc:FontDesc):void
	{
		var found:FontDesc = _fonts[desc.id];
		if (!found)
		{
			_fonts[desc.id] = desc;
			Log.info("font added for export: ", desc.id);
		}
	}

	public function export():Vector.<String>
	{
		var list:Vector.<String> = new <String>[];

		if (!isAllowedTool) {
			Alert.show("BM font tools does not specified.\n" +
					"Bitmap fonts will not be exported!", "Warning");
		}

		Log.info("...exporting fonts to: ", _outPath.nativePath);
		for each (var font:FontDesc in _fonts)
		{
			_exportQueue.push(font);
			list.push(FONTS_FOLDER + "/" + font.fileName + ".fnt");
		}

		exportNextFont();
		return list;
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

		Log.info("exporting: ", font.fileName);

		var templateFile:File = prepareFontTemplate(font);

		var bmfont:ProcessRunner = new ProcessRunner(new File(_bmFontExec), _outPath);
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
		args.push(font.fileName + ".fnt");

		bmfont.run(args);
	}

	private function prepareFontTemplate(font:FontDesc):File
	{
		var templateFile:File = File.createTempFile();
		Log.info("prepare template: ", templateFile.nativePath);

		var fontSize:int = Math.round(font.size * _scale);

		var template:String = _template.concat();
		template = template.replace("${font_family}", font.family);
		template = template.replace("${font_size}", fontSize);

		var paddingLeft:int = 0;
		var paddingRight:int = 0;
		var paddingTop:int = 0;
		var paddingBottom:int = 0;

		for each (var filter:BitmapFilter in font.filters)
		{
			var info:IFilterInfo = FiltersInfoManager.instance.getFilterInfo(filter);

			paddingLeft += info.paddingLeft;
			paddingRight += info.paddingRight;
			paddingTop += info.paddingTop;
			paddingBottom += info.paddingBottom;
		}

		template = template.replace("${paddingLeft}", paddingLeft);
		template = template.replace("${paddingRight}", paddingRight);
		template = template.replace("${paddingUp}", paddingTop);
		template = template.replace("${paddingDown}", paddingBottom);

		var aproxCharWidth:int = fontSize + paddingLeft + paddingRight;
		var aproxCharHeight:int = fontSize + paddingTop + paddingBottom;
		Log.info("approximate character size: ", aproxCharWidth, "x", aproxCharHeight);

		var numPixels:int = aproxCharHeight * aproxCharWidth * 128; //128 chars, TODO: make font configurable
		var textureSize:uint = UMath.closestPOT(Math.sqrt(numPixels));
		Log.info("font texture size: ", textureSize);

		template = template.replace("${width}", textureSize);
		template = template.replace("${height}", textureSize);

		Utils.writeFileText(templateFile, template);
		return templateFile;
	}


}
}

