/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 07.06.13
 */
package com.grom.flashAtlasPacker.generator.atlasSource
{
import com.grom.display.particles.ParticlesDesc;
import com.grom.flashAtlasPacker.cache.IRenderedObject;
import com.grom.flashAtlasPacker.cache.rendered.RenderedParticles;

public class ParticlesAtlasSource implements IAtlasSource
{
	private var _name:String;
	private var _partDesc:ParticlesDesc;

	public function ParticlesAtlasSource(name:String, partDesc:ParticlesDesc)
	{
		_name = name;
		_partDesc = partDesc;
	}

	public function get resourceName():String
	{
		return _name;
	}

	public function get rendered():IRenderedObject
	{
		return new RenderedParticles(_partDesc);
	}

	public function prepareChildren():void
	{
	}

	public function get numChildren():int
	{
		return 0;
	}

	public function getChildAt(index:int):IAtlasSource
	{
		return null;
	}
}
}
