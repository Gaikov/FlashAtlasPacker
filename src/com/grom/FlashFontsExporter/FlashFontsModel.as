/**
 * Created by roman.gaikov on 11/18/2016.
 */
package com.grom.FlashFontsExporter
{
import com.grom.ToolsCommon.project.BaseProject;
import com.grom.ToolsCommon.project.FileNameProjectVariable;
import com.grom.ToolsCommon.project.StringProjectVariable;
import com.grom.lib.settings.UserVar;

public class FlashFontsModel extends BaseProject
{
	private var _swfPath:FileNameProjectVariable = new FileNameProjectVariable("swf_path");
	private var _fontScale:StringProjectVariable = new StringProjectVariable("font_scale", "1");
	private var _bmFontExec:UserVar = new UserVar("bm_font_exec", "");
	//private var _fontsTextureSize:StringProjectVariable = new StringProjectVariable("font_texture_size", "1");
	private var _outputPath:StringProjectVariable = new FileNameProjectVariable("output_path");


	public function FlashFontsModel()
	{
		registerProjectVariable(_swfPath);
		registerProjectVariable(_fontScale);
		//registerProjectVariable(_fontsTextureSize);
		registerProjectVariable(_outputPath);
	}
	[Bindable]
	public function get bmFontExec():String
	{
		return _bmFontExec.value;
	}

	public function set bmFontExec(value:String):void
	{
		_bmFontExec.value = value;
	}

	[Bindable]
	public function get swfPath():String
	{
		return _swfPath.value;
	}

	public function set swfPath(value:String):void
	{
		_swfPath.value = value;
	}

	[Bindable]
	public function get fontScale():Number
	{
		return _fontScale.value;
	}

	public function set fontScale(value:Number):void
	{
		_fontScale.value = value;
	}

	[Bindable]
	public function get outputPath():String
	{
		return _outputPath.value;
	}

	public function set outputPath(value:String):void
	{
		_outputPath.value = value;
	}
}
}
