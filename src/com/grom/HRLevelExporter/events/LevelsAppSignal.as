/**
 * Created by Roman.Gaikov on 1/11/2019
 */

package com.grom.HRLevelExporter.events
{
import flash.events.Event;

public class LevelsAppSignal extends Event
{
	public static const PUBLISH:String = "AppSignal::PUBLISH";

	public function LevelsAppSignal(type:String)
	{
		super(type, bubbles, cancelable);
	}

	override public function clone():Event
	{
		return new LevelsAppSignal(type);
	}
}
}
