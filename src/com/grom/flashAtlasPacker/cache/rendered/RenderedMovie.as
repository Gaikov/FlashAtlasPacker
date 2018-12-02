/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 07.06.13
 */
package com.grom.flashAtlasPacker.cache.rendered
{
import com.grom.flashAtlasPacker.cache.IRenderedObject;

import flash.display.MovieClip;

import com.grom.lib.graphics.bitmap.CachedFrame;
import com.grom.lib.graphics.bitmap.CachedMovieFrames;

public class RenderedMovie implements IRenderedObject
{
	private var _frames:CachedMovieFrames;

	public function RenderedMovie(mc:MovieClip)
	{
		_frames = CachedMovieFrames.renderMovie(mc, false);
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
