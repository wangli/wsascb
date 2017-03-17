package com.wsascb.touch
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class SwipeTouch extends EventDispatcher
	{
		private var touchTimeA:Number=0;
		private var touchTimeB:Number=0;
		private var touchMoveXA:Number=0;
		private var touchMoveXB:Number=0;
		private var touchMoveYA:Number=0;
		private var touchMoveYB:Number=0;
		private var sprX:Number=0;
		private var sprY:Number=0;
		private var _offsetX:Number;
		private var _offsetY:Number;
		private var spr:Sprite;
		public static var TOUCH_BEGIN:String="touch_begin";
		public static var TOUCH_MOVE:String="touch_move";
		public static var TOUCH_END:String="touch_end";
		public function SwipeTouch(_spr:Sprite)
		{
			spr=_spr;	
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}
		public function builderListener():void{
			//滑动
			spr.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			spr.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			spr.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);			
		}		
		private function removeListener():void{
			spr.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			spr.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			spr.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);	
		}
		private function onTouchBegin(eBegin:TouchEvent) {
			touchTimeA=new Date().time;	
			touchMoveXA=eBegin.stageX;
			touchMoveYA=eBegin.stageY;			
			dispatchEvent(new Event(SwipeTouch.TOUCH_BEGIN));
		}		
		private function onTouchMove(eMove:TouchEvent) {			
			//获取角度
			var aPoint:Point = new Point(touchMoveXA,touchMoveYA);
			var bPoint:Point = new Point(eMove.stageX,eMove.stageY);
			var rot:int = Math.atan2(bPoint.y - aPoint.y,bPoint.x - aPoint.x) * 180 / Math.PI;
			var ltf:Boolean=((rot<-145||rot>-45)&&rot<0);
			var rtf:Boolean=((rot<45||rot>145)&&rot>=0);
			if(ltf||rtf){
				var _mx:Number=eMove.stageX-touchMoveXA;
				dispatchEvent(new Event(SwipeTouch.TOUCH_MOVE));
			}
		}
		private function onTouchEnd(eEnd:TouchEvent) {
			touchTimeB=new Date().time;
			touchMoveXB=eEnd.stageX;
			touchMoveYB=eEnd.stageY;
			_offsetX=(touchMoveXB-touchMoveXA)/(touchTimeB-touchTimeA);
			_offsetY=(touchMoveYB-touchMoveYA)/(touchTimeB-touchTimeA);
			dispatchEvent(new Event(SwipeTouch.TOUCH_END));
		}
		//获取横向触滑方向，值大小决定(左<0>0右)
		public function get offsetX():Number
		{
			return _offsetX;
		}
		//获取纵向触滑方向，值大小决定(左<0>0右)
		public function get offsetY():Number
		{
			return _offsetY;
		}


	}
}