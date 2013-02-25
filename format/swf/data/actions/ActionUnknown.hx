﻿package format.swf.data.actions;

import format.swf.SWFData;

class ActionUnknown extends Action #if !haxe3 , #end implements IAction
{
	public function new(code:Int, length:Int) {
		super(code, length);
	}
	
	override public function parse(data:SWFData):Void {
		if (length > 0) {
			data.skipBytes(length);
		}
	}
	
	override public function toString(indent:Int = 0):String {
		return "[????] Code: " + StringTools.hex (code) + ", Length: " + length;
	}
}