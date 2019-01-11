/**
 * Created by Ilya.Klinduhov on 05.01.2017.
 */
package com.grom.HRLevelExporter.views.menu.base
{
import com.grom.lib.debug.Log;

import flash.display.NativeMenu;
import flash.display.NativeMenuItem;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.utils.getQualifiedClassName;

public class MenuBase implements IMenu
{
	[Inject]
	public var dispatcher:IEventDispatcher;

	protected var _menu:NativeMenu;

	final public function init():void
	{
		createMenu();
		initialize();
	}

	protected function initialize():void
	{
	}

	private function createMenu():void
	{
		_menu = new NativeMenu();
	}

	final public function getMenu():NativeMenu
	{
		return _menu;
	}

	final protected function addMenuItem(label:String, handler:Function = null):NativeMenuItem
	{
		var item:NativeMenuItem = new NativeMenuItem(label);
		item.name = label;
		if (handler != null)
		{
			var self:MenuBase = this;
			item.addEventListener(Event.SELECT, function (e:Event):void
			{
				var className:String = getQualifiedClassName(self);
				var info:String = "menu: " + className + "->" + item.name;
				Log.info(info);
				handler();
			});
		}
		_menu.addItem(item);
		return item;
	}

	final protected function addSeparator():NativeMenuItem
	{
		var item:NativeMenuItem = new NativeMenuItem("", true);
		_menu.addItem(item);
		return item;
	}
}
}
