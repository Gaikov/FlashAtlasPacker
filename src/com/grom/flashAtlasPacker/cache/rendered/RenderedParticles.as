/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 07.06.13
 */
package com.grom.flashAtlasPacker.cache.rendered
{
import com.grom.display.particles.ParticlesDesc;
import com.grom.flashAtlasPacker.cache.IRenderedObject;

import net.maygem.lib.graphics.bitmap.CachedFrame;
import net.maygem.lib.graphics.bitmap.CachedMovieFrames;

public class RenderedParticles implements IRenderedObject
{
	private var _frames:CachedMovieFrames;

	public function RenderedParticles(desc:ParticlesDesc)
	{
		_frames = CachedMovieFrames.renderParticles(desc);
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
