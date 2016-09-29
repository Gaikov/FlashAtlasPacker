/**
 * Created by roman.gaikov on 9/27/2016.
 */
package com.grom.flashAtlasPacker.display.filters
{
import flash.filters.BitmapFilter;
import flash.filters.GlowFilter;

public class GlowFilterInfo implements IFilterInfo
{
	private var _filter:GlowFilter;

	public function init(filter:BitmapFilter):void
	{
		_filter = GlowFilter(filter);
	}

	public function get name():String
	{
		var res:String = "glow";
		res += "_bx" + _filter.blurX;
		res += "_by" + _filter.blurY;
		res += "_a" + _filter.alpha;
		res += "_c" + _filter.color.toString(16);
		if (_filter.inner)
		{
			res += "_i";
		}
		if (_filter.knockout)
		{
			res += "_k";
		}
		res += "_q" + _filter.quality;
		res += "_s" + _filter.strength;

		return res;
	}

	public function get paddingLeft():int
	{
		if (_filter.inner)
		{
			return 0;
		}

		return _filter.blurX;
	}

	public function get paddingRight():int
	{
		if (_filter.inner)
		{
			return 0;
		}

		return _filter.blurX;
	}

	public function get paddingTop():int
	{
		if (_filter.inner)
		{
			return 0;
		}

		return _filter.blurY;
	}

	public function get paddingBottom():int
	{
		if (_filter.inner)
		{
			return 0;
		}

		return _filter.blurY;
	}
}
}
