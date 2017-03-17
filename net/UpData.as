package com.wsascb.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	public class UpData extends EventDispatcher
	{
		private var req:URLRequest;
		private var loader:URLLoader;
		private var jpgArr:Array;
		private var jpgLg:Number = 0;
		private var ws_url:String;
		private var dat:Object;
		private var method:String;
		private var _retData:Object;
		public static var COMPLETE:String = "complete";
		public static var ERROR:String = "error";
		public function UpData(_url:String,_dat:Object,_method:String="POST")
		{
			ws_url=_url;
			dat=_dat;
			method=_method;
			updata();
		}
		private function updata():void
		{
			req = new URLRequest(ws_url);
			req.method = method;
			req.data = dat;
			loader=new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR,error);
			loader.load(req);
		}
		private function completeHandler(evt:Event):void
		{
			_retData=loader.data;
			dispatchEvent(new Event(UpData.COMPLETE));
		}
		private function error(evt:IOErrorEvent):void
		{
			dispatchEvent(new Event(UpData.ERROR));
		}

		public function get retData():Object
		{
			return _retData;
		}

	}
}