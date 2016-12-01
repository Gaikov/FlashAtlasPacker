/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 13.12.13
 * Time: 16:42
 * To change this template use File | Settings | File Templates.
 */
package com.grom.ToolsCommon.project
{
import com.grom.ToolsCommon.project.array.DefaultArrayItemSerializer;
import com.grom.ToolsCommon.project.array.IArrayItemSerializer;

import flash.filesystem.File;

import mx.collections.ArrayList;

public class ArrayListProjectVariable extends BaseProjectVariable
{
	private var _list:ArrayList = new ArrayList();
	private var _itemSerializer:IArrayItemSerializer;

	public function ArrayListProjectVariable(nodeName:String, itemSerializer:IArrayItemSerializer)
	{
		super(nodeName);
		if (itemSerializer)
		{
			_itemSerializer = itemSerializer
		}
		else
		{
			_itemSerializer = new DefaultArrayItemSerializer();
		}
	}

	final public function addItem(item:*):void
	{
		_list.addItem(item);
		modified = true;
	}

	final public function removeItem(item:*):void
	{
		_list.removeItem(item);
		modified = true;
	}

	final public function findItem(predicate:Function):*
	{
		for each (var item:* in _list.source)
		{
			if (predicate(item))
			{
				return item;
			}
		}
		return null;
	}

	final override public function makeXML(projectFile:File):XML
	{
		modified = false;
		var res:XML = <{nodeName}></{nodeName}>;

		var arr:Array = _list.toArray();
		for each (var item:* in arr)
		{
			res.appendChild(_itemSerializer.itemToXML(item));
		}

		return res;
	}

	final override public function readXML(source:XML, projectFile:File):Boolean
	{
		_list.removeAll();

		for each (var xml:XML in source.*)
		{
			_list.addItem(_itemSerializer.xmlToItem(xml));
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

	public function clear():void
	{
		_list.removeAll();
		modified = true;
	}
}
}
