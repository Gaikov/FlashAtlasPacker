/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 12.12.13
 * Time: 17:02
 * To change this template use File | Settings | File Templates.
 */
package com.grom.ToolsCommon.project
{
import flash.filesystem.File;

public class StringProjectVariable extends BaseProjectVariable
{
	private var _value:String;

	public function StringProjectVariable(nodeName:String, value:String)
	{
		super(nodeName);
		_value = value;
	}

	override public function makeXML(projectFile:File):XML
	{
		validate();
		return <{nodeName}>{_value}</{nodeName}>;
	}

	override public function readXML(source:XML, projectFile:File):Boolean
	{
		_value = String(source);
		validate();
		return true;
	}

	[Bindable(event="VarChangedEvent")]
	override public function get value():*
	{
		return _value;
	}

	override public function set value(v:*):void
	{
		if (_value != v)
		{
			_value = v;
			invalidate();
		}
	}
}
}
