/**
 * Created by roman.gaikov on 11/25/2016.
 */
package com.grom.FlashFontsExporter
{
import com.grom.flashAtlasPacker.fonts.FontDesc;
import com.grom.lib.utils.UContainer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.Graphics;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import mx.core.UIComponent;

public class FontPreview extends UIComponent
{
	[Embed(source='../../../../assets/fill_cells.png')]
	private var _fillCells:Class;
	
	private var _textField:TextField = new TextField();
	private var _fill:BitmapData;
	
	public function FontPreview()
	{
		_textField.autoSize = TextFieldAutoSize.LEFT;
		_fill = Bitmap(new _fillCells()).bitmapData;
	}

	public function set text(value:String):void
	{
		var format:TextFormat = _textField.getTextFormat();
		_textField.text = value;
		_textField.setTextFormat(format);
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
			format.color = font.color;
			_textField.filters = font.filters.concat();
			_textField.setTextFormat(format);
			invalidateDisplayList();
		}
	}

	override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth, unscaledHeight);
		if (_textField.parent)
		{
			_textField.x = (unscaledWidth - _textField.width) / 2;
			_textField.y = (unscaledHeight - _textField.height) / 2;
		}

		var g:Graphics = graphics;
		g.clear();
		g.lineStyle(1);
		g.beginBitmapFill(_fill);
		g.drawRect(0, 0, unscaledWidth, unscaledHeight);
		g.endFill();

	}
}
}
