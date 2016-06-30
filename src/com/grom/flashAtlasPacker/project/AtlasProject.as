/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 03.06.13
 */
package com.grom.flashAtlasPacker.project
{
import com.grom.ToolsCommon.swf.SWFUtils;
import com.grom.flashAtlasPacker.Utils;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

import mx.collections.ArrayList;

import com.grom.lib.debug.Log;

public class AtlasProject extends EventDispatcher
{
	private var _modified:Boolean = false;

	private var _lastSWF:String;
	private var _selectedNames:Vector.<Object> = new Vector.<Object>();
	private var _outputPath:String;

	private var _swfClassNames:ArrayList;
	private var _swfClassesMap:Object;

	private var _particlesList:ArrayList = new ArrayList();

	public function AtlasProject()
	{
	}

	[Bindable]
	public function get modified():Boolean
	{
		return _modified;
	}

	public function set modified(value:Boolean):void
	{
		_modified = value;
	}

	[Bindable]
	public function get lastSWF():String
	{
		return _lastSWF;
	}

	public function get particlesList():ArrayList
	{
		return _particlesList;
	}

	public function set lastSWF(value:String):void
	{
		if (_lastSWF != value && value)
		{
			updateSWF(value, null);
		}
	}

	private function updateSWF(value:String, onClassesLoaded:Function):void
	{
		_lastSWF = value;
		var bytes:ByteArray = Utils.readFile(new File(value));
		if (!bytes)
		{
			_lastSWF = null;
			return;
		}

		_swfClassNames = new ArrayList(SWFUtils.getClassNames(bytes));
		modified = true;
		loadClasses(bytes, onClassesLoaded);
	}

	private function loadClasses(bytes:ByteArray, onClassesLoaded:Function):void
	{
		SWFUtils.loadClasses(bytes, function(map:Object):void
		{
			_swfClassesMap = map;
			dispatchEvent(new Event("ClassesLoadedEvent"));
			dispatchEvent(new Event("SelectedChangedEvent"));

			if (onClassesLoaded != null)
			{
				onClassesLoaded();
			}
		});
	}

	[Bindable(event="ClassesLoadedEvent")]
	public function get swfClassNames():ArrayList
	{
		return _swfClassNames;
	}

	[Bindable]
	public function get outputPath():String
	{
		return _outputPath;
	}

	public function set outputPath(value:String):void
	{
		_outputPath = value;
		modified = true;
	}

	[Bindable(event="SelectedChangedEvent")]
	public function get selectedNames():Vector.<Object>
	{
		return _selectedNames;
	}

	public function set selectedNames(value:Vector.<Object>):void
	{
		_selectedNames = value;
		modified = true;
	}

	public function get selectedClasses():Vector.<Class>
	{
		var res:Vector.<Class> = new Vector.<Class>();
		for each (var name:String in _selectedNames)
		{
			res.push(_swfClassesMap[name]);
		}
		return res;
	}

	public function write(file:File):void
	{
		Log.info("write project: ", file.nativePath);

		var xml:XML = <project>
			<last_swf>{Utils.getRelativePath(_lastSWF, file)}</last_swf>
			<output>{Utils.getRelativePath(_outputPath, file)}</output>
		</project>;

		var classesNode:XML = <selected_classes></selected_classes>;
		xml.appendChild(classesNode);

		for each (var className:String in _selectedNames)
		{
			classesNode.appendChild(<class>{className}</class>);
		}

		var particles:XML = <particles></particles>;
		xml.appendChild(particles);

		for each (var p:ParticlesModel in _particlesList.source)
		{
			particles.appendChild(
					<effect>
						<file>{Utils.getRelativePath(p._fileName, file)}</file>
						<class>{p.className}</class>
					</effect>);
		}

		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.WRITE);
		stream.writeUTFBytes(xml.toXMLString());
		stream.close();

		modified = false;
	}

	public function read(file:File):void
	{
		var bytes:ByteArray = Utils.readFile(file);
		if (!bytes)
		{
			return;
		}
		var xml:XML = new XML(bytes.readUTFBytes(bytes.bytesAvailable));

		_particlesList = new ArrayList();

		updateSWF(Utils.resolvePath(String(xml.last_swf), file), function():void
		{

			for each (node in xml.particles.effect)
			{
				var p:ParticlesModel = new ParticlesModel();
				p._fileName = Utils.resolvePath(String(node.file), file);
				p._particleClass = _swfClassesMap[String(node["class"])] as Class;
				_particlesList.addItem(p);
			}
		});
		_outputPath = Utils.resolvePath(String(xml.output), file);

		_selectedNames = new Vector.<Object>();
		for each (var node:XML in xml.selected_classes["class"])
		{
			_selectedNames.push(String(node));
		}

		modified = false;
		Log.info("...project loaded: ", file.nativePath);
	}

	public function getClass(name:String):Class
	{
		return _swfClassesMap[name];
	}
}
}
