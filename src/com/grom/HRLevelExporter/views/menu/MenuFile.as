package com.grom.HRLevelExporter.views.menu
{
import com.grom.HRLevelExporter.events.LevelsAppSignal;
import com.grom.HRLevelExporter.project.LevelProject;
import com.grom.HRLevelExporter.views.menu.base.MenuBase;
import com.grom.HRLevelExporter.views.settings.SettingsPopup;

import flash.desktop.NativeApplication;

public class MenuFile extends MenuBase
{
	static public const EXIT:String = "Exit";
	static public const SETTINGS:String = "Settings";
	static public const PUBLISH:String = "Publish";
	static public const NEW_PROJECT:String = "New Project";
	static public const OPEN:String = "Open Project";
	public static const SAVE:String = "Save Project";

	[Inject]
	public var project:LevelProject;

	public function MenuFile()
	{
	}

	override protected function initialize():void
	{
		super.initialize();

		addMenuItem(NEW_PROJECT, function ():void
		{
			project.fileName = null;
			project.newProject();
		});

		addMenuItem(OPEN, function ():void
		{
			dispatcher.dispatchEvent(new LevelsAppSignal(LevelsAppSignal.OPEN));
		}).keyEquivalent = "o";

		addMenuItem(SAVE, function ():void
		{
			dispatcher.dispatchEvent(new LevelsAppSignal(LevelsAppSignal.SAVE));
		}).keyEquivalent = "s";

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
