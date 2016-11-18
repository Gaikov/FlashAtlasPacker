/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 12.12.13
 * Time: 16:09
 * To change this template use File | Settings | File Templates.
 */
package com.grom.ToolsCommon.project
{
import flash.events.EventDispatcher;
import flash.filesystem.File;

public class BaseProjectVariable extends EventDispatcher
{
	private var _modified:Boolean = false;
	private var _nodeName:String;

	public function BaseProjectVariable(nodeName:String)
	{
		_nodeName = nodeName;
	}

	final public function get nodeName():String
	{
		return _nodeName;
	}

	public function set modified(value:Boolean):void
	{
		if (_modified != value)
		{
			_modified = value;
			dispatchEvent(new ProjectVarEvent(ProjectVarEvent.MODIFICATION_CHANGED));
		}
	}

	final public function get modified():Boolean
	{
		return _modified;
	}

	public function makeXML(projectFile:File):XML
	{
		throw new Error("need overried makeXML");
	}

	public function readXML(source:XML, projectFile:File):Boolean
	{
		throw new Error("need override readXML");
	}

	[Bindable (event="VarChangedEvent")]
	public function get value():*
	{
		throw new Error("Need override getter");
	}

	public function set value(v:*):void
	{
		throw new Error("Need override setter");
	}
}
}
