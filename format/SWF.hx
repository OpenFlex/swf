package format;


import flash.display.BitmapData;
import flash.display.SimpleButton;
import flash.utils.ByteArray;
import format.swf.instance.MovieClip;
import format.swf.SWFRoot;
import format.swf.SWFTimelineContainer;
import format.swf.tags.TagDefineBitsLossless;
import format.swf.tags.TagDefineSprite;
import format.swf.tags.TagSymbolClass;


class SWF {
	
	
	public var data:SWFRoot;
	public static var instances:Hash <SWF> = new Hash <SWF> ();
	
	public var backgroundColor (default, null):Int;
	public var frameRate (default, null):Float;
	public var height (default, null):Int;
	public var symbols:Hash <Int>;
	public var width (default, null):Int;
	
	
	public function new (bytes:ByteArray) {
		
		//SWFTimelineContainer.AUTOBUILD_LAYERS = true;
		data = new SWFRoot (bytes);
		
		backgroundColor = data.backgroundColor;
		frameRate = data.frameRate;
		width = Std.int (data.frameSize.rect.width);
		height = Std.int (data.frameSize.rect.height);
		
		symbols = new Hash <Int> ();
		
		for (tag in data.tags) {
			
			if (Std.is (tag, TagSymbolClass)) {
				
				for (symbol in cast (tag, TagSymbolClass).symbols) {
					
					symbols.set (symbol.name, symbol.tagId);
					
				}
				
			}
			
		}
		
	}
	
	
	public function createButton (className:String):SimpleButton {
		
		var id = symbols.get (className);
		/*
		switch (getSymbol (id)) {
			
			case buttonSymbol (data):
				
				var b = new SimpleButton ();
				data.apply (b);
				return b;
			
			default:
				
				return null;
			
		}
		*/
		return null;
		
	}
	
	
	public function createMovieClip (className:String = ""):MovieClip {
		
		var symbol:Dynamic = null;
		
		if (className == "") {
			
			symbol = data;
			
		} else {
			
			if (symbols.exists (className)) {
				
				symbol = data.getCharacter (symbols.get (className));
				
			}
			
		}
		
		if (Std.is (symbol, SWFTimelineContainer)) {
			
			return new MovieClip (cast symbol);
			
		}
		
		return null;
		
	}
	
	
	public function getBitmapData (className:String):BitmapData {
		
		if (!symbols.exists (className)) {
			
			return null;
			
		}
		/*
		switch (getSymbol (symbols.get (className))) {
			
			case bitmapSymbol (bitmap):
				
				return bitmap.bitmapData;
			
			default:
				
				return null;
			
		}
		*/
		return null;
		
	}
	
	
	public function hasSymbol (id:Int):Bool {
		
		return false;
		//return streamPositions.exists (id);
		
	}
	
	
}