/**
 * Created by roman.gaikov on 7/1/2016.
 */
package com.grom.flashAtlasPacker.fonts
{
import air.update.utils.FileUtils;

import com.grom.flashAtlasPacker.AppModel;
import com.grom.flashAtlasPacker.utils.ImageLoader;
import com.grom.flashAtlasPacker.utils.Utils;
import com.grom.lib.debug.Log;
import com.grom.sys.ProcessRunner;

import flash.display.BitmapData;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filters.BitmapFilter;
import flash.geom.Point;
import flash.geom.Rectangle;

public class FontsExporter extends EventDispatcher
{
	static public const FONTS_FOLDER:String = "fonts";
	static public const TEMPLATE_FILE:String = "bmfont_template.bmfc";

	private var _fonts:Object = {};
	private var _exportQueue:Vector.<FontDesc> = new <FontDesc>[];

	private var _template:String;
	private var _outPath:File;
	private var _model:AppModel;

	public function FontsExporter(model:AppModel)
	{
		_model = model;
		var file:File = File.applicationDirectory.resolvePath(TEMPLATE_FILE);
		_template = FileUtils.readUTFBytesFromFile(file);

		_outPath = new File(_model.project.outputPath);
		_outPath = _outPath.resolvePath(FONTS_FOLDER);
		if (!_outPath.exists)
		{
			_outPath.createDirectory();
		}
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

		var templateFile:File = File.createTempFile();
		Log.info("prepare template: ", templateFile.nativePath);

		var template:String = _template.concat();
		template = template.replace("${font_family}", font.family);
		template = template.replace("${font_size}", font.size);
		Utils.writeFileText(templateFile, template);

		var bmfont:ProcessRunner = new ProcessRunner(new File(_model.bmFontFile), _outPath);
		bmfont.addEventListener(Event.COMPLETE, function ():void
		{
			applyFilters(font, exportNextFont);
		});

		var args:Vector.<String> = new <String>[];
		args.push("-c");
		args.push(templateFile.nativePath);
		args.push("-o");
		args.push(font.name + ".fnt");

		bmfont.run(args);
	}

	private function getFontName(font:String, size:int, color:uint, filters:Array):String
	{
		var name:String = font + "_" + size + "_" + color.toString(16);
		name = name.replace(" ", "_");
		return name;
	}

	private function applyFilters(font:FontDesc, completed:Function):void
	{
		if (!font.filters || !font.filters.length)
		{
			completed();
			return;
		}

		var imageFile:File = _outPath.resolvePath(font.name + ".png");
		ImageLoader.load(imageFile, function (data:BitmapData):void
		{
			if (data)
			{
				for each (var f:BitmapFilter in font.filters)
				{
					data.applyFilter(data, new Rectangle(0, 0, data.width, data.height), new Point(0, 0), f);
				}
				Utils.savePng(imageFile, data);
			}
			completed();
		});
	}
}
}

