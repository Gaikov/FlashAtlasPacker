/**
 * Created by roman.gaikov on 11/18/2016.
 */
package com.grom.FlashFontsExporter
{
import robotlegs.bender.bundles.mvcs.Mediator;

public class FlashFontsMediator extends Mediator
{
	[Inject]
	public var view:FlashFontsExporter;

	[Inject]
	public var model:FlashFontsModel;

	public function FlashFontsMediator()
	{
	}

	override public function initialize():void
	{
		super.initialize();
		view._model = model;
	}
}
}
