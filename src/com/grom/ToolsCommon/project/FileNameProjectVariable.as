/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 12.12.13
 * Time: 17:33
 * To change this template use File | Settings | File Templates.
 */
package com.grom.ToolsCommon.project
{
import com.grom.flashAtlasPacker.utils.Utils;

import flash.filesystem.File;

public class FileNameProjectVariable extends StringProjectVariable
{
	public function FileNameProjectVariable(nodeName:String)
	{
		super(nodeName, null);
	}

	override public function makeXML(projectFile:File):XML
	{
		validate();
		return <{nodeName}>{Utils.getRelativePath(value, projectFile)}</{nodeName}>;
	}

	override public function readXML(source:XML, projectFile:File):Boolean
	{
		var fileName:String = String(source);
		value = Utils.resolvePath(fileName, projectFile);
		validate();
		return true;
	}
}
}
