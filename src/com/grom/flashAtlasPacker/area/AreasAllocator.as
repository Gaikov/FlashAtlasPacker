/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 27.02.13
 */
package com.grom.flashAtlasPacker.area
{
import flash.geom.Rectangle;

public class AreasAllocator
{
	private var _areas:Array = [];
	private var _width:int;
	private var _height:int;
	private var _spacing:int;

	public function AreasAllocator(width:int, height:int, spacing:int = 1)
	{
		_width = width;
		_height = height;
		_spacing = spacing;
	}

	public function allocateArea(width:int, height:int):Rectangle
	{
		var res:Rectangle = findPlace(width, height);
		if (res)
		{
			_areas.push(res);
		}
		return res;
	}

	private function findPlace(width:int, height:int):Rectangle
	{
		var rect:Rectangle;

		if (!_areas.length)
		{
			rect = createRect(0, 0, width, height);
			if (checkRectInBounds(rect))
			{
				return correctResult(rect);
			}
		}
		else
		{
			for each (var area:Rectangle in _areas)
			{
				var posList:Array =
				[
					//right side
					{x:area.right, y:area.top},
					{x:area.right, y:area.bottom - height},

					//bottom side
					{x:area.left, y:area.bottom},
					{x:area.right - width, y:area.bottom},

					//left side
					{x:area.left - width, y:area.top},
					{x:area.left - width, y:area.bottom - height},

					//top side
					{x:area.left, y:area.top - height},
					{x:area.right - width, y:area.top - height}
				];

				for each (var pos:Object in posList)
				{
					rect = createRect(pos.x, pos.y, width, height);
					if (isAvailablePlace(rect))
					{
						return correctResult(rect);
					}
				}

			}
		}
		return null;
	}

	private function createRect(x:int, y:int, width:int, height:int):Rectangle
	{
		return new Rectangle(x + _spacing, y + _spacing,
			width + _spacing * 2, height + _spacing * 2);
	}

	private function correctResult(rect:Rectangle):Rectangle
	{
		return new Rectangle(rect.x + _spacing, rect.y + _spacing,
			rect.width - _spacing * 2, rect.height - _spacing * 2);
	}

	private function isAvailablePlace(rect:Rectangle):Boolean
	{
		if (checkRectInBounds(rect))
		{
			for each (var area:Rectangle in _areas)
			{
				if (area.intersects(rect))
				{
					return false;
				}
			}
			return true;
		}
		return false;
	}

	public function removeArea(area:Rectangle):void
	{
		var index:int = _areas.indexOf(area);
		if (index >= 0)
		{
			_areas.splice(index, 1);
		}
	}

	private function checkRectInBounds(rect:Rectangle):Boolean
	{
		return rect.left >= 0 && rect.right <= _width
			&& rect.top >= 0 && rect.bottom <= _height;
	}



}
}

