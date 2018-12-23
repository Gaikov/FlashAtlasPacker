package com.grom.HRLevelExporter.views
{
import com.grom.common.components.BaseContentPreview;

import flash.display.DisplayObject;

public class LevelPreview extends BaseContentPreview
{
	private var _level:DisplayObject;
	private var _background:DisplayObject;

	public function set level(value:DisplayObject):void
	{
		if (_level != value)
		{
			if (_level)
			{
				content.removeChild(_level);
			}

			_level = value;

			if (_level)
			{
				content.addChild(_level);
			}
		}
	}
}
}
