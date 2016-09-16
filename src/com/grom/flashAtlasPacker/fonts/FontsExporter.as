/**
 * Created by roman.gaikov on 7/1/2016.
 */
package com.grom.flashAtlasPacker.fonts
{
import com.grom.flashAtlasPacker.AppModel;
import com.grom.lib.debug.Log;

import flash.filesystem.File;

import flash.filesystem.File;

public class FontsExporter
{
	static public const FONTS_FOLDER:String = "fonts";

	private var _model:AppModel;

	private var _fonts:Object = {};

	public function FontsExporter(model:AppModel)
	{
		_model = model;
	}

	public function registerFont(font:String, size:int, color:uint, filters:Array):void
	{
		var name:String = getFontName(font, size, color, filters);
		var desc:FontDesc = _fonts[name];
		if (!desc)
		{
			_fonts[name] = new FontDesc(font, size, color, filters);
		}
	}
	
	public function export(folder:File):void
	{
		var fontsFolder:File = folder.resolvePath(FONTS_FOLDER + "/");
		fontsFolder.createDirectory();

		Log.info("...exporting fonts to: ", fontsFolder.nativePath);
		
		for (var name:String in _fonts)
		{
			Log.info("exporting font: ", name);
		}
	}

	private function getFontName(font:String, size:int, color:uint, filters:Array):String
	{
		return font + size + color;
	}
}
}

class FontDesc
{
	public var family:String;
	public var size:int;
	public var color:uint;
	public var filters:Array;

	public function FontDesc(family:String, size:int, color:uint, filters:Array)
	{
		this.family = family;
		this.size = size;
		this.color = color;
		this.filters = filters;
	}
}
