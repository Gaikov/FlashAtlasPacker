/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 13.12.13
 * Time: 16:21
 * To change this template use File | Settings | File Templates.
 */
package com.grom.HRLevelExporter.model
{
[Bindable]
public class LevelModel
{
	public var _levelClass:String;
	public var _levelDifficult:int = 0;

	public function LevelModel(levelClass:String, levelDifficult:int = 1)
	{
		_levelClass = levelClass;
		_levelDifficult = levelDifficult;
	}
}
}
