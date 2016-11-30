/**
 * Created by roman.gaikov on 11/29/2016.
 */
package com.grom.FlashFontsExporter.mapping
{
import com.grom.FlashFontsExporter.FlashFontsModel;

import flash.events.Event;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SelectedFontMediator extends Mediator
{
	[Inject]
	public var view:SelectedFontRenderer;
	
	[Inject]
	public var project:FlashFontsModel;
	
	public function SelectedFontMediator()
	{
	}

	override public function initialize():void
	{
		super.initialize();
		
		view.checkSelected.addEventListener(Event.CHANGE, function ():void
		{
			view._data.selected = view.checkSelected.selected;
			project.selectedFontsList.modified = true;
		});
		
		view.inputFileName.addEventListener(Event.CHANGE, function ():void
		{
			view._data.exportFileName = view.inputFileName.text;
			project.selectedFontsList.modified = true;
		});
	}
	
}
}
