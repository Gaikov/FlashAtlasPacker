/**
 * Created by roman.gaikov on 11/18/2016.
 */
package com.grom.FlashFontsExporter
{
import com.grom.lib.debug.Log;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FlashFontsMediator extends Mediator
{
	public function FlashFontsMediator()
	{
	}


	override public function initialize():void
	{
		super.initialize();
		Log.info("app started");
	}
}
}
