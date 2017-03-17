package com.wsascb.xmlTool
{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import com.wsascb.net.*;

	public class LoadXmlDocument extends EventDispatcher
	{
		private var loader:URLLoader;
		private var percent:Number;
		private var strUrl:String;
		private var XmlDocument:XML;
		private var ws_fuc:Function;
		private var updata:UpData;
		private var loading:Boolean=true;
		public static var COMPLETE:String = "complete";
		public static var ERROR:String = "ErrorEvent";
		public function LoadXmlDocument(_strUrl:String,obj:Object=null)
		{
			strUrl = _strUrl;
			var req:URLRequest = new URLRequest(strUrl);
			req.method = URLRequestMethod.POST;
			if (obj!=null) {
				req.data = URLVariables(obj);
			}
			loader=new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE,handleComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,dataerror);
			loader.load(req);
		}
		private function updataComplete(evt:Event):void
		{
			trace(updata.retData);
		}
		private function dataerror(evt:IOErrorEvent):void
		{
			dispatchEvent(new Event(LoadXmlDocument.ERROR));
		}
		public function loadURL(_strUrl:String,obj:Object=null):void{
			if(loading){
				loader.close();
			}
			strUrl = _strUrl;
			var req:URLRequest = new URLRequest(strUrl);
			req.method = URLRequestMethod.POST;
			if (obj!=null) {
				req.data = URLVariables(obj);
			}
			loader.load(req);
			loading=true;
		}
		public function close():void{
			loader.close();
		}
		public function get getURLLoader():URLLoader
		{
			return loader;
		}
		public function get getPercent():Number
		{
			percent = Math.round(loader.bytesLoaded / loader.bytesTotal * 10000) / 100;
			return percent;
		}
		public function get getBytesLoaded():Number
		{
			return loader.bytesLoaded;
		}
		public function get getBytesTotal():Number
		{
			return loader.bytesTotal;
		}
		public function get getXML():XML
		{
			return XmlDocument;
		}
		private function handleComplete(event:Event):void
		{
			try {
				XmlDocument = new XML(event.target.data);
				dispatchEvent(new Event(LoadXmlDocument.COMPLETE));
			} catch (e:TypeError) {
				trace("创建XML错误："+e.message);
			}
			loading=false;
			loader.removeEventListener(Event.COMPLETE,handleComplete);
			loader.close();
		}
	}
}