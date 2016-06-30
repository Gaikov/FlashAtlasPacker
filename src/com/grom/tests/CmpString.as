/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 15.01.14
 * Time: 22:24
 * To change this template use File | Settings | File Templates.
 */
package com.grom.tests
{
import flash.display.Sprite;

public class CmpString extends Sprite
{
	public function CmpString()
	{
		var s1:String = "abc122";
		var s2:String = "abc123";

		if (s1 > s2)
		{
			trace("greater");
		}
		else if (s1 < s2)
		{
			trace("lesss");
		}
		else
		{
			trace("equal");
		}


	}
}
}
