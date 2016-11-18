/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 13.12.13
 * Time: 16:42
 * To change this template use File | Settings | File Templates.
 */
package com.grom.ToolsCommon.project
{
import flash.filesystem.File;

import mx.collections.ArrayList;

public class ArrayListProjectVariable extends BaseProjectVariable
{
	private var _list:ArrayList = new ArrayList();

	public function ArrayListProjectVariable(nodeName:String)
	{
		super(nodeName);
	}

	final public function addItem(item:*):void
	{
		_list.addItem(item);
	}

	final public function removeItem(item:*):void
	{
		_list.removeItem(item);
	}

	final override public function makeXML(projectFile:File):XML
	{
		modified = false;
		var res:XML = <{nodeName}></{nodeName}>;

		var arr:Array = _list.toArray();
		for each (var item:* in arr)
		{
			res.appendChild(itemToXML(item));
		}

		return res;
	}

	protected function itemToXML(item:*):XML //TODO: make IItemSerializer and DefaultItemSerializer
	{
		return <item>{item.toString()}</item>;
	}

	protected function xmlToItem(xml:XML):*
	{
		return String(xml);
	}

	final override public function readXML(source:XML, projectFile:File):Boolean
	{
		_list.removeAll();

		for each (var xml:XML in source.*)
		{
			_list.addItem(xmlToItem(xml));
		}
		modified = false;
		return true;
	}

	[Bindable(event="VarChangedEvent")]
	final override public function get value():*
	{
		return _list;
	}

	final override public function set value(v:*):void
	{
		throw new Error("Can't set ArrayList directly!");
	}
}
}
