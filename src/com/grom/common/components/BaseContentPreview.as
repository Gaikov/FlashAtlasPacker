package com.grom.common.components
{
import com.grom.input.mouse.CaptureMousePolicy;
import com.grom.input.mouse.MouseListener;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

import mx.core.UIComponent;

public class BaseContentPreview extends UIComponent
{
	private var _content:Sprite = new Sprite();
	private var _mouseStart:Point;
	private var _posStart:Point;

	public function BaseContentPreview()
	{
		addChild(_content);
		mouseChildren = false;
		new CaptureMousePolicy(this, new MouseListener(onMouseDown, onMouseMove));
	}

	public function get content():Sprite
	{
		return _content;
	}

	private function onMouseMove(e:MouseEvent):void
	{
		var mousePos:Point = new Point(mouseX, mouseY);
		var offset:Point = mousePos.subtract(_mouseStart);

		_content.x = _posStart.x + offset.x;
		_content.y = _posStart.y + offset.y;
	}

	private function onMouseDown(e:MouseEvent):void
	{
		_mouseStart = new Point(mouseX, mouseY);
		_posStart = new Point(_content.x, _content.y);
	}

	override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth, unscaledHeight);
		scrollRect = new Rectangle(0, 0, unscaledWidth, unscaledHeight);
		var g:Graphics = graphics;
		g.clear();
		g.beginFill(0, 0.1);
		g.drawRect(0, 0, unscaledWidth, unscaledHeight);
		g.endFill();
	}
}
}
