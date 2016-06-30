/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 13.12.13
 * Time: 17:49
 * To change this template use File | Settings | File Templates.
 */
package com.grom.HRLevelExporter
{
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.getQualifiedClassName;

public class LevelExport
{
	static private function parseLevel(levelMovie:MovieClip):XML
	{
		var level:XML = <level></level>;
		//var level:Array = [];

		for (var i:int = 0; i < levelMovie.numChildren; i++)
		{
			var source:DisplayObject = levelMovie.getChildAt(i);
			var itemClass:Class = Object(source).constructor;

			var className:String = String(itemClass).match("Res_[A-Z0-9a-z]*")[0];

			var node:XML = <entity name={className}
			x={source.x} y={source.y}
			width={source.width} height={source.height} rotation={source.rotation}/>;

			level.appendChild(node);
			/*                var entity:Object =
			 {
			 name:className,
			 x:source.x,
			 y:source.y,
			 width:source.width,
			 height:source.height,
			 rotation:source.rotation
			 };

			 level.push(entity);*/
		}

		return level;
	}

	static public function saveLevel(fileName:String, fileDir:File, source:MovieClip):void
	{
		trace("write file: " + fileName);
		var level:XML = parseLevel(source);
		level.@className = getQualifiedClassName(source);

		var file:File = fileDir.resolvePath(fileName);
		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.WRITE);

		//stream.writeUTFBytes(JSON.stringify(level));
		stream.writeUTFBytes(level.toXMLString());
		stream.close();
	}
}
}
