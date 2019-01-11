package com.grom.HRLevelExporter.views.menu
{
import com.grom.HRLevelExporter.events.LevelsAppSignal;
import com.grom.HRLevelExporter.views.menu.base.MenuBase;
import com.grom.HRLevelExporter.views.settings.SettingsPopup;

import flash.desktop.NativeApplication;

public class MenuFile extends MenuBase
{
	static public const EXIT:String = "Exit";
	static public const SETTINGS:String = "Settings";
	static public const PUBLISH:String = "Publish";

	public function MenuFile()
	{
	}

	override protected function initialize():void
	{
		super.initialize();

		addMenuItem(SETTINGS, function ():void
		{
			SettingsPopup.show();
		});

		addMenuItem(PUBLISH, function ():void
		{
			dispatcher.dispatchEvent(new LevelsAppSignal(LevelsAppSignal.PUBLISH));
		}).keyEquivalent = "p";

		addSeparator();

		addMenuItem(EXIT, function ():void
		{
			NativeApplication.nativeApplication.exit();
		});
	}
}
}
