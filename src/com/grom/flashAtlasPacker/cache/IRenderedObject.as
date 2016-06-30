/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.02.13
 */
package com.grom.flashAtlasPacker.cache
{
import com.grom.lib.graphics.bitmap.CachedFrame;

public interface IRenderedObject
{
	function get numFrames():int
	function getFrame(index:int):CachedFrame;
}
}
