/**
 * Created by Roman.Gaikov on 1/11/2019
 */

package com.grom.HRLevelExporter.events
{
import flash.events.Event;

public class LevelsAppEvent extends Event
{
	public function LevelsAppEvent(type:String)
	{
		super(type, bubbles, cancelable);
	}

	override public function clone():Event
	{
		return new LevelsAppEvent(type);
	}
}
}
