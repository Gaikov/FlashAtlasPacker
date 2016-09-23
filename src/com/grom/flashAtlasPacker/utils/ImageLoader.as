/**
 * Created by roman.gaikov on 9/23/2016.
 */
package com.grom.flashAtlasPacker.utils
{
import com.grom.lib.debug.Log;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.filesystem.File;
import flash.utils.ByteArray;

public class ImageLoader
{
	static public function load(file:File, onCompleted:Function):void
	{
		var bytes:ByteArray = Utils.readFile(file);
		if (bytes)
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function ():void
			{
				onCompleted(Bitmap(loader.content).bitmapData);
			});
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function ():void
			{
				Log.warning("io error extracting image: ", file.nativePath);
				onCompleted(null);
			});
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function ():void
			{
				Log.warning("security error extracting image: ", file.nativePath);
				onCompleted(null);
			});
		}
		else
		{
			onCompleted(null);
		}
		
	}
}
}
