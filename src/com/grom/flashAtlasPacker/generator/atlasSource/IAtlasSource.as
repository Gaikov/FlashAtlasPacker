/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 07.06.13
 * Time: 0:02
 * To change this template use File | Settings | File Templates.
 */
package com.grom.flashAtlasPacker.generator.atlasSource
{
import com.grom.flashAtlasPacker.cache.IRenderedObject;

public interface IAtlasSource
{
	function get resourceName():String;
	function get rendered():IRenderedObject;

	function prepareChildren():void
	function get numChildren():int
	function getChildAt(index:int):IAtlasSource
}
}
