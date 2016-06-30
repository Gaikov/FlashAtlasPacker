/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 24.09.13
 */
package com.grom.flashAtlasPacker.log
{
import com.grom.lib.debug.ILogAdapter;

import spark.components.TextArea;

public class LogAreaAdapter implements ILogAdapter
{
	private var _textArea:TextArea;


	public function LogAreaAdapter(textArea:TextArea)
	{
		_textArea = textArea;
	}

	public function print(msg:String, color:uint):void
	{
		_textArea.appendText(msg + "\n");
	}
}
}
