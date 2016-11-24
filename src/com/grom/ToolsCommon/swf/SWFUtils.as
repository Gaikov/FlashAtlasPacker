/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 12.12.13
 * Time: 18:19
 * To change this template use File | Settings | File Templates.
 */
package com.grom.ToolsCommon.swf
{
import com.grom.flashAtlasPacker.utils.Utils;
import com.grom.lib.debug.Log;

import flash.display.Loader;
import flash.events.Event;
import flash.filesystem.File;
import flash.system.LoaderContext;
import flash.utils.ByteArray;

import ru.etcs.utils.getDefinitionNames;

public class SWFUtils
{
	static public function loadClasses(bytes:ByteArray, onClassesLoaded:Function):void
	{
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function ():void
		{
			var names:Array = getDefinitionNames(bytes, false, true);
			var swfClassesMap:Object = {};
			for each (var className:String in names)
			{
				swfClassesMap[className] = Class(loader.contentLoaderInfo.applicationDomain.getDefinition(className));
			}

			if (onClassesLoaded != null)
			{
				onClassesLoaded(swfClassesMap);
			}
		});

		var loaderContext:LoaderContext = new LoaderContext();
		loaderContext.allowLoadBytesCodeExecution = true;
		loader.loadBytes(bytes, loaderContext);
	}

	static public function getClassNames(bytes:ByteArray):Array
	{
		var list:Array = getDefinitionNames(bytes, false, true);
		list.sort(0);
		return list;
	}

	static public function loadClassesFromFile(file:File, onClassesLoaded:Function):void
	{
		Log.info("loading swf classes from:", file.nativePath);
		var bytes:ByteArray = Utils.readFile(file);
		if (!bytes)
		{
			onClassesLoaded(null);
		}
		else
		{
			loadClasses(bytes, onClassesLoaded);
		}
	}

}
}
