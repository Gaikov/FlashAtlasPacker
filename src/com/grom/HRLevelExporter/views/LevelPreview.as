package com.grom.HRLevelExporter.views
{
import com.grom.common.components.BaseContentPreview;
import com.grom.lib.graphics.bitmap.CachedFrame;

import flash.display.DisplayObject;

public class LevelPreview extends BaseContentPreview
{
	private var _level:DisplayObject;
	private var _background:DisplayObject;

	public function set level(value:DisplayObject):void
	{
		if (_level)
		{
			content.removeChild(_level);
			_level = null;
		}

		if (value)
		{
			_level = CachedFrame.cachedSprite(value);
			content.addChild(_level);
		}
	}
}
}
