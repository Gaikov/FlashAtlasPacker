/**
 * Created by roman.gaikov on 9/23/2016.
 */
package com.grom.flashAtlasPacker.fonts
{
import com.grom.flashAtlasPacker.display.filters.FiltersInfoManager;
import com.grom.flashAtlasPacker.display.filters.IFilterInfo;

import flash.filters.BitmapFilter;

public class FontDesc
{
	private var _id:String;
	private var _fileName:String;
	private var _family:String;
	private var _size:int;
	private var _color:uint;
	private var _filters:Array;

	static private var _filterInfos:FiltersInfoManager = new FiltersInfoManager();

	public function FontDesc(family:String, size:int, color:uint, filters:Array)
	{
		_fileName = _id = getFontName(family, size, color, filters);
		_family = family;
		_size = size;
		_color = color;
		_filters = filters;
	}

	private function getFontName(font:String, size:int, color:uint, filters:Array):String
	{
		var name:String = font + "_" + size + "_" + color.toString(16);
		name = name.replace(/\s/g, "_");

		for each (var f:BitmapFilter in filters)
		{
			var info:IFilterInfo = _filterInfos.getFilterInfo(f);
			if (info)
			{
				name += "_" + info.name;
			}
		}

		return name;
	}

	public function get fileName():String
	{
		return _fileName;
	}

	public function set fileName(value:String):void
	{
		_fileName = value;
	}

	public function get id():String
	{
		return _id;
	}

	public function get family():String
	{
		return _family;
	}

	public function get size():int
	{
		return _size;
	}

	public function get color():uint
	{
		return _color;
	}

	public function get filters():Array
	{
		return _filters.concat();
	}
}
}
