package com.wsascb.bitmapEdit
{
	import flash.events.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;

	import com.wsascb.assistant.RegularRegexp;
	import com.wsascb.Draw.drawBase;
	import com.wsascb.Draw.dyDrawBase;
	import com.wsascb.Position.Rotator;

	public class CutBitmap_bk extends EventDispatcher
	{
		public static var COMPLETE:String = "complete";
		public static var MOUSEMOVE:String = "mousemove";
		private var ws_bmp:Bitmap;
		private var ws_tempBmp:Bitmap;
		private var ws_bmpData:BitmapData;//临时
		private var ws_target:Sprite;
		private var ws_width:Number;
		private var ws_height:Number;
		private var Number_w:Number;//输入宽度
		private var Number_h:Number;//输入高度
		private var Number_x:Number;//输入x坐标
		private var Number_y:Number;//输入y坐标
		//裁切所创建的相关元素
		private var ndyDrawBase:dyDrawBase;
		private var ndrawBase:drawBase;
		private var ws_mask:Sprite;
		private var ws_cutMask:Sprite;
		private var strX:Number;
		private var strY:Number;
		private var moveBo:Boolean=false;
		//
		private var sfSpr:Sprite;
		public function CutBitmap(disObj:Sprite,bmp:Bitmap,_px:Number=0,_py:Number=0,_pw:Number=0,_ph:Number=0)
		{
			ws_target = disObj;
			ws_bmp = bmp;

			//初始设置图像属性并拷贝图像数据一份
			ws_bmpData = ws_bmp.bitmapData.clone();
			ws_tempBmp = new Bitmap(ws_bmpData);
			//建立绘图类
			ndrawBase=new drawBase();
			ws_width = ws_tempBmp.width;
			ws_height = ws_tempBmp.height;

			//setCutBitmap(_px,_py,_pw,_ph);
		}
		//----------裁切----------
		public function setCutBitmap(_px:Number=0,_py:Number=0,_pw:Number=0,_ph:Number=0):void
		{
			var px:Number,py:Number,pw:Number,ph:Number;
			if (_px != 0) {
				px = _px;
			} else {
				px = ws_width / 4;
			}
			if (_py != 0) {
				py = _py;
			} else {
				py = ws_height / 4;
			}
			if (_pw != 0) {
				pw = _pw;
			} else {
				pw = ws_width / 2;
			}
			if (_ph != 0) {
				ph = _ph;
			} else {
				ph = ws_height / 2;
			}
			ws_cutMask = ndrawBase.ws_drawRect(ws_width,ws_height,0,0,0,60);
			ws_cutMask.addChild(ws_tempBmp);
			ws_target.addChild(ws_cutMask);

			ndyDrawBase = new dyDrawBase(ws_cutMask);
			ndyDrawBase.infoNo(0,0xffffff,0);
			ndyDrawBase.adjustDrawSp(px,py,pw,ph);
			ndyDrawBase.point.x = px;
			ndyDrawBase.point.y = py;
			ndyDrawBase.handleDrag();
			ws_cutMask.addEventListener(MouseEvent.MOUSE_DOWN,mousedown);
			//ws_cutMask.addEventListener(MouseEvent.MOUSE_MOVE,mousemove);
			
			//新建遮罩;
			ws_mask=new Sprite();
			ws_cutMask.addChild(ws_mask);
			ws_drawRect(ws_mask,pw,ph,px,py);
			ws_tempBmp.mask = ws_mask;
			ws_tempBmp.addEventListener(MouseEvent.MOUSE_DOWN,maskDown);
			sfSpr=ndrawBase.ws_drawRect(10,10,0,0,0xffffff,50,1);
			sfSpr.x=px+pw;
			sfSpr.y=py+ph;
			ws_cutMask.addChild(sfSpr);
			sfSpr.addEventListener(MouseEvent.MOUSE_DOWN,sfsprDown);
		}
		private function sfsprDown(evt:MouseEvent):void{
			sfSpr.addEventListener(MouseEvent.MOUSE_MOVE,sfsprMove);
			sfSpr.addEventListener(MouseEvent.MOUSE_OUT,sfsprUP);
			sfSpr.addEventListener(MouseEvent.MOUSE_UP,sfsprUP);
			
		}
		private function sfsprMove(evt:MouseEvent):void{
			sfSpr.x=this.ws_target.mouseX;
		}
		private function sfsprUP(evt:MouseEvent):void{
			sfSpr.removeEventListener(MouseEvent.MOUSE_MOVE,sfsprMove);
			sfSpr.removeEventListener(MouseEvent.MOUSE_OUT,sfsprUP);
			sfSpr.removeEventListener(MouseEvent.MOUSE_UP,sfsprUP);
		}
		private function maskDown(evt:MouseEvent):void{
			trace("-----------")
		}
		private function mousedown(evt:MouseEvent):void
		{
			moveBo=true;
			strX=ws_cutMask.mouseX;
			strY=ws_cutMask.mouseY;
			ws_cutMask.addEventListener(MouseEvent.MOUSE_UP,mouseup);
			ws_cutMask.addEventListener(MouseEvent.MOUSE_MOVE,mousemove);
		}
		private function mousemove(evt:MouseEvent):void
		{
			if(moveBo){/*
				ws_tempBmp.x=ws_cutMask.mouseX-strX;
				ws_bmp.x=ws_cutMask.mouseX-strX;
				ws_tempBmp.y=ws_cutMask.mouseY-strY;
				ws_bmp.y=ws_cutMask.mouseY-strY;*/
			}
			Number_w = ndyDrawBase.drawSp.width;
			Number_h = ndyDrawBase.drawSp.height;
			Number_x = ndyDrawBase.point.x + ndyDrawBase.drawSp.x;
			Number_y = ndyDrawBase.point.y + ndyDrawBase.drawSp.y;
			sfSpr.x=Number_x+Number_w;
			sfSpr.y=Number_y+Number_h;
			ws_drawRect(ws_mask,ndyDrawBase.drawSp.width,ndyDrawBase.drawSp.height,ndyDrawBase.drawSp.x+ndyDrawBase.point.x,ndyDrawBase.drawSp.y+ndyDrawBase.point.y);
			dispatchEvent(new Event(CutBitmap.MOUSEMOVE));
		}
		private function mouseup(evt:MouseEvent):void
		{
			moveBo=false;
			//ws_cutMask.removeEventListener(MouseEvent.MOUSE_MOVE,mousemove);
			//ws_cutMask.removeEventListener(MouseEvent.MOUSE_UP,mouseup);
		}
		//画带矩形
		private function ws_drawRect(ws_mc:Sprite,ws_width:Number,ws_height:Number,ws_x:Number=0, ws_y:Number=0,ws_colorm:uint=0xFFFFFF,ws_alpha:Number=100,ws_line:Number=undefined,ws_colorl:uint=0xFFFFFF):void
		{
			//*宽，*高，x坐标，y坐标，填充颜色，透明度,边线粗细，边线颜色；
			ws_mc.graphics.clear();
			ws_mc.graphics.beginFill(ws_colorm,ws_alpha/100);
			ws_mc.graphics.lineStyle(ws_line,ws_colorl);
			ws_mc.graphics.drawRect(ws_x,ws_y,ws_width,ws_height);
			ws_mc.graphics.endFill();
		}
		//剪切图片
		public function cut():BitmapData
		{
			return cutOutRect(ws_bmp,ws_mask.width,ws_mask.height,ndyDrawBase.drawSp.x+60,ndyDrawBase.drawSp.y+60);
			//return null
		}
		private function cutOutRect( target:DisplayObject, width:Number, height:Number, distanceX:Number=0, distanceY:Number=0, transparent:Boolean = true, fillColor:uint = 0x00000000 ):BitmapData
		{
			var m:Matrix = target.transform.matrix;
			m.tx -=  target.getBounds(target.parent).x + distanceX;
			m.ty -=  target.getBounds(target.parent).y + distanceY;
			//trace(m);

			var bmpData:BitmapData = new BitmapData(width,height,transparent,fillColor);
			bmpData.draw( target, m );

			return bmpData;
		}
		public function get tempBmp():Bitmap
		{
			return ws_tempBmp;
		}
		public function get cutMask():Sprite{
			return null;
		}
		//清楚裁切
		public function clearCutBitmap():void
		{
		}
	}
}