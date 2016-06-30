/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.02.13
 */
package com.grom.flashAtlasPacker
{
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;
import flash.utils.getQualifiedClassName;

import com.grom.lib.debug.Log;

public class Utils
{
	static public function getClassName(obj:Object):String
	{
		return getQualifiedClassName(obj.constructor);
	}

	public static function isMovie(obj:DisplayObject):Boolean
	{
		var mc:MovieClip = obj as MovieClip;
		return mc && mc.totalFrames > 1;
	}

	static public function readFile(file:File):ByteArray
	{
		var bytes:ByteArray = new ByteArray();
		var stream:FileStream = new FileStream();
		try
		{
			stream.open(file, FileMode.READ);
		}
		catch (e:Error)
		{
			Log.error("can't open file: ", file.nativePath);
			return null;
		}
		stream.readBytes(bytes);
		stream.close();
		bytes.position = 0;
		return bytes;
	}

	static public function getRelativePath(path:String, relativeTo:File):String
	{
		if (!path) return "";

		relativeTo = getFilePath(relativeTo);

		var file:File = new File(path);
		return relativeTo.getRelativePath(file, true);
	}

	static public function resolvePath(path:String, relativeTo:File):String
	{
		if (!path) return "";

		if (relativeTo.isDirectory)
		{
			return relativeTo.resolvePath(path).nativePath;
		}

		var file:File = getFilePath(relativeTo);
		return file.resolvePath(path).nativePath;
	}

	static public function getFilePath(file:File):File
	{
		if (file.isDirectory)
		{
			return file;
		}
		var fileName:String = file.name;
		var relativePath:String = file.nativePath.replace(fileName, "");
		return new File(relativePath);
	}

	static public function fileName(file:File):String
	{
		var i:int = file.name.indexOf(file.extension);
		if (i >= 0)
		{
			return file.name.substr(0, i - 1);
		}
		return file.name;
	}
}
}
