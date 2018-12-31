package com.grom.HRLevelExporter.views.levels
{
import com.grom.HRLevelExporter.events.PlayLevelSignal;

import flash.events.MouseEvent;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LevelItemMediator extends Mediator
{
	[Inject]
	public var view:LevelItemRenderer;

	override public function initialize():void
	{
		super.initialize();

		view.buttonPlay.addEventListener(MouseEvent.CLICK, onClickPlay);
	}

	override public function destroy():void
	{
		view.buttonPlay.removeEventListener(MouseEvent.CLICK, onClickPlay);

		super.destroy();
	}

	private function onClickPlay(event:MouseEvent):void
	{
		dispatch(new PlayLevelSignal(view.model));
	}
}
}
