/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 07.06.13
 */
package com.grom.flashAtlasPacker.generator.atlasSource
{
import com.grom.flashAtlasPacker.complex.ContainerLayoutBuilder;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.text.TextField;

import com.grom.lib.utils.UContainer;
import com.grom.lib.utils.UDisplay;

public class ContainerAtlasSource extends ObjectAtlasSource
{
	private var _children:Vector.<IAtlasSource> = new Vector.<IAtlasSource>();
	private var _container:DisplayObjectContainer;

	public function ContainerAtlasSource(cls:Class)
	{
		super(cls);
		_container = DisplayObjectContainer(object);
	}

	override public function prepareChildren():void
	{
		var children:Array = [];
		var fields:Array = [];

		for (var i:int = 0; i < _container.numChildren; i++)
		{
			var child:DisplayObject = _container.getChildAt(i);

			if (child is TextField)
			{
				fields.push(child);
			}
			else if (!UDisplay.isDefaultName(child))
			{
				children.push(child);
			}
		}

		UContainer.removeChildren(_container, fields);

		for each (child in children)
		{
			_container.removeChild(child);
			if (ContainerLayoutBuilder.isContainer(child))
			{
				_children.push(new ContainerAtlasSource(Object(child).constructor))
			}
			else
			{
				_children.push(new ObjectAtlasSource(Object(child).constructor));
			}
		}
	}

	override public function get numChildren():int
	{
		return _children.length;
	}

	override public function getChildAt(index:int):IAtlasSource
	{
		return _children[index];
	}
}
}
