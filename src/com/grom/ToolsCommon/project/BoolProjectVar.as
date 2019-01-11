package com.grom.ToolsCommon.project
{
import flash.filesystem.File;

public class BoolProjectVar extends BaseProjectVariable
{
	private var _value:Boolean;
	private var _defaultValue:Boolean;

	public function BoolProjectVar(nodeName:String, value:Boolean)
	{
		super(nodeName);
		_defaultValue = _value = value;
	}

	override public function makeXML(projectFile:File):XML
	{
		validate();
		return <{nodeName}>{_value}</{nodeName}>;
	}

	override public function readXML(source:XML, projectFile:File):Boolean
	{
		_value = String(source) == "true";
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

	override public function reset():void
	{
		_value = _defaultValue;
		super.reset();
	}
}
}
