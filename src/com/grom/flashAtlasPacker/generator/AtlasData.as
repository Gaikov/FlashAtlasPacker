/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 28.02.13
 */
package com.grom.flashAtlasPacker.generator
{
import com.grom.flashAtlasPacker.utils.Utils;
import com.grom.flashAtlasPacker.generator.atlasMeta.IAtlasMeta;

	import flash.display.BitmapData;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import mx.graphics.codec.PNGEncoder;

import com.grom.lib.graphics.bitmap.CachedFrame;

/*
 *
 *
 *  <TextureAtlas imagePath='atlas.png'>
 <SubTexture name='texture_1' x='0'  y='0' width='50' height='50'/>
 <SubTexture name='texture_2' x='50' y='0' width='20' height='30'/>
 </TextureAtlas>

 If your images have transparent areas at their edges, you can make use of the frame property of the Texture class. Trim the texture by removing the transparent edges and specify the original texture size like this:
 <SubTexture name='trimmed' x='0' y='0' height='10' width='10'
 frameX='-10' frameY='-10' frameWidth='30' frameHeight='30'/>
 * */

public class AtlasData
{
	private var _bitmapData:BitmapData;
	private var _meta:IAtlasMeta;

	public function AtlasData(textureWidth:int, textureHeight:int, meta:IAtlasMeta)
	{
		_meta = meta;
		_meta.setSize(textureWidth, textureHeight);
		_bitmapData = new BitmapData(textureWidth, textureHeight, true, 0x00000000);
	}

	public function get bitmapData():BitmapData
	{
		return _bitmapData;
	}

	public function renderFrame(frame:CachedFrame, rect:Rectangle, name:String):void
	{
		var m:Matrix = new Matrix();
		m.translate(rect.left, rect.top);
		_bitmapData.draw(frame.bitmapData, m);
		_meta.writeFrameAttr(frame, rect, name);
	}

	public function write(folder:File, fileName:String):void
	{
		var textureFileName:String = fileName + ".png";

		_meta.textureFileName = textureFileName;
		var xmlFile:File = folder.resolvePath("atlases/" + fileName + "." + _meta.fileExt);
		var stream:FileStream = new FileStream();
		stream.open(xmlFile, FileMode.WRITE);
		stream.writeUTFBytes(_meta.meta);
		stream.close();

		var imageFile:File = folder.resolvePath("atlases/" + textureFileName);
		Utils.savePng(imageFile, _bitmapData);
	}
}
}
