/**
 * Created by roman.gaikov on 4/29/2016.
 */
package com.grom.flashAtlasPacker.generator.atlasMeta
{
	import flash.geom.Rectangle;

	import net.maygem.lib.graphics.bitmap.CachedFrame;

	public class AtlasStarlingMeta implements IAtlasMeta
	{
		private var _xml:XML = <TextureAtlas/>;

		public function AtlasStarlingMeta()
		{
		}

		public function set textureFileName(value:String):void
		{
			_xml.@imagePath = value;
		}

		public function writeFrameAttr(frame:CachedFrame, coords:Rectangle, name:String):void
		{
			_xml.appendChild(<SubTexture
					name={name}
					x={coords.x} y={coords.y}
					width={coords.width} height={coords.height}
					frameX={-frame.offset.x} frameY={-frame.offset.y}
					frameWidth={coords.width} frameHeight={coords.height}/>);
		}

		public function get meta():String
		{
			return _xml.toXMLString();
		}

		public function get fileExt():String
		{
			return "xml";
		}

		public function setSize(width:int, height:int):void
		{
		}
	}
}
