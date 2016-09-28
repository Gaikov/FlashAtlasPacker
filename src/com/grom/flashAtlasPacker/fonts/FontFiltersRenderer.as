/**
 * Created by roman.gaikov on 9/23/2016.
 */
package com.grom.flashAtlasPacker.fonts
{
import com.grom.flashAtlasPacker.utils.Utils;
import com.grom.lib.resources.customLoaders.BitmapLoader;

import flash.display.BitmapData;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filters.BitmapFilter;
import flash.geom.Point;
import flash.geom.Rectangle;

public class FontFiltersRenderer extends EventDispatcher
{
	private var _font:FontDesc;
	private var _outFolder:File;

	private var _texturesQueue:Vector.<String> = new <String>[];

	public function FontFiltersRenderer(font:FontDesc, outFolder:File)
	{
		_font = font;
		_outFolder = outFolder;
	}

	public function applyFilters():void
	{
		var fontFile:File = _outFolder.resolvePath(_font.name + ".fnt");
		var meta:XML = new XML(Utils.readFileText(fontFile));

		for each (var page:XML in meta.pages.page)
		{
			_texturesQueue.push(page.@file);
		}

		processNextTexture();
	}

	private function processNextTexture():void
	{
		var fileName:String = _texturesQueue.shift();
		if (!fileName)
		{
			dispatchEvent(new Event(Event.COMPLETE));
			return;
		}

		var imageFile:File = _outFolder.resolvePath(fileName);
		var loader:BitmapLoader = new BitmapLoader(imageFile.url, function (data:BitmapData):void
		{
			if (data)
			{
				for each (var f:BitmapFilter in _font.filters)
				{
					data.applyFilter(data, new Rectangle(0, 0, data.width, data.height), new Point(0, 0), f);
				}
				Utils.savePng(imageFile, data);
			}
			processNextTexture();
		});
		loader.load();
	}
}
}
