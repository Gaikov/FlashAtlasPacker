package com.grom.HRLevelExporter.views.menu
{
import com.grom.HRLevelExporter.views.menu.base.MenuBase;

public class MenuFile extends MenuBase
{
	public function MenuFile()
	{
	}

	override protected function initialize():void
	{
		super.initialize();
		addMenuItem("Exit");
	}
}
}
