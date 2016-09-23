/**
 * Created by roman.gaikov on 9/23/2016.
 */
package com.grom.flashAtlasPacker.fonts
{
internal class FontDesc
{
	public var name:String;
	public var family:String;
	public var size:int;
	public var color:uint;
	public var filters:Array;

	public function FontDesc(name:String, family:String, size:int, color:uint, filters:Array)
	{
		this.name = name;
		this.family = family;
		this.size = size;
		this.color = color;
		this.filters = filters;
	}
}
}
