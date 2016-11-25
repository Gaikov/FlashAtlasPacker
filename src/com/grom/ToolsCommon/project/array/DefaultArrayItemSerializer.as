/**
 * Created by roman.gaikov on 11/24/2016.
 */
package com.grom.ToolsCommon.project.array
{
public class DefaultArrayItemSerializer implements IArrayItemSerializer
{
	public function DefaultArrayItemSerializer()
	{
	}

	public function itemToXML(item:*):XML
	{
		return <item>{item.toString()}</item>;
	}

	public function xmlToItem(xml:XML):*
	{
		return String(xml);
	}

}
}
