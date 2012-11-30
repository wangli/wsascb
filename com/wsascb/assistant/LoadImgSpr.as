package com.wsascb.assistant
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;

	public class LoadImgSpr extends EventDispatcher
	{
		private var ws_spr:Sprite;
		private var ws_url:String;
		private var allTotal:Number = 0;
		private var ws_sprArr:Array=new Array();//加载文件
		private var allUrl:Array=new Array();
		private var ldrArr:Array=new Array();

		public var nowSub:Number = 0;//当期加载位置
		public var allNum:Number = 0;//加载总数
		public var ws_loadBo:Boolean = false;
		public var ws_percent:Number;//当前文件进度
		public var all_percent:Number;//总进度
		private var clearChilds:Boolean;//是否清楚需要加载项的子项所有内容
		private var starload:Boolean = false;

		public static var PROGRESSLOAD:String = "progressload";
		public static var COMPLETELOAD:String = "completeload";

		public function LoadImgSpr(spr:Sprite=null,_url:String=null)
		{
			if (_url!=null) {
				addImgSpr(spr,_url);
			}
		}
		public function addImgSpr(spr:Sprite,_url:String=null,_clearChilds:Boolean=true):void
		{
			if (_url!=null) {
				allUrl.push(_url);
				ws_sprArr.push(spr);
				allNum++;
				if (! starload) {
					loading(_url);
				}
				clearChilds = _clearChilds;
			}
		}
		public function get getSprArray():Array
		{
			return ws_sprArr;
		}
		private function loading(_url:String=null):void
		{
			if (_url!=null&&_url!="") {
				starload=true;
				ws_url = _url;
				var ws_Loader:Loader = new Loader();
				ldrArr.push(ws_Loader.contentLoaderInfo);
				ws_Loader.contentLoaderInfo.addEventListener(Event.OPEN, openHandler);
				ws_Loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				ws_Loader.contentLoaderInfo.addEventListener(Event.INIT, loader_initHandler);
				ws_Loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				var req:URLRequest = new URLRequest(_url);
				ws_Loader.load(req);
			}
		}
		private function openHandler(event:Event):void
		{
		}
		private function progressHandler(event:ProgressEvent):void
		{
			
				var _percent:Number = 0;
				for (var i:Number=0; i<allNum; i++) {
					if(ldrArr[i] is LoaderInfo){
						_percent+=(ldrArr[i] as LoaderInfo).bytesLoaded/(ldrArr[i] as LoaderInfo).bytesTotal*100;
					}
				}
				ws_percent=Math.round(_percent/allNum);
				dispatchEvent(new Event(LoadImgSpr.PROGRESSLOAD));
			
		}
		private function loader_initHandler(event:Event):void
		{
			if (event.target.content is Bitmap) {
				event.target.content.smoothing = true;
			}
		}
		private function completeHandler(event:Event):void
		{
			//删除已有子项
			/*if (clearChilds) {
			trace("nowSub:"+nowSub);
			var cdLg:Number = ws_sprArr[nowSub].numChildren;
			for (var i:Number=0; i<cdLg; i++) {
			ws_sprArr[nowSub].removeChildAt(i);
			}
			}*/
			//添加新内容
			if (ws_sprArr[nowSub]) {
				ws_sprArr[nowSub].addChild(event.target.content);
				nowSub++;
				if (nowSub<allNum) {
					loading(allUrl[nowSub]);
				} else {
					//event.target.removeEventListener(Event.COMPLETE,completeHandler);
					//event.target.removeEventListener(ProgressEvent.PROGRESS,progressHandler);
					//event.target.loader.close();
					ws_loadBo = true;
					dispatchEvent(new Event(LoadImgSpr.COMPLETELOAD));
				}
			}
		}
	}
}