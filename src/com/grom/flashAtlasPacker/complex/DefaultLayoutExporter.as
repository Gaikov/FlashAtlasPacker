/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.flashAtlasPacker.complex
{
import com.grom.flashAtlasPacker.utils.Utils;

import flash.display.DisplayObject;
import flash.geom.Rectangle;

import com.grom.lib.utils.UDisplay;

public class DefaultLayoutExporter implements ILayoutExporter
{
	public function build(obj:DisplayObject):XML
	{
		var isMovie:Boolean = Utils.isMovie(obj);
		var xml:XML = getLayout(obj, isMovie  ? "movie" : "image");
		if (!isMovie && obj.scale9Grid)
		{
			var rect:Rectangle = obj.scale9Grid;
			xml.setName("scale9image");
			xml.@gridLeft = rect.left;
			xml.@gridTop = rect.top;
			xml.@gridWidth = rect.width;
			xml.@gridHeight = rect.height;
		}
		return xml;
	}

	static public function getLayout(obj:DisplayObject, tagName:String):XML
	{
		var name:String = "";
		if (!UDisplay.isDefaultName(obj))
		{
			name = obj.name;
		}

		return <{tagName} name={name} class={Utils.getClassName(obj)}
		x={obj.x} y={obj.y}
		rotation={obj.rotation}
		sx={obj.scaleX} sy={obj.scaleY}/>;
	}
}
}
