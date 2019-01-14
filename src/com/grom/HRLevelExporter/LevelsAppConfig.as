package com.grom.HRLevelExporter
{
import com.grom.HRLevelExporter.commands.PublishLevelsCommand;
import com.grom.HRLevelExporter.commands.RunLevelCommand;
import com.grom.HRLevelExporter.events.LevelsAppSignal;
import com.grom.HRLevelExporter.events.PlayLevelSignal;
import com.grom.HRLevelExporter.project.LevelProject;
import com.grom.HRLevelExporter.views.levels.LevelItemMediator;
import com.grom.HRLevelExporter.views.levels.LevelItemRenderer;
import com.grom.HRLevelExporter.views.menu.AppMenu;
import com.grom.HRLevelExporter.views.settings.SettingsMediator;
import com.grom.HRLevelExporter.views.settings.SettingsPopup;

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
		mediatorMap.map(SettingsPopup).toMediator(SettingsMediator);

		injector.map(LevelProject).asSingleton();
		injector.map(Stage).toValue(contextView.view.stage);
		injector.map(AppMenu).toValue(injector.instantiateUnmapped(AppMenu));

		commandMap.map(LevelsAppSignal.PUBLISH, LevelsAppSignal).toCommand(PublishLevelsCommand);
		commandMap.map(PlayLevelSignal.PLAY_LEVEL_SIGNAL, PlayLevelSignal).toCommand(RunLevelCommand);
	}
}
}
