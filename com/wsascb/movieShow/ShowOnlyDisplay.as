package com.wsascb.movieShow{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.wsascb.xmlTool.LoadXmlDocument;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.utils.*;

	public class ShowOnlyDisplay extends EventDispatcher {
		private var upMc:Sprite;//顶部对象
		private var downMc:Sprite;//底部对象
		private var mcTemp:Sprite;//交换对象时临时存储要交换的对象
		private var setMc:Sprite;//放置MC的对象
		private var leftBtn:InteractiveObject;//回滚按钮
		private var rightBtn:InteractiveObject;//前进按钮
		private var strXmlUrl:String = "photo.xml";//xml外部地址
		private var bigpicArr:Array;//所有大图片所存储再的数组
		private var smallpicArr:Array;//所有小图片所存储再的数组
		private var titleArr:Array;//所有标题
		private var linkArr:Array;//所有外部连接
		private var descArr:Array;//所有描述内容
		private var mcArr:Array;//所有放置图像的对象
		private var imgLg:Number;//所有图片数量
		private var intervalID:uint;//间隔时间事件
		private var delayTime:Number = 5200;//间隔时间
		private var mcSub:Number = 0;//初始图像位置
		private var loadState:Boolean = true;//是否允许开始加载图片
		private var aim:String = "Left";//自动播放时的方向
		private var percent:Number;//图片加载的百分比
		private var imgWidth:Number;//固定图片的宽度
		private var imgHeight:Number;//固定图片的高度
		private var exchangeMcTime:Number = 1;//切换时间
		private var exefState:String = "alpha";//切换方式
		private var exefMcSpace:Number = 0;//切换间隔距离
		private var loader:Loader;//加载服务
		private var autoplay:Boolean = true;//是否自动播放
		private var downVisible:Boolean = false;//切换后是否隐藏前一张图片
		private var zoomBound:Boolean=true;//根据制定的尺寸范围决定是否进行同比例缩放，true表示原图像尺寸超出目标范围才进行缩放，false表示无论是否超出都进行缩放
		private var zoomFill:Boolean=false;//同比例缩放的对象是否填满目标尺寸范围
		private var newLoadXML:LoadXmlDocument;//外部xml地址
		private var newXML:XML;//xml对象

		//相关的事件常量
		public static var COMPLETEXML:String = "completeXml";
		public static var CHANGEMC:String = "changeMc";
		public static var INITLOAD:String = "initload";
		public static var PROGRESSPCLOAD:String = "progressPCload";
		public static var COMPLETEPCLOAD:String = "completePCload";

		public function ShowOnlyDisplay(_mc:Sprite, str:String, strTime:Number, _leftBtn:InteractiveObject, _rightBtn:InteractiveObject, _w:Number, _h:Number):void {
			bigpicArr = new Array();
			smallpicArr = new Array();
			titleArr = new Array();
			linkArr = new Array();
			descArr = new Array();
			mcArr = new Array();
			setMc = _mc;
			strXmlUrl = str;
			if (strTime != 0) {
				delayTime = strTime;
			}
			if (_leftBtn != null) {
				leftBtn = _leftBtn;
			}
			if (_rightBtn != null) {
				rightBtn = _rightBtn;
			}
			imgWidth = _w;
			imgHeight = _h;
			upMc=new Sprite();
			upMc.name = "upMc";
			downMc=new Sprite();
			downMc.name = "downMc";
			setMc.addChild(upMc);
			setMc.addChild(downMc);
			mcTemp = downMc;
			if (strXmlUrl != "null") {
				newLoadXML = new LoadXmlDocument(strXmlUrl);
				newLoadXML.addEventListener(LoadXmlDocument.COMPLETE,init);
			}
		}
		private function init(event:Event):void {
			fillData();
		}
		public function newData(str:String,post:Object=null):void{
			clearInterval(intervalID);
			clearData();
			strXmlUrl=str;
			mcSub=0;
			newLoadXML = new LoadXmlDocument(strXmlUrl,post);
			newLoadXML.addEventListener(LoadXmlDocument.COMPLETE,init);
		}
		//填充数据
		private function fillData():void {
			newXML = newLoadXML.getXML;
			//设置翻页按钮
			setHandButton(leftBtn,rightBtn);
			//将数据导入数组
			if (strXmlUrl != "null") {
				//获取图片数量
				imgLg = newXML.item.length();
				for (var i:int = 0; i<imgLg; i++) {
					titleArr.push(newXML.item[i].title);
					smallpicArr.push(newXML.item[i].smallpic);
					bigpicArr.push(newXML.item[i].bigpic);
					linkArr.push(newXML.item[i].url);
					descArr.push(newXML.item[i].desc);
				}
			} else {
				imgLg = newXML.item.length();
			}
			//初始加载第一张图片
			dispatchEvent(new Event(ShowOnlyDisplay.COMPLETEXML));
			loadAsset(mcTemp,smallpicArr[mcSub]);
			sedIvl();
		}
		//自动播放
		public function sedIvl():void {
			if (autoplay == true) {
				intervalID = setInterval(intervalFun,delayTime);
			}
		}
		//间隔时间事件命令,自动切换资源
		private function intervalFun():void {
			//允许加载时在加载
			if (loadState == true) {
				gotoPlayMc();
			}
		}
		//手动切换到指定图片
		private function handGoto(_val:Number):void {
			if (_val > mcSub) {
				aim = "Left";
				mcSub = _val - 1;
			} else if (_val<mcSub) {
				aim = "Right";
				mcSub = _val + 1;
			} else {
				aim = "Left";
				mcSub = _val - 1;
			}
			gotoPlayMc();
		}
		//切换图片
		private function gotoPlayMc():void {
			if (aim == "Left") {
				if (mcSub < imgLg - 1) {
					mcSub++;
					exchangeMc(mcSub);
					//trace(mcSub);
				} else {
					mcSub = 0;
					exchangeMc(mcSub);
				}
			} else {
				if (mcSub > 0) {
					mcSub--;
					exchangeMc(mcSub);
					//trace(mcSub);
				} else {
					mcSub = imgLg - 1;
					exchangeMc(mcSub);
				}
			}
			dispatchEvent(new Event(ShowOnlyDisplay.CHANGEMC));
		}
		//交换并加载图像
		private function exchangeMc(_val:Number):void {
			//交换相互的深度
			setMc.swapChildren(upMc,downMc);
			var _this = this;
			if (setMc.getChildIndex(upMc) > setMc.getChildIndex(downMc)) {
				mcTemp = upMc;
				if(downVisible){
					TweenLite.to(downMc, exchangeMcTime, {alpha:0, ease:Expo.easeOut,onComplete:function onFinishTween(){
						if ("downMc" != _this.mcTemp.name) {
							_this.downMc.visible = false;
						} 
					}});
				}
			} else {
				mcTemp = downMc;
				if(downVisible){
					TweenLite.to(upMc, exchangeMcTime, {alpha:0, ease:Expo.easeOut,onComplete:function onFinishTween(){
						if ("upMc" != _this.mcTemp.name) {
							_this.upMc.visible = false;
						} 
					}});
				}
			}
			mcTemp.visible = true;
			mcTemp.alpha = 1;
			//初始化图像相关属性
			switch (this.exefState) {
				case "alpha" :
					mcTemp.alpha = 0;
					break;
				case "moveLeft" :
					mcTemp.x =  -  mcTemp.width;
					break;
				case "moveRight" :
					mcTemp.x = mcTemp.width;
					break;
				case "moveTop" :
					mcTemp.y =  -  mcTemp.height;
					break;
				case "moveBottom" :
					mcTemp.y = mcTemp.height;
					break;
				case "RollMoveLeft" :
					mcTemp.x =  -  mcTemp.width - exefMcSpace;
					break;
				case "RollMoveRight" :
					mcTemp.x = mcTemp.width + exefMcSpace;
					break;
				case "RollMoveTop" :
					mcTemp.y =  -  mcTemp.height - exefMcSpace;
					break;
				case "RollMoveBottom" :
					mcTemp.y = mcTemp.height + exefMcSpace;
					break;
				case "zoom" :
					mcTemp.alpha = 0;
					break;

			}
			//加载图片到深度高的对象 
			loadAsset(mcTemp,smallpicArr[_val]);
		}
		//替换复制数据
		public function setDataArr(_bigpicArr:Array, _smallpicArr:Array, titArr:Array, urlArr:Array):void {
			bigpicArr = _bigpicArr;
			smallpicArr = _smallpicArr;
			titleArr = titArr;
			linkArr = urlArr;
			fillData();
		}
		//设置尺寸
		public function imageSize(_w:Number, _h:Number):void {
			imgWidth = _w;
			imgHeight = _h;
			if (mcTemp.width > 0) {
				setImageSize(mcTemp);
			}
		}
		//设置按钮动作
		private function setHandButton(up_btn:InteractiveObject, down_btn:InteractiveObject):void {
			if (up_btn != null) {
				up_btn.addEventListener(MouseEvent.MOUSE_OVER,up_btnOver);
				up_btn.addEventListener(MouseEvent.MOUSE_OUT,up_btnOut);
				up_btn.addEventListener(MouseEvent.MOUSE_DOWN,up_btnDown);
			}
			if (down_btn != null) {
				down_btn.addEventListener(MouseEvent.MOUSE_OVER,down_btnOver);
				down_btn.addEventListener(MouseEvent.MOUSE_OUT,down_btnOut);
				down_btn.addEventListener(MouseEvent.MOUSE_DOWN,down_btnDown);
			}
		}
		//-----------------------------------------------------------------------------------
		//加载资源
		private function loadAsset(_mc:Sprite, _val:String):void {
			//设置加载状态
			loadState = false;
			dispatchEvent(new Event(ShowOnlyDisplay.INITLOAD));
			//删除已有加载对象，并建立新加载对象
			if (_mc.numChildren > 0) {
				_mc.removeChildAt(0);
			}
			loader = new Loader();
			var request:URLRequest = new URLRequest(_val);
			loader.load(request);
			_mc.addChild(loader);
			configureListeners(loader.contentLoaderInfo);
		}
		//添加监听加载对象事件
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, loader_completeHandler);
			dispatcher.addEventListener(Event.INIT, loader_initHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
			dispatcher.addEventListener(Event.OPEN, loader_openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
		}
		private function loader_completeHandler(event:Event):void {
			loadState = true;
			dispatchEvent(new Event(ShowOnlyDisplay.COMPLETEPCLOAD));
		}
		private function loader_initHandler(event:Event):void {
			if (event.target.content is Bitmap) {
				event.target.content.smoothing = true;
			}
			//重新初始化对象原始尺寸
			mcTemp.width=event.currentTarget.content.width;
			mcTemp.height=event.currentTarget.content.height;
			//切换效果
			exchangeEffect(mcTemp,exefState);
		}
		private function loader_ioErrorHandler(event:IOErrorEvent):void {
			trace("加载图片失败:");
		}
		private function loader_openHandler(event:Event):void {
			//"在加载操作开始时调度
		}
		private function loader_progressHandler(event:ProgressEvent):void {
			percent = Math.floor(event.bytesLoaded / event.bytesTotal * 10000) / 100;
			dispatchEvent(new Event(ShowOnlyDisplay.PROGRESSPCLOAD));
		}
		//设置尺寸-------------------------------------------------------------------------------------
		private function setImageSize(_mc:DisplayObject):void {
			if (imgWidth != 0 || imgHeight != 0) {
				if(zoomBound){
					if(!zoomFill&&(_mc.height>imgWidth||_mc.height>imgHeight)){
						var _bfb_w:Number = imgWidth / _mc.width;
						var _bfb_h:Number = imgHeight / _mc.height;
						if(_bfb_w<_bfb_h){
							sizeDisplayObject(imgWidth,0,_mc)
						}else{
							sizeDisplayObject(0,imgHeight,_mc)
						}
					}
				}else{
					sizeDisplayObject(imgWidth,imgHeight,_mc);
				}
			}
		}
		//缩放对象
		private function sizeDisplayObject(mcWidth:Number,mcHeight:Number,_mc:DisplayObject):void{
			var _bfb_w:Number = mcWidth / _mc.width;
			var _bfb_h:Number = mcHeight / _mc.height;
			if(mcWidth==0){
				_mc.height=mcHeight;
				_mc.width=_mc.width*_bfb_h;
			}else if(mcHeight==0){
				_mc.width=mcWidth;
				_mc.height=_mc.height*_bfb_w;
			}else{
				//是否填满
				if(zoomFill){
					if (_bfb_w > _bfb_h) {
						_mc.width = mcWidth;
						_mc.height = _mc.height * _bfb_w;
					} else {
						_mc.height = mcHeight;
						_mc.width = _mc.width * _bfb_h;
					}
				}else{
					if (_bfb_w < _bfb_h) {
						_mc.width = mcWidth;
						_mc.height = _mc.height * _bfb_w;
					} else {
						_mc.height = mcHeight;
						_mc.width = _mc.width * _bfb_h;
					}
				}
			}
		}
		//切换对象方式
		private function exchangeEffect(_val:Object, exef:String):void {
			setImageSize(_val as DisplayObject);
			switch (exef) {
				case "alpha" :
					_val.alpha = 0;
					TweenLite.to(_val, exchangeMcTime, {alpha:1, ease:Expo.easeOut});
					break;
				case "moveLeft" :
					_val.x =  -  _val.width;
					TweenLite.to(_val, exchangeMcTime, {x:0, ease:Expo.easeOut});
					break;
				case "moveRight" :
					_val.x = _val.width;
					TweenLite.to(_val, exchangeMcTime, {x:0, ease:Expo.easeOut});
					break;
				case "moveTop" :
					_val.y =  -  _val.height;
					TweenLite.to(_val, exchangeMcTime, {y:0, ease:Expo.easeOut});
					break;
				case "moveBottom" :
					_val.y = _val.height;
					TweenLite.to(_val, exchangeMcTime, {y:0, ease:Expo.easeOut});
					break;
				case "blur" :
					TweenMax.to(_val, 0, {blurFilter:{blurX:111},ease:Expo.easeOut});
					TweenMax.to(_val, exchangeMcTime, {blurFilter:{blurX:0},ease:Expo.easeOut});
					break;
				case "RollMoveLeft" :
					_val.x =  -  _val.width - exefMcSpace;
					if(_val.width<imgWidth){
						TweenLite.to(_val, exchangeMcTime, {x:(imgWidth-_val.width)/2, ease:Expo.easeOut});
						}else{
						TweenLite.to(_val, exchangeMcTime, {x:0, ease:Expo.easeOut});
					}
					if(_val.height<imgHeight){
						_val.y=(imgHeight-_val.height)/2
					}else{
						_val.y=0;
					}
					if (_val.name == "downMc") {
						TweenLite.to(upMc, exchangeMcTime, {x:(imgWidth + exefMcSpace), ease:Expo.easeOut});
						} else {
						TweenLite.to(downMc, exchangeMcTime, {x:(imgWidth + exefMcSpace), ease:Expo.easeOut});
					}
					break;
				case "RollMoveRight" :
					_val.x = _val.width + exefMcSpace;
					if(_val.width<imgWidth){
						TweenLite.to(_val, exchangeMcTime, {x:(imgWidth-_val.width)/2, ease:Expo.easeOut});
						}else{
						TweenLite.to(_val, exchangeMcTime, {x:0, ease:Expo.easeOut});
					}
					if(_val.height<imgHeight){
						_val.y=(imgHeight-_val.height)/2
					}else{
						_val.y=0;
					}
					if (_val.name == "downMc") {
						TweenLite.to(upMc, exchangeMcTime, {x:(-upMc.width-exefMcSpace), ease:Expo.easeOut});
						} else {
						TweenLite.to(downMc, exchangeMcTime, {x:(-downMc.width-exefMcSpace), ease:Expo.easeOut});
					}
					break;
			}
		}
		//按钮事件
		private function up_btnOver(evt:MouseEvent):void {
			clearInterval(intervalID);
		}
		private function up_btnOut(evt:MouseEvent):void {
			sedIvl();
		}
		private function up_btnDown(evt:MouseEvent):void {
			if(exefState=="RollMoveLeft"||exefState=="RollMoveRight"){
				exefState="RollMoveLeft";
			}
			handGoto(mcSub-1);
			aim = "Left";
		}
		private function down_btnOver(evt:MouseEvent):void {
			clearInterval(intervalID);
		}
		private function down_btnOut(evt:MouseEvent):void {
			sedIvl();
		}
		private function down_btnDown(evt:MouseEvent):void {
			if(exefState=="RollMoveLeft"||exefState=="RollMoveRight"){
				exefState="RollMoveRight";
			}
			handGoto(mcSub+1);
			aim = "Right";
		}
		//开放接口
		public function clearData():void{
			bigpicArr.splice(0,bigpicArr.length);
			smallpicArr.splice(0,smallpicArr.length);
			titleArr.splice(0,titleArr.length);
			linkArr.splice(0,linkArr.length);
			descArr.splice(0,descArr.length);
			if (mcTemp.numChildren > 0) {
				mcTemp.removeChildAt(0);
			}
		}
		public function doAction():void {
			dispatchEvent(new Event(ShowOnlyDisplay.COMPLETEXML));
		}
		//设置初始开始的索引位置
		public function set initSub(_val:Number):void {
			mcSub = _val;
		}
		//返回当前位置
		public function get subMc():Number {
			return this.mcSub;
		}
		//返回标题
		public function get gettitleArr():Array {
			return this.titleArr;
		}
		//返回图片1
		public function get getBigpicArr():Array {
			return this.bigpicArr;
		}
		//返回图片2
		public function get getSmallpicArr():Array {
			return this.smallpicArr;
		}
		//返所有外部链接
		public function get urlArr():Array {
			return this.linkArr;
		}
		//设置前后翻页按钮
		public function setBtn(_upbtn:Sprite, _downbtn:Sprite):void {
			setHandButton(_upbtn,_downbtn);
		}
		//自定义跳转到指定页面
		public function set setSub(_val:Number):void {
			clearInterval(intervalID);
			aim = "Left";
			handGoto(_val);
		}
		public function get setSub():Number{
			return this.mcSub;
		}
		//设置自动播放时的前后轮换方向"Left","Right"
		public function set rotateExp(_val:String):void {
			aim = _val;
		}
		//返回当前加载的内容的百分比
		public function get getPercent():Number {
			return percent;
		}
		//设置切换时间
		public function set setExctime(_val:Number):void {
			this.exchangeMcTime = _val / 1000;
		}
		//设置切换方式
		public function set setExefState(_val:String):void {
			this.exefState = _val;
		}
		//滚动切换图片间间距
		public function set setMcSpace(_val:Number):void {
			this.exefMcSpace = _val;
		}
		//滚动切换图片间间距
		public function get setMcSpace():Number {
			return this.exefMcSpace;
		}
		//是否自动播放
		public function set setAutoplay(_val:Boolean):void {
			this.autoplay = _val;
		}
		//是否隐藏前一张图片
		public function set hidDown(_val:Boolean):void{
			this.downVisible=_val;
		}
	}
}