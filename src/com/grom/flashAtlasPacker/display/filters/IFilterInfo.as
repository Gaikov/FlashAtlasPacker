/**
 * Created by roman.gaikov on 9/27/2016.
 */
package com.grom.flashAtlasPacker.display.filters
{
import flash.filters.BitmapFilter;

public interface IFilterInfo
{
	function init(filter:BitmapFilter):void
	
	function get name():String;
	function get paddingLeft():int;
	function get paddingRight():int;
	function get paddingTop():int;
	function get paddingBottom():int;
}
}
