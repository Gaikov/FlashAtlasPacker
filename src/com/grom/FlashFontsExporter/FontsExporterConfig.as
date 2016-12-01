/**
 * Created by roman.gaikov on 11/18/2016.
 */
package com.grom.FlashFontsExporter
{
import com.grom.FlashFontsExporter.mapping.SelectedFontMediator;
import com.grom.FlashFontsExporter.mapping.SelectedFontRenderer;

import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

public class FontsExporterConfig implements IConfig
{
	[Inject]
	public var injector : IInjector;

	[Inject]
	public var mediatorMap : IMediatorMap;

	[Inject]
	public var commandMap : IEventCommandMap;

	[Inject]
	public var contextView : ContextView;	
	
	public function FontsExporterConfig()
	{
	}

	public function configure():void
	{
		injector.map(FontsExporterModel).asSingleton();
		
		mediatorMap.map(BitmapFontsExporter).toMediator(BitmapFontsMediator);
		mediatorMap.map(SelectedFontRenderer).toMediator(SelectedFontMediator);
	}
}
}
