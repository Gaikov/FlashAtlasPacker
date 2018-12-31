package com.grom.HRLevelExporter.views.levels
{
import com.grom.HRLevelExporter.model.LevelModel;

import spark.components.List;

public class LevelsList extends List
{
	public function LevelsList()
	{
	}

	override protected function copyItemWithUID(item:Object):Object
	{
		var model:LevelModel = LevelModel(item);
		return model.clone();
	}
}
}
