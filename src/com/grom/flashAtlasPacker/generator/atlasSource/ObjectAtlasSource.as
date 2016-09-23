/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 07.06.13
 */
package com.grom.flashAtlasPacker.generator.atlasSource
{
import com.grom.flashAtlasPacker.utils.Utils;
import com.grom.flashAtlasPacker.cache.IRenderedObject;
import com.grom.flashAtlasPacker.cache.rendered.RenderedButton;
import com.grom.flashAtlasPacker.cache.rendered.RenderedMovie;
import com.grom.flashAtlasPacker.cache.rendered.RenderedSprite;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;

import flash.utils.getQualifiedClassName;

public class ObjectAtlasSource implements IAtlasSource
{
	private var _object:DisplayObject;

	public function ObjectAtlasSource(cls:Class)
	{
		_object = new cls;
	}

	public function get object():DisplayObject
	{
		return _object;
	}

	public function prepareChildren():void
	{
	}

	public function get resourceName():String
	{
		return getQualifiedClassName(_object);
	}

	public function get rendered():IRenderedObject
	{
		var rendered:IRenderedObject;

		if (_object is SimpleButton)
		{
			rendered = new RenderedButton(SimpleButton(_object));
		}
		else if (Utils.isMovie(_object))
		{
			rendered = new RenderedMovie(MovieClip(_object))
		}
		else
		{
			rendered = new RenderedSprite(_object);
		}

		return rendered;
	}

	public function get numChildren():int
	{
		return 0;
	}

	public function getChildAt(index:int):IAtlasSource
	{
		return null;
	}
}
}
