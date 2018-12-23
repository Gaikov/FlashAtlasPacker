/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 03.01.14
 * Time: 21:34
 * To change this template use File | Settings | File Templates.
 */
package com.grom.HRLevelExporter.events
{
import com.grom.HRLevelExporter.model.LevelModel;

import flash.events.Event;

public class PlayLevelSignal extends Event
{
	public static const PLAY_LEVEL_SIGNAL:String = "PlayLevelSignal.PLAY_LEVEL_SIGNAL";

	private var _levelModel:LevelModel;

	public function PlayLevelSignal(levelModel:LevelModel)
	{
		super(PLAY_LEVEL_SIGNAL);
		_levelModel = levelModel;
	}

	public function get levelModel():LevelModel
	{
		return _levelModel;
	}

	override public function clone():Event
	{
		return new PlayLevelSignal(_levelModel);
	}
}
}
