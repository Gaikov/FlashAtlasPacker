/**
 * Created by roman.gaikov on 4/29/2016.
 */
package com.grom.flashAtlasPacker.generator.atlasMeta
{
	import com.adobe.serialization.json.JSON;

	import flash.geom.Rectangle;

	import com.grom.lib.graphics.bitmap.CachedFrame;

	public class AtlasJsonMeta implements IAtlasMeta
	{
		private var _root:Object;
		private var _meta:Object = {};
		private var _frames:Object = {};

		public function AtlasJsonMeta()
		{

			_root = {
				meta: _meta,
				frames : _frames
			};

			_meta.format = "RGBA8888";
			_meta.scale = 1;
		}

		public function set textureFileName(value:String):void
		{
			_meta.image = value;
		}

		public function writeFrameAttr(frame:CachedFrame, coords:Rectangle, name:String):void
		{
			_frames[name] =
			{
				frame: {x:coords.x, y:coords.y, w:coords.width, h:coords.height},
				rotated: false,
				trimmed: true,
				spriteSourceSize: {x:frame.offset.x, y:frame.offset.y, w:coords.width, h:coords.height},
				sourceSize: {w:coords.width, h:coords.height}
			};
		}

		public function get meta():String
		{
			return com.adobe.serialization.json.JSON.encode(_root);
		}

		public function get fileExt():String
		{
			return "json";
		}

		public function setSize(width:int, height:int):void
		{
			_meta.size = {width:width, height:height};
		}
	}
}
