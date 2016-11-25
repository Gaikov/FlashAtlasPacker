/**
 * Created by roman.gaikov on 11/24/2016.
 */
package com.grom.FlashFontsExporter.mapping
{
[Bindable]
public class SelectedFont
{
	public var exportFileName:String;
	public var id:String;
	public var selected:Boolean;

	public function SelectedFont(fileName:String, id:String)
	{
		this.exportFileName = fileName;
		this.id = id;
	}
}
}
