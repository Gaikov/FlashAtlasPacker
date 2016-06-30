/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 07.06.13
 */
package com.grom.flashAtlasPacker.cache.rendered
{
import com.grom.flashAtlasPacker.cache.IRenderedObject;

import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;

import net.maygem.lib.graphics.bitmap.CachedFrame;
import net.maygem.lib.graphics.bitmap.CachedMovieFrames;

public class RenderedButton implements IRenderedObject
{
	private var _frames:CachedMovieFrames = new CachedMovieFrames();

	public function RenderedButton(button:SimpleButton)
	{
		renderState(button.upState);
		renderState(button.overState);
		renderState(button.downState);
	}

	private function renderState(state:DisplayObject):void
	{
		if (state)
		{
			var c:Sprite = new Sprite();
			c.addChild(state);
			_frames.addFrame(CachedFrame.renderObject(c).trim());
		}
	}

	public function get numFrames():int
	{
		return _frames.count;
	}

	public function getFrame(index:int):CachedFrame
	{
		return _frames.getFrame(index);
	}
}
}
