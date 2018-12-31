package com.grom.HRLevelExporter.views.menu
{
import com.grom.HRLevelExporter.views.menu.base.MenuBase;

import flash.desktop.NativeApplication;

public class MenuFile extends MenuBase
{
	static public const EXIT:String = "Exit";
	static public const SETTINGS:String = "Settings";

	public function MenuFile()
	{
	}

	override protected function initialize():void
	{
		super.initialize();

		addMenuItem(SETTINGS, function ():void
		{

		});

		addSeparator();

		addMenuItem(EXIT, function ():void
		{
			NativeApplication.nativeApplication.exit();
		});
	}
}
}
