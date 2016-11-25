/**
 * Created by roman.gaikov on 11/24/2016.
 */
package com.grom.ToolsCommon.project.array
{
public interface IArrayItemSerializer
{
	function itemToXML(item:*):XML;
	function xmlToItem(xml:XML):*;
}
}
