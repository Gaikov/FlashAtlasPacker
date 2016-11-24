/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 11.12.13
 * Time: 18:45
 * To change this template use File | Settings | File Templates.
 */
package com.grom.ToolsCommon.project
{
import com.grom.flashAtlasPacker.utils.Utils;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

import com.grom.lib.debug.Log;
import com.grom.lib.settings.UserVar;

public class BaseProject extends EventDispatcher
{
	private var _fileName:UserVar = new UserVar("project_file_name", null);
	private var _vars:Vector.<BaseProjectVariable> = new Vector.<BaseProjectVariable>();

	public function BaseProject()
	{
	}

	final protected function registerProjectVariable(v:BaseProjectVariable):void
	{
		_vars.push(v);
		v.addEventListener(ProjectVarEvent.MODIFICATION_CHANGED, onVarChanged);
	}

	private function onVarChanged(event:ProjectVarEvent):void
	{
		dispatchEvent(new Event("modificationChanged"));
	}

	[Bindable (event="modificationChanged")]
	public function get modified():Boolean
	{
		for each (var v:BaseProjectVariable in _vars)
		{
			if (v.modified)
			{
				return true;
			}
		}
		return false;
	}

	[Bindable (event="FileNameChangedEvent")]
	public function get fileName():String
	{
		return _fileName.value;
	}

	public function set fileName(value:String):void
	{
		_fileName.value = value;
		dispatchEvent(new Event("FileNameChangedEvent"));
	}

	final public function tryLoad():void
	{
		if (fileName)
		{
			load();
		}
	}

	final public function load():void
	{
		Log.info("loading project: ", fileName);

		var file:File = new File(_fileName.value);
		if (!file.exists)
		{
			fileName = "";
			return;
		}

		var bytes:ByteArray = Utils.readFile(file);
		if (!bytes)
		{
			return;
		}
		var xml:XML = new XML(bytes.readUTFBytes(bytes.bytesAvailable));

		for each (var node:XML in xml.*)
		{
			var name:String = String(node.name());
			var v:BaseProjectVariable = findVar(name);
			if (v)
			{
				v.readXML(node, file);
			}
			else
			{
				Log.warning("project variable not found: " + name);
			}
		}

		onLoaded();
	}

	protected function onLoaded():void
	{
	}

	private function findVar(name:String):BaseProjectVariable
	{
		for each (var v:BaseProjectVariable in _vars)
		{
			if (v.nodeName == name)
			{
				return v;
			}
		}
		return null;
	}

	final public function save():void
	{
		Log.info("write project: ", fileName);
		var xml:XML = <project></project>;
		var file:File = new File(_fileName.value);

		for each (var v:BaseProjectVariable in _vars)
		{
			xml.appendChild(v.makeXML(file));
		}

		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.WRITE);
		stream.writeUTFBytes(xml.toXMLString());
		stream.close();
	}
}
}
