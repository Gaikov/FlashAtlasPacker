/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 01.03.13
 */
package com.grom.flashAtlasPacker.complex
{
import flash.display.DisplayObject;

public class ButtonExporter implements ILayoutExporter
{
	public function ButtonExporter()
	{
	}

	public function build(obj:DisplayObject):XML
	{
		return DefaultLayoutExporter.getLayout(obj, "button");
	}
}
}
