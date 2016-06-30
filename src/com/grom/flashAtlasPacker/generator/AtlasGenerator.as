/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.02.13
 */
package com.grom.flashAtlasPacker.generator
{
import com.grom.flashAtlasPacker.area.AreasAllocator;
import com.grom.flashAtlasPacker.cache.DisplayObjectsCache;
import com.grom.flashAtlasPacker.cache.IRenderedObject;
	import com.grom.flashAtlasPacker.generator.atlasMeta.AtlasJsonMeta;
	import com.grom.flashAtlasPacker.generator.atlasMeta.AtlasStarlingMeta;
	import com.grom.flashAtlasPacker.generator.atlasSource.IAtlasSource;

import flash.geom.Point;

import net.maygem.lib.debug.Log;

import net.maygem.lib.utils.UString;

public class AtlasGenerator
{
	private var _cache:DisplayObjectsCache = new DisplayObjectsCache();
	private var _textureWidth:int;
	private var _textureHeight:int;
	private var _sources:Vector.<IAtlasSource>;

	public function AtlasGenerator(sources:Vector.<IAtlasSource>, textureWidth:int, textureHeight:int)
	{
		_textureWidth = textureWidth;
		_textureHeight = textureHeight;
		_sources = sources;
		for each (var s:IAtlasSource in sources)
		{
			_cache.renderObject(s);
		}
	}

	public function get sources():Vector.<IAtlasSource>
	{
		return _sources;
	}

	public function generate():Vector.<AtlasData>
	{
		var names:Array = _cache.getNames();

		var sortList:Vector.<SortFrameEntry> = new Vector.<SortFrameEntry>();

		for each (var sourceName:String in names)
		{
			var rendered:IRenderedObject = _cache.getObject(sourceName);

			if (rendered.numFrames == 1)
			{
				sortList.push(new SortFrameEntry(rendered.getFrame(0), sourceName));
			}
			else
			{
				for (var i:int = 0; i < rendered.numFrames; i++)
				{
					sortList.push(new SortFrameEntry(rendered.getFrame(i), sourceName + UString.prefixZero(i, 3)));
				}
			}
		}

		sortList.sort(function(e1:SortFrameEntry, e2:SortFrameEntry):Number
		{
			return e2.size - e1.size;
		});


		var res:Vector.<AtlasData> = new Vector.<AtlasData>();

		while (sortList.length)
		{
			Log.info("...generating atlas");
			var size:Point = computeSize(sortList);
			if (size.x > _textureWidth)
			{
				size.x = _textureWidth;
			}
			if (size.y > _textureHeight)
			{
				size.y = _textureHeight;
			}

			var atlasData:AtlasData = new AtlasData(size.x, size.y, new AtlasJsonMeta());
			var allocator:AreasAllocator = new AreasAllocator(size.x, size.y);
			var rest:Vector.<SortFrameEntry> = new Vector.<SortFrameEntry>();

			for each (var entry:SortFrameEntry in sortList)
			{
				if (entry.allocate(allocator))
				{
					atlasData.renderFrame(entry.frame, entry.rect, entry.name);
				}
				else
				{
					rest.push(entry);
				}
			}

			sortList = rest;
			res.push(atlasData);

			Log.info("DONE!");
		}

		return res;
	}

	private function computeSize(list:Vector.<SortFrameEntry>):Point
	{
		var totalPixels:int = 0;
		for each (var entry:SortFrameEntry in list)
		{
			totalPixels += entry.frame.bitmapData.width * entry.frame.bitmapData.height;
		}

		var size:uint = Math.sqrt(totalPixels);
		Log.info("computed size: " + size);

		var power:int = 1;
		while(power < size)
			power*=2;

		Log.info("power of two: " + power);
		return new Point(power, power);
	}

}
}

import com.grom.flashAtlasPacker.area.AreasAllocator;

import flash.geom.Rectangle;

import net.maygem.lib.debug.Log;
import net.maygem.lib.graphics.bitmap.CachedFrame;

class SortFrameEntry
{
	private var _frame:CachedFrame;
	private var _name:String;
	private var _rect:Rectangle;

	public function SortFrameEntry(frame:CachedFrame, name:String)
	{
		_frame = frame;
		_name = name;
	}

	public function get frame():CachedFrame
	{
		return _frame;
	}

	public function get name():String
	{
		return _name;
	}

	public function get rect():Rectangle
	{
		return _rect;
	}

	public function get size():int
	{
		return Math.max(_frame.bitmapData.width, _frame.bitmapData.height);
	}

	public function allocate(allocator:AreasAllocator):Boolean
	{
		_rect = allocator.allocateArea(_frame.bitmapData.width, _frame.bitmapData.height);
		return _rect != null;
	}
}




