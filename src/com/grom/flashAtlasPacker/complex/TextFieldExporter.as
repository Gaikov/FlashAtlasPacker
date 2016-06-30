/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.flashAtlasPacker.complex
{
import flash.display.DisplayObject;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;

public class TextFieldExporter implements ILayoutExporter
{
	public function build(obj:DisplayObject):XML
	{
		var field:TextField = TextField(obj);

		var xml:XML = DefaultLayoutExporter.getLayout(obj, field.type == TextFieldType.INPUT ? "input" : "text");
		var format:TextFormat = field.getTextFormat();
		xml.@label = field.text;
		xml.@align = format.align;
		xml.@width = field.width;
		xml.@height = field.height;
		xml.@font = format.font;
		xml.@fontSize = format.size;
		xml.@color = uint(format.color).toString(16).toUpperCase();
		delete xml["@class"];

		return xml;
	}
}
}
