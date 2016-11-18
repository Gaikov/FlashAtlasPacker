/**
 * Created by roman.gaikov on 9/19/2016.
 */
package com.grom.flashAtlasPacker
{
import com.grom.flashAtlasPacker.settings.SettingsPopup;
import com.grom.flashAtlasPacker.settings.SettingsPopupMediator;

import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

public class AtlasPackerConfig implements IConfig
{
	[Inject]
	public var injector : IInjector;

	[Inject]
	public var mediatorMap : IMediatorMap;

	[Inject]
	public var commandMap : IEventCommandMap;

	[Inject]
	public var contextView : ContextView;
	
	public function AtlasPackerConfig()
	{
	}

	public function configure():void
	{
		mediatorMap.map(FlashAtlasPacker).toMediator(FlashAtlasPackerMediator);
		mediatorMap.map(SettingsPopup).toMediator(SettingsPopupMediator);
	}
}
}
