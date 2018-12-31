/**
 * Created by Ilya.Klinduhov on 05.01.2017.
 */
package com.grom.HRLevelExporter.views.menu.base
{
	import flash.display.NativeMenu;

	public interface IMenu
	{
		function init():void;
		function getMenu():NativeMenu;
	}
}
