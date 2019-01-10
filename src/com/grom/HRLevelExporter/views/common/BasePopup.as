/**
 * Created by Roman.Gaikov on 1/10/2019
 */

package com.grom.HRLevelExporter.views.common
{

import mx.events.CloseEvent;
import mx.managers.PopUpManager;

import spark.components.TitleWindow;

public class BasePopup extends TitleWindow
{
	public function BasePopup()
	{
		addEventListener(CloseEvent.CLOSE, onClose);
	}

	protected function onClose(event:CloseEvent):void
	{
		close();
	}

	protected function close():void
	{
		PopUpManager.removePopUp(this);
	}
}
}
