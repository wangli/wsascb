package com.wsascb.spriteTool
{

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;

	public class MLoader extends EventDispatcher
	{
		private static var instance:MLoader;
		private var _ldMc:MovieClip;
		private var _conMc:MovieClip;
		private var ldr:Loader;
		private var percent:Number;
		private var swfUrlArr:Array;
		private var swfLdrArr:Array;
		private var autoLoader:Boolean = false;
		private var nowLoaderSub:int = 0;
		private var ldrTotal:Loader;
		public static var INITLOAD:String = "initload";
		public static var INITCOMPLETE:String = "initComplete";
		public static var COMPLETELOAD:String = "completeLoad";
		public static var PROGRESSPCLOAD:String = "progressPCload";
		public function MLoader(_mc:MovieClip)
		{
			if ( instance != null )
			{
				throw new Error("只能创建一次MContent");
			}
			instance = this;
			_conMc = _mc;
		}
		public static function getInstance(_mc:MovieClip=null):MLoader
		{
			if ( instance == null )
			{
				instance = new MLoader(_mc);
			}
			else if (_mc!=null)
			{
				instance._conMc = _mc;
			}
			return instance;
		}
		public function loadNew(url:String):void
		{
			if (ldr!=null)
			{
				_conMc.removeChild(ldr);
			}
			if (ldrTotal!=null)
			{
				ldrTotal.unload();
			}
			loaderUrl(url);
		}
		//添加监听加载对象事件
		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, loadComplete);
			dispatcher.addEventListener(Event.INIT, initComplete);
			dispatcher.addEventListener(Event.OPEN, loader_openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
		}
		private function loadComplete(evt:Event):void
		{
			_ldMc = ldr.content as MovieClip;
			dispatchEvent(new Event(MLoader.COMPLETELOAD));
			autoLoadTotal(autoLoader);
		}
		private function initComplete(evt:Event):void
		{
			dispatchEvent(new Event(MLoader.INITCOMPLETE));
		}
		private function loader_openHandler(event:Event):void
		{
			dispatchEvent(new Event(MLoader.INITLOAD));
		}
		private function loader_progressHandler(event:ProgressEvent):void
		{
			percent = Math.floor(event.bytesLoaded / event.bytesTotal * 10000) / 100;
			dispatchEvent(new Event(MLoader.PROGRESSPCLOAD));
		}
		//返回当前加载的内容的百分比
		public function get getPercent():Number
		{
			return percent;
		}
		private function loaderUrl(url:String):void
		{
			ldr = new Loader();
			var request:URLRequest = new URLRequest(url);
			ldr.load(request);
			_conMc.addChild(ldr);
			configureListeners(ldr.contentLoaderInfo);
		}
		public function get ldMc():MovieClip
		{
			return _ldMc;
		}
		public function set setSwfArr(val:Array):void
		{
			swfUrlArr = val;
			swfLdrArr=new Array();
			var lg:int = swfUrlArr.length;
			for (var i:int=0; i<lg; i++)
			{
				swfLdrArr.push(0);
			}
		}
		public function set autoload(val:Boolean):void
		{
			autoLoader = val;
		}
		public function autoLoadTotal(val:Boolean=true):void
		{
			autoLoader = val;
			if (autoLoader)
			{
				var lg:int = swfLdrArr.length;
				for (var i:int=0; i<lg; i++)
				{
					if (swfLdrArr[i] == 0)
					{
						nowLoaderSub = i;
						ldrTotalUrl(swfUrlArr[i]);
						break;
					}
				}
			}
		}
		private function ldrTotalUrl(url:String):void
		{
			ldrTotal = new Loader();
			ldrTotal.load(new URLRequest(url));
			ldrTotal.contentLoaderInfo.addEventListener(Event.COMPLETE, loadTotalComplete);
		}
		private function loadTotalComplete(evt:Event):void
		{
			swfLdrArr[nowLoaderSub] = 1;
			autoLoadTotal();
		}
	}
}