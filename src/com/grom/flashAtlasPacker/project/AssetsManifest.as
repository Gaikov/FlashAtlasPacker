/**
 * Created by roman.gaikov on 10/4/2016.
 */
package com.grom.flashAtlasPacker.project
{
import com.grom.flashAtlasPacker.utils.Utils;
import com.grom.lib.debug.Log;

import flash.filesystem.File;

public class AssetsManifest
{
	private var _atlases:Array = [];
	private var _fonts:Array = [];
	private var _layouts:Array = ["layout.xml"]; //reserved for future

	public function AssetsManifest()
	{
	}

	public function addAtlas(fileName:String):void
	{
		_atlases.push(fileName);
	}

	public function addFont(fileName:String):void
	{
		_fonts.push(fileName);
	}

	public function write(outPath:File):void
	{
		var data:Object = {
			atlases:_atlases,
			fonts:_fonts,
			layouts:_layouts
		};

		var assets:File = outPath.resolvePath("assets.json");
		Log.info("write manifest: ", assets.nativePath);
		Utils.writeFileText(assets, JSON.stringify(data, null, 1));
	}
}
}
