/**
 * Created by Roman.Gaikov on 1/10/2019
 */

package com.grom.HRLevelExporter.views.settings
{
import robotlegs.bender.bundles.mvcs.Mediator;

public class SettingsMediator extends Mediator
{
	[Inject]
	public var view:SettingsPopup;

	public function SettingsMediator()
	{
	}

	override public function initialize():void
	{
		super.initialize();
	}
}
}
