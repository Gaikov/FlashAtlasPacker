/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.flashAtlasPacker.complex
{
import com.grom.flashAtlasPacker.fonts.FontDesc;
import com.grom.flashAtlasPacker.fonts.FontsExporter;

import flash.display.DisplayObject;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;

public class TextFieldExporter implements ILayoutExporter
{
	private var _fontsExporter:FontsExporter;

	public function TextFieldExporter(fontsExporter:FontsExporter)
	{
		_fontsExporter = fontsExporter;
	}

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

		var desc:FontDesc = new FontDesc(format.font, int(format.size), uint(format.color), field.filters);
		_fontsExporter.registerFont(desc);
		xml.@bitmapFont = desc.id;
		
		delete xml["@class"];

		return xml;
	}
}
}
