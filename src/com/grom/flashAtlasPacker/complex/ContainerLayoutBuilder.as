/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.02.13
 */
package com.grom.flashAtlasPacker.complex
{
import avmplus.getQualifiedClassName;

import com.grom.flashAtlasPacker.utils.Utils;
import com.grom.flashAtlasPacker.fonts.FontsExporter;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.SimpleButton;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.text.TextField;
import flash.utils.Dictionary;

import com.grom.lib.utils.UDisplay;

public class ContainerLayoutBuilder
{
	private var _exportersClassNameMap:Object = {};
	private var _exportersClassMap:Dictionary = new Dictionary();

	private var _container:DisplayObjectContainer;
	private var _defaultExporter:ILayoutExporter = new DefaultLayoutExporter();

	public function ContainerLayoutBuilder(container:DisplayObjectContainer, fontExporter:FontsExporter)
	{
		_container = container;
		registerExporterByClassName(getQualifiedClassName(TextField), new TextFieldExporter(fontExporter));
		registerExporterByClass(SimpleButton, new ButtonExporter());
	}

	public function registerExporterByClassName(className:String, e:ILayoutExporter):void
	{
		_exportersClassNameMap[className] = e;
	}

	public function registerExporterByClass(cls:Class, e:ILayoutExporter):void
	{
		_exportersClassMap[cls] = e;
	}

	static public function saveClasses(folder:File, classes:Vector.<Class>, fontExporter:FontsExporter):void
	{
		var layout:XML = <layouts/>;

		for each (var cls:Class in classes)
		{
			var obj:DisplayObject = new cls();
			if (isContainer(obj))
			{
				var builder:ContainerLayoutBuilder = new ContainerLayoutBuilder(DisplayObjectContainer(obj), fontExporter);
				layout.appendChild(builder.build());
			}
		}

		var xmlFile:File = folder.resolvePath("layouts.xml");
		var stream:FileStream = new FileStream();
		stream.open(xmlFile, FileMode.WRITE);
		stream.writeUTFBytes(layout.toXMLString());
		stream.close();
	}

	static public function isContainer(obj:DisplayObject):Boolean
	{
		var c:DisplayObjectContainer = obj as DisplayObjectContainer;
		if (c)
		{
			for (var i:int = 0; i < c.numChildren; i++)
			{
				var child:DisplayObject = c.getChildAt(i);
				if (!UDisplay.isDefaultName(child) || !(obj is TextField))
				{
					return true;
				}
			}
		}
		return false;
	}

	public function build():XML
	{
		return traceObject(_container, _defaultExporter);
	}

	private function traceObject(obj:DisplayObject, exporter:ILayoutExporter):XML
	{
		var layout:XML = exporter.build(obj);

		var c:DisplayObjectContainer = obj as DisplayObjectContainer;
		if (c)
		{
			for (var i:int = 0; i < c.numChildren; i++)
			{
				var child:DisplayObject = c.getChildAt(i);
				exporter = getExporter(child);
				if (exporter)
				{
					layout.appendChild(traceObject(child, exporter));
				}
			}
		}
		return layout;
	}

	private function getExporter(obj:DisplayObject):ILayoutExporter
	{
		var className:String = Utils.getClassName(obj);
		var e:ILayoutExporter = _exportersClassNameMap[className];
		if (e)
		{
			return e;
		}

		for (var key:Object in _exportersClassMap)
		{
			var cls:Class = Class(key);
			if (obj is cls)
			{
				return _exportersClassMap[key];
			}
		}

		if (!UDisplay.isDefaultName(obj))
		{
			return _defaultExporter
		}
		return null;
	}
}
}
