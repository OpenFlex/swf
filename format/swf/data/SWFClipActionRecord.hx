﻿package format.swf.data;

import format.swf.SWFData;
import format.swf.data.actions.IAction;
import format.swf.utils.StringUtils;

class SWFClipActionRecord
{
	public var eventFlags:SWFClipEventFlags;
	public var keyCode:Int;
	
	public var actions(default, null):Array<IAction>;
	
	public function new(data:SWFData = null, version:Int = 0) {
		actions = new Array <IAction>();
		if (data != null) {
			parse(data, version);
		}
	}
	
	public function parse(data:SWFData, version:Int):Void {
		eventFlags = data.readCLIPEVENTFLAGS(version);
		data.readUI32(); // actionRecordSize, not needed here
		if (eventFlags.keyPressEvent) {
			keyCode = data.readUI8();
		}
		var action:IAction;
		while ((action = data.readACTIONRECORD()) != null) {
			actions.push(action);
		}
	}
	
	public function publish(data:SWFData, version:Int):Void {
		data.writeCLIPEVENTFLAGS(eventFlags, version);
		var actionBlock:SWFData = new SWFData();
		if (eventFlags.keyPressEvent) {
			actionBlock.writeUI8(keyCode);
		}
		for(i in 0...actions.length) {
			actionBlock.writeACTIONRECORD(actions[i]);
		}
		actionBlock.writeUI8(0);
		data.writeUI32(actionBlock.length); // actionRecordSize
		data.writeBytes(actionBlock);
	}
	
	public function toString(indent:Int = 0):String {
		var str:String = "ClipActionRecords (" + eventFlags.toString() + "):";
		if (keyCode > 0) {
			str += ", KeyCode: " + keyCode;
		}
		str += ":";
		for (i in 0...actions.length) {
			str += "\n" + StringUtils.repeat(indent + 2) + "[" + i + "] " + actions[i].toString(indent + 2);
		}
		return str;
	}
}