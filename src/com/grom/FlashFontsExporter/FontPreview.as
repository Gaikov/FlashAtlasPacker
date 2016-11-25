/**
 * Created by roman.gaikov on 11/25/2016.
 */
package com.grom.FlashFontsExporter
{
import com.grom.flashAtlasPacker.fonts.FontDesc;
import com.grom.lib.utils.UContainer;

import flash.text.TextField;
import flash.text.TextFormat;

import mx.core.UIComponent;

public class FontPreview extends UIComponent
{
	private var _textField:TextField = new TextField();
	
	public function FontPreview()
	{
	}

	public function set text(value:String):void
	{
		_textField.text = value;
		invalidateDisplayList();
	}
	
	public function set fontDesc(font:FontDesc):void
	{
		UContainer.updatePresence(this, _textField, font != null);
		
		if (font)
		{
			var format:TextFormat = _textField.getTextFormat();
			format.font = font.family;
			format.size = font.size;
			
			
			
		}
	}
}
}
