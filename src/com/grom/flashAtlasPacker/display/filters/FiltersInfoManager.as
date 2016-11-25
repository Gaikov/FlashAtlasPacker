/**
 * Created by roman.gaikov on 9/27/2016.
 */
package com.grom.flashAtlasPacker.display.filters
{
import com.grom.lib.debug.Log;

import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.utils.Dictionary;

public class FiltersInfoManager
{
	private var _infosMap:Dictionary = new Dictionary();

	private static var _instance:FiltersInfoManager;

	public static function get instance():FiltersInfoManager
	{
		if (!_instance)
		{
			_instance = new FiltersInfoManager();
		}
		return _instance;
	}

	public function FiltersInfoManager()
	{
		_infosMap[GlowFilter] = GlowFilterInfo;
		_infosMap[DropShadowFilter] = ShadowFilterInfo;
	}

	public function getFilterInfo(filter:BitmapFilter):IFilterInfo
	{
		var cls:Class = Object(filter).constructor;
		cls = _infosMap[cls] as Class;
		if (!cls)
		{
			Log.error("filter info is not registered for: ", filter);
		}

		var info:IFilterInfo = new cls();
		info.init(filter);
		return info;
	}
}
}
