/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 06.06.13
 */
package com.grom.flashAtlasPacker.project
{
import com.grom.display.particles.ParticlesDesc;
import com.grom.flashAtlasPacker.Utils;
import com.grom.flashAtlasPacker.generator.atlasSource.IAtlasSource;
import com.grom.flashAtlasPacker.generator.atlasSource.ParticlesAtlasSource;

import flash.filesystem.File;
import flash.utils.ByteArray;
import flash.utils.getQualifiedClassName;

public class ParticlesModel
{
	public var _fileName:String;
	public var _particleClass:Class;

	public function ParticlesModel()
	{
	}

	public function get name():String
	{
		if (_fileName)
		{
			var file:File = new File(_fileName);
			return Utils.fileName(file);
		}
		return null;
	}

	public function get className():String
	{
		if (_particleClass)
		{
			return getQualifiedClassName(_particleClass);
		}
		return "";
	}

	public function createSource():IAtlasSource
	{
		if (!_fileName || !_particleClass) return null;

		var bytes:ByteArray = Utils.readFile(new File(_fileName));
		var data:String = bytes.readUTFBytes(bytes.bytesAvailable);

		var desc:ParticlesDesc = new ParticlesDesc();
		desc._viewClass = _particleClass;
		desc.parseFromXML(new XML(data));

		return new ParticlesAtlasSource(name, desc);
	}
}
}
