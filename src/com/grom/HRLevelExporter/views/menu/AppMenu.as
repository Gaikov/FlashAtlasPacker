package com.grom.HRLevelExporter.views.menu
{
import com.grom.HRLevelExporter.views.menu.base.IMenu;

import flash.desktop.NativeApplication;
import flash.display.NativeMenu;
import flash.display.NativeMenuItem;
import flash.display.NativeWindow;
import flash.display.Stage;

import robotlegs.bender.framework.api.IInjector;

public class AppMenu
{
	static public const FILE:String = "File";

	[Inject]
	public var injector:IInjector;

	[Inject]
	public var stage:Stage;

	private var _menu:NativeMenu;


	public function AppMenu()
	{
	}

	[PostConstruct]
	public function init():void
	{
		if (NativeWindow.supportsMenu)
		{
			stage.nativeWindow.menu = _menu = new NativeMenu();
		}
		else if (NativeApplication.supportsMenu)
		{
			_menu = NativeApplication.nativeApplication.menu;
		}

		if (!_menu)
		{
			_menu = new NativeMenu();
		}

		_menu.removeAllItems();

		addItem(new MenuFile(), FILE);
	}

	private function addItem(submenu:IMenu, name:String):void
	{
		injector.injectInto(submenu);
		submenu.init();
		var item:NativeMenuItem = new NativeMenuItem(name);
		item.name = name;
		item.submenu = submenu.getMenu();
		_menu.addItem(item);
	}
}
}
