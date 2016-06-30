/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 07.06.13
 */
package com.grom.flashAtlasPacker.cache.rendered
{
import com.grom.flashAtlasPacker.cache.IRenderedObject;

import flash.display.DisplayObject;

import com.grom.lib.graphics.bitmap.CachedFrame;

public class RenderedSprite implements IRenderedObject
{
	private var _frame:CachedFrame;

	public function RenderedSprite(sprite:DisplayObject)
	{
		_frame = CachedFrame.renderObject(sprite).trim();
	}

	public function get numFrames():int
	{
		return 1;
	}

	public function getFrame(index:int):CachedFrame
	{
		return index == 0 ? _frame : null;
	}
}
}
