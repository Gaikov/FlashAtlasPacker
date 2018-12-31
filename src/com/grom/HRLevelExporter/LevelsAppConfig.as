package com.grom.HRLevelExporter
{
import com.grom.HRLevelExporter.views.levels.LevelItemMediator;
import com.grom.HRLevelExporter.views.levels.LevelItemRenderer;
import com.grom.HRLevelExporter.views.menu.AppMenu;

import flash.display.Stage;

import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

public class LevelsAppConfig implements IConfig
{
	[Inject]
	public var injector:IInjector;

	[Inject]
	public var mediatorMap:IMediatorMap;

	[Inject]
	public var commandMap:IEventCommandMap;

	[Inject]
	public var contextView:ContextView;

	public function LevelsAppConfig()
	{
	}

	public function configure():void
	{
		mediatorMap.map(FlashLevelExporter).toMediator(FlashLevelMediator);
		mediatorMap.map(LevelItemRenderer).toMediator(LevelItemMediator);

		injector.map(Stage).toValue(contextView.view.stage);

		injector.map(AppMenu).toValue(injector.instantiateUnmapped(AppMenu));
	}
}
}
