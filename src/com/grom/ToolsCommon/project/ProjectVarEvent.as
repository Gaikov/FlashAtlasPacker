/**
 * Created with IntelliJ IDEA.
 * User: Roma
 * Date: 12.12.13
 * Time: 17:05
 * To change this template use File | Settings | File Templates.
 */
package com.grom.ToolsCommon.project
{
import flash.events.Event;

public class ProjectVarEvent extends Event
{
	public function ProjectVarEvent(type:String)
	{
		super(type);
	}

	override public function clone():Event
	{
		return new ProjectVarEvent(type);
	}
}
}
