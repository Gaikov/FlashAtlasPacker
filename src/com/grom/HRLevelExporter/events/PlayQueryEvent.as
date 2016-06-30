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

import com.grom.cqrs.domain.event.BaseEvent;

public class PlayQueryEvent implements BaseEvent
{
	private var _levelModel:LevelModel;

	public function PlayQueryEvent(levelModel:LevelModel)
	{
		_levelModel = levelModel;
	}

	public function get levelModel():LevelModel
	{
		return _levelModel;
	}
}
}
