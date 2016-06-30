/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.02.13
 */
package com.grom.flashAtlasPacker.generator
{
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import net.maygem.lib.graphics.bitmap.CachedFrame;

public class AllocatedFrames
{
	private var _frames:Vector.<CachedFrame> = new <CachedFrame>[];
	private var _areas:Vector.<Rectangle> = new <Rectangle>[];

	public function addFrame(rect:Rectangle, frame:CachedFrame):void
	{
		_areas.push(rect);
		_frames.push(frame);
	}

	public function get count():int
	{
		return _frames.length;
	}

	public function getFrame(index:int):CachedFrame
	{
		return _frames[index];
	}

	public function drawToBitmap(bm:BitmapData):void
	{
		for (var i:int = 0; i < _frames.length; i++)
		{
			var rect:Rectangle = _areas[i];
			var m:Matrix = new Matrix();
			m.translate(rect.left, rect.top);
			bm.draw(_frames[i].bitmapData, m);
		}
	}

	public function getRect(index:int):Rectangle
	{
		return _areas[index];
	}
}
}
