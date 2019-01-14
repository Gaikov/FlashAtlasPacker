/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 12.12.13
 * Time: 16:09
 * To change this template use File | Settings | File Templates.
 */
package com.grom.ToolsCommon.project
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;

public class BaseProjectVariable extends EventDispatcher
{
	public static const CHANGED:String = "VarChangedEvent";

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

	[Bindable (event="VarChangedEvent")]
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

	final protected function invalidate():void
	{
		dispatchEvent(new Event(CHANGED));
		_modified = true;
	}

	final protected function validate():void
	{
		dispatchEvent(new Event(CHANGED));
		_modified = false;
	}

	public function reset():void
	{
		validate();
	}

	override public function toString():String
	{
		return value;
	}
}
}
