package com.wsascb.bitmapEdit{
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.TextInput;
	import fl.controls.Slider;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import fl.events.SliderEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.display.DisplayObject;

	import com.wsascb.assistant.RegularRegexp;
	import com.wsascb.Draw.drawBase;
	import com.wsascb.Draw.dyDrawBase;
	import com.wsascb.Position.Rotator;
	import com.wsascb.bitmapEdit.*;

	public class rotationBitmap {
		private var ws_bmp:Bitmap;
		private var ws_tempBmp:Bitmap;
		private var ws_bmpData:BitmapData;//临时
		private var ws_target:Sprite;
		private var ws_width:Number;
		private var ws_height:Number;
		private var errorFormat:TextFormat;//错误输入样式
		private var rightFormat:TextFormat;//正确输入样式
		private var text_rotation:TextInput;//输入宽度
		private var Number_w:Number;//输入宽度
		private var Number_h:Number;//输入高度
		private var Number_x:Number;//输入x坐标
		private var Number_y:Number;//输入y坐标
		private var slider_rotation:Slider;//同比例
		private var btn_app:Button;//应用
		//创建的相关元素
		private var nBitmapBase:BitmapBase;
		public function rotationBitmap(disObj:Sprite,bmp:Bitmap,_text:TextInput=null,_slider:Slider=null,_btn_app:Button=null) {
			ws_target=disObj;
			ws_bmp=bmp;
			text_rotation=_text;
			text_rotation.text="0";
			slider_rotation=_slider;
			btn_app=_btn_app;

			//输入错误的文本框样式变化
			errorFormat=new TextFormat();
			errorFormat.color=0xFF0000;
			errorFormat.bold=true;
			rightFormat=new TextFormat();
			rightFormat.color=0x333333;
			rightFormat.bold=false;

			//初始设置图像属性并拷贝图像数据一份
			ws_bmpData=ws_bmp.bitmapData.clone();
			ws_tempBmp=new Bitmap(ws_bmpData);
			//建立绘图类
			nBitmapBase=new BitmapBase(ws_bmp);
			nBitmapBase.angleBitmap(0);

			//添加监听器
			text_rotation.addEventListener(Event.CHANGE,textChange);
			slider_rotation.addEventListener(Event.CHANGE,sliderChange);
			slider_rotation.addEventListener(MouseEvent.MOUSE_DOWN,mousedown);
		}
		private function mouseup(evt:MouseEvent):void {
			slider_rotation.removeEventListener(MouseEvent.MOUSE_MOVE,mouseup);
			slider_rotation.removeEventListener(MouseEvent.MOUSE_MOVE,mousemove);
		}
		private function mousedown(evt:MouseEvent):void {
			slider_rotation.addEventListener(MouseEvent.MOUSE_UP,mouseup);
			slider_rotation.addEventListener(MouseEvent.MOUSE_MOVE,mousemove);
		}
		private function mousemove(evt:MouseEvent):void {
			text_rotation.text=String(slider_rotation.value);
			nBitmapBase.angleBitmap(slider_rotation.value);
		}
		private function textChange(evt:Event):void {
			var rot:Number=Number(text_rotation.text);
			if (rot>360||rot<-360) {
				//输入尺寸错误的文本样式
				evt.target.setStyle("textFormat", errorFormat);
			} else {
				//输入尺寸正确的文本样式
				evt.target.setStyle("textFormat", rightFormat);
				nBitmapBase.angleBitmap(rot);
				slider_rotation.value=rot;
			}
		}
		private function sliderChange(evt:SliderEvent):void {
			text_rotation.text=String(slider_rotation.value);
			nBitmapBase.angleBitmap(slider_rotation.value);
		}
	}
}