/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.02.13
 */
package com.grom.flashAtlasPacker.cache
{
import com.grom.flashAtlasPacker.generator.atlasSource.IAtlasSource;

import flash.utils.Dictionary;

import net.maygem.lib.debug.Log;
import net.maygem.lib.utils.UMap;

public class DisplayObjectsCache
{
	private var _cache:Dictionary = new Dictionary();

	public function DisplayObjectsCache()
	{
	}

	public function getNames():Array
	{
		return UMap.collectNames(_cache);
	}

	public function getObject(resourceName:String):IRenderedObject
	{
		return _cache[resourceName];
	}

	public function renderObject(source:IAtlasSource):void
	{
		if (_cache[source.resourceName] == undefined)
		{
			trace("rendering: ", source.resourceName);

			source.prepareChildren();
			_cache[source.resourceName] = source.rendered;

			for (var i:int = 0; i < source.numChildren; i++)
			{
				renderObject(source.getChildAt(i));
			}
		}
	}
}
}








