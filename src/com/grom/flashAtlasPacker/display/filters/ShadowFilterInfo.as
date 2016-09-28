/**
 * Created by roman.gaikov on 9/27/2016.
 */
package com.grom.flashAtlasPacker.display.filters
{
import com.grom.lib.utils.UMath;

import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;

public class ShadowFilterInfo implements IFilterInfo
{
	private var _filter:DropShadowFilter;
	private var _dirX:Number;
	private var _dirY:Number;

	public function init(filter:BitmapFilter):void
	{
		_filter = DropShadowFilter(filter);
		var angle:Number = UMath.deg2rad(_filter.angle);
		_dirX = _filter.distance * Math.cos(angle);
		_dirY = _filter.distance * Math.sin(angle);
	}

	public function get name():String
	{
		var res:String = "";
		res += 
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

		var p:Number = -_filter.blurX / 2 + _dirX;
		if (p > 0)
		{
			p = 0;
		}
		return -p;
	}

	public function get paddingRight():int
	{
		if (_filter.inner)
		{
			return 0;
		}

		var p:Number = _filter.blurX / 2 + _dirX;
		if (p < 0)
		{
			p = 0;
		}
		return p;
	}

	public function get paddingTop():int
	{
		if (_filter.inner)
		{
			return 0;
		}

		var p:Number = -_filter.blurY / 2 + _dirY;
		if (p > 0)
		{
			p = 0;
		}
		return -p;
	}

	public function get paddingBottom():int
	{
		if (_filter.inner)
		{
			return 0;
		}

		var p:Number = _filter.blurY / 2 + _dirY;
		if (p < 0)
		{
			p = 0;
		}
		return p;
	}
}
}
