/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 13.12.13
 * Time: 16:50
 * To change this template use File | Settings | File Templates.
 */
package com.grom.HRLevelExporter.model
{
import com.grom.ToolsCommon.project.ArrayListProjectVariable;

public class LevelsListProjectVariable extends ArrayListProjectVariable
{
	public function LevelsListProjectVariable(nodeName:String)
	{
		super(nodeName);
	}

	override protected function itemToXML(item:*):XML
	{
		var lm:LevelModel = item;

		return <item>
				<className>{lm._levelClass}</className>
				<difficult>{lm._levelDifficult}</difficult>
		</item>;
	}

	override protected function xmlToItem(xml:XML):*
	{
		return new LevelModel(String(xml.className[0]), int(xml.difficult[0]));
	}
}
}
