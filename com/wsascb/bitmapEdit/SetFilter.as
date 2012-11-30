package com.wsascb.bitmapEdit{
	import com.wsascb.bitmapEdit.filters.*;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.filters.*;
	import flash.geom.*;
	import flash.utils.Timer;

	public class SetFilter {
		private var ws_bmp:Bitmap;
		private var ws_blur:BlurFilter;
		private var ws_color_val:Number;
		private var ws_currentCount:Number;

		public function SetFilter(_bitmap:Bitmap=null) {
			if (_bitmap!=null) {
				ws_bmp=_bitmap;
			}
		}
		//模糊
		public function blur(_extent:Number=1,_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			var _blurX:Number=_extent;
			var _blurY:Number=_extent;
			var _quality:int=1;
			ws_blur=new BlurFilter(_blurX,_blurY,_quality);
			var myFilters:Array = new Array();
			myFilters.push(ws_blur);
			ws_bmp.filters=myFilters;
		}
		//锐化
		public function sharpening(_extent:Number=0,_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			_extent=(_extent>100)?100:_extent;
			_extent=(_extent<1)?1:_extent;
			var _bmpData:BitmapData=ws_bmp.bitmapData;
			var _rec:Rectangle=new Rectangle(0, 0, _bmpData.width, _bmpData.height);
			var _point:Point=new Point(0,0);

			var _myFilters:Array=ConvolutionMatrixArrays.sharpeningArray(_extent/10);
			var _sharpening:ConvolutionFilter=new ConvolutionFilter(3,3,_myFilters);
			_bmpData.applyFilter(_bmpData,_rec, _point,_sharpening);
		}
		//浮雕
		public function embossing(_extent:Number=1,_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			var _bmpData:BitmapData=ws_bmp.bitmapData;
			var _rec:Rectangle=new Rectangle(0, 0, _bmpData.width, _bmpData.height);
			var _point:Point=new Point(0,0);
			_extent=(_extent>100)?100:_extent;
			_extent=(_extent<1)?1:_extent;
			//var _nx:Number=_extent/50;
			var _myFilters:Array=ConvolutionMatrixArrays.embossingArray(_extent);
			var _embossing:ConvolutionFilter=new ConvolutionFilter();
			_embossing.matrixX=3;
			_embossing.matrixY=3;
			_embossing.matrix=_myFilters;
			_embossing.bias=128;
			_embossing.divisor=0;
			_bmpData.applyFilter(_bmpData,_rec, _point,_embossing);
		}
		//检测边缘
		public function detectEdge(_extent:Number=1,_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			var _bmpData:BitmapData=ws_bmp.bitmapData;
			var _rec:Rectangle=new Rectangle(0, 0, _bmpData.width, _bmpData.height);
			var _point:Point=new Point(0,0);
			var _nx:Number=_extent/100;
			var _myFilters:Array=ConvolutionMatrixArrays.detectEdgeArray();
			var _sharpening:ConvolutionFilter=new ConvolutionFilter(3,3,_myFilters);
			_bmpData.applyFilter(_bmpData,_rec, _point,_sharpening);

		}
		//制作老照片
		public function scrapImage(_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			var tempBitmapData:BitmapData=new BitmapData(ws_bmp.width,ws_bmp.height,true,0x00000000);
			tempBitmapData.copyPixels(ws_bmp.bitmapData,ws_bmp.bitmapData.rect,new Point(0,0));
			var _brightness:ColorMatrixFilter=new ColorMatrixFilter(ColorMatrixArrays.brightnessArray(70));
			var _dropShadowFilter:DropShadowFilter=new DropShadowFilter(4,35,0x2e2305,0.6,5,12,4,BitmapFilterQuality.MEDIUM);
			var _fadefading:ColorTransform=new ColorTransform(0.7, 0.7, 0.7 ,0x44, 0x33, 0x22);
			ws_bmp.bitmapData.applyFilter(ws_bmp.bitmapData,ws_bmp.bitmapData.rect,new Point(0,0),_brightness);
			ws_bmp.bitmapData.colorTransform(ws_bmp.bitmapData.rect,_fadefading);
		}
		//马斯克
		public function mosaic(_extent:Number=0.5,_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			ws_bmp.bitmapData=BitmapDataFilters.mosaicFilter2(ws_bmp,_extent);
		}
		//水彩效果
		public function watercolour(_extentX:Number = 5,_extentY:Number = 5,_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			ws_bmp.bitmapData=BitmapDataFilters.waterColorFilter(ws_bmp.bitmapData,_extentX,_extentY);
		}
		//素描
		public function sketch(_extent:Number = 5,_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			ws_bmp.bitmapData=BitmapDataFilters.sketchFilter(ws_bmp.bitmapData,_extent);
		}
		//制作数码底片
		public function digitalNegative(_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			myColorMatrixFilter(ColorMatrixArrays.negativeArray(),_bmp);
		}
		//灰阶应用
		public function grayscale(_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			myColorMatrixFilter(ColorMatrixArrays.grayscaleArray(),_bmp);
		}
		//饱和度
		public function saturation(_extent:Number=1,_bmp:Bitmap=null):void {
			var extent:Number;
			extent=(_extent>3)?3:_extent;
			extent=(_extent<0)?0:_extent;
			myColorMatrixFilter(ColorMatrixArrays.saturationArray(extent),_bmp);

		}
		//亮度
		public function brightness(_extent:Number=1,_bmp:Bitmap=null):void {
			var extent:Number;
			extent=(_extent>255)?255:_extent;
			extent=(_extent<-255)?-255:_extent;
			myColorMatrixFilter(ColorMatrixArrays.brightnessArray(extent),_bmp);
		}
		//对比度
		public function contrast(_extent:Number=1,_bmp:Bitmap=null):void {
			var extent:Number;
			extent=(_extent>100)?100:_extent;
			extent=(_extent<-100)?-100:_extent;
			myColorMatrixFilter(ColorMatrixArrays.contrastArray(extent),_bmp);
		}
		//色相调整
		public function hueAdjust(_extent:Number=0,_bmp:Bitmap=null):void {
			var extent:Number;
			extent=(_extent>180)?180:_extent;
			extent=(_extent<-180)?-180:_extent;
			myColorMatrixFilter(ColorMatrixArrays.hueArray(extent),_bmp);
		}
		//完全着色_extent颜色值
		public function colorize(_extent:Number,_bmp:Bitmap=null ):void {
			myColorMatrixFilter(ColorMatrixArrays.colorize(_extent),_bmp);
		}
		//------colorizeHue----色相叠加
		public function colorizeHue(_extent:uint,_bmp:Bitmap=null):void {
			ws_color_val=_extent;
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			var timesFun:Timer=new Timer(10,ws_bmp.height);
			timesFun.addEventListener(TimerEvent.TIMER,timeColorHue);
			timesFun.addEventListener(TimerEvent.TIMER_COMPLETE,timeComplete);
			timesFun.start();
		}
		//------colorizeHue----色相叠加---之停止计时器
		private function timeComplete(evt:TimerEvent):void {
			evt.target.stop();
			trace("转变完成");
		}
		//------colorizeHue----色相叠加的逐行转变动画过程
		private function timeColorHue(evt:TimerEvent):void {
			ws_currentCount=evt.target.currentCount;
			var imgWidth:Number=ws_bmp.width;
			var imgHeight:Number=evt.target.currentCount;
			//trace(evt.target.currentCount);
			for (var j:int=0; j<imgWidth; j++) {
				setBmpPixelHsb(ws_bmp.bitmapData,j,imgHeight,ws_color_val);
			}
		}
		//------colorizeHue----色相叠加之替换色彩
		private function setBmpPixelHsb(_bid:BitmapData,_x:Number,_y:Number,newHsbRgb:uint):void {
			var pixelValue:uint = _bid.getPixel32(_x, _y);
			if (newHsbRgb.toString(16).length<=6) {
				newHsbRgb=uint("0xFF"+newHsbRgb.toString(16));
			}
			//设置颜色setColorHsb为转变色相
			_bid.setPixel32(_x,_y,ColorBase.setColorHsb(pixelValue,newHsbRgb));
		}
		//------colorizeHue----色相叠加之替换色彩
		public function get colorHueProgress():Number {
			return ws_currentCount / int(ws_bmp.height);
		}
		//应用颜色滤镜
		private function myColorMatrixFilter(filterArray:Array,_bmp:Bitmap=null):void {
			if (_bmp!=null) {
				ws_bmp=_bmp;
			}
			var _bmpData:BitmapData=ws_bmp.bitmapData;
			var _rec:Rectangle=new Rectangle(0, 0, _bmpData.width, _bmpData.height);
			var _point:Point=new Point(0,0);
			var _myFilters:Array=filterArray;
			var _sharpening:ColorMatrixFilter=new ColorMatrixFilter(_myFilters);
			_bmpData.applyFilter(_bmpData,_rec, _point,_sharpening);
		}
		//清除颜色滤镜
		public function clearMatrix():void {

		}
	}
}