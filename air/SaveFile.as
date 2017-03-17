package com.wsascb.air
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class SaveFile extends EventDispatcher
	{
		private var file:File;
		private var fileStr:FileStream;
		private var fileData:ByteArray;
		private var fileName:String;
		public static var CLOSE:String = "SaveFile.eClose";
		public static var COMPLETE:String = "SaveFile.eComplete";
		public static var ERROR:String = "SaveFile.eError";
		public function SaveFile(data:ByteArray,namePath:String)
		{
			fileData=data;
			fileName=namePath;
			file = File.desktopDirectory;
			file = file.resolvePath(fileName);
			fileStr=new FileStream();
			fileStr.openAsync(file, FileMode.WRITE);
			fileStr.writeBytes(fileData);
			fileStr.addEventListener(IOErrorEvent.IO_ERROR,eError);
			fileStr.addEventListener(Event.CLOSE,eClose);
			fileStr.addEventListener(Event.COMPLETE,eComplete);
		}
		private function eError(evt:IOErrorEvent):void
		{
			dispatchEvent(new Event(SaveFile.ERROR));
		}
		private function eClose(evt:Event):void
		{
			dispatchEvent(new Event(SaveFile.CLOSE));
		}
		private function eComplete(evt:Event):void
		{
			dispatchEvent(new Event(SaveFile.COMPLETE));
		}
	}
}