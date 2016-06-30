/**
 * Created by roman.gaikov on 4/29/2016.
 */
package com.grom.flashAtlasPacker.generator.atlasMeta
{
	import flash.geom.Rectangle;

	import net.maygem.lib.graphics.bitmap.CachedFrame;

	public interface IAtlasMeta
	{
		function set textureFileName(value:String):void;
		function writeFrameAttr(frame:CachedFrame, coords:Rectangle, name:String):void;
		function get meta():String;
		function get fileExt():String;
		function setSize(width:int, height:int):void;
	}
}
