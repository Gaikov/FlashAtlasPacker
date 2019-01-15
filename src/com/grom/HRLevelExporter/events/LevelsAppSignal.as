/**
 * Created by Roman.Gaikov on 1/11/2019
 */

package com.grom.HRLevelExporter.events
{
import flash.events.Event;

public class LevelsAppSignal extends Event
{
	public static const PUBLISH:String = "LevelsAppSignal::PUBLISH";
	public static const SAVE:String = "LevelsAppSignal::SAVE";
	public static const OPEN:String = "LevelsAppSignal::OPEN";

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
