/**
 * Created by roman.gaikov on 11/24/2016.
 */
package com.grom.FlashFontsExporter.mapping
{
import com.grom.ToolsCommon.project.array.IArrayItemSerializer;

public class SelectedFontSerializer implements IArrayItemSerializer
{
	public function SelectedFontSerializer()
	{
	}

	public function itemToXML(item:*):XML
	{
		var font:SelectedFont = item;
		return <font_name file_name={font.exportFileName} id={font.id} selected={font.selected}/>;
	}

	public function xmlToItem(xml:XML):*
	{
		var font:SelectedFont = new SelectedFont(String(xml.@file_name), String(xml.@id));
		font.selected = String(xml.@selected) == "true";
		return font;
	}
}
}
