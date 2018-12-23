package com.grom.HRLevelExporter
{
import com.grom.HRLevelExporter.views.LevelItemMediator;
import com.grom.HRLevelExporter.views.LevelItemRenderer;

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
	}
}
}
