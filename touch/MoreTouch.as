package com.wsascb.touch
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	//点击触控次数
	public class MoreTouch extends EventDispatcher
	{
		private var touchTimeA:Number=0;
		private var touchTimeB:Number=0;
		private var spr:Sprite;
		private var dist:Number=100;
		private var time:Number=100000;
		private var num:int=2;
		private var tNum:int=0;
		private var timer:Timer;
		public static var TOUCH_BEGIN:String="touch_begin";
		public static var TOUCH_ACOK:String="touch_action_ok";
		public function MoreTouch(_spr:Sprite,_num:int=2,_time:Number=300,lst:Boolean=true)
		{
			spr=_spr;
			num=_num;
			time=_time;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			timer=new Timer(time*num);
			timer.addEventListener(TimerEvent.TIMER,timerEvt);
			
			if(lst){
				builderListener();		
			}
		}
		private function timerEvt(evt:TimerEvent):void{
			tNum=0;
			timer.stop();
		}
		public function builderListener():void{
			if(spr.willTrigger(TouchEvent.TOUCH_BEGIN)){removeListener();}
			spr.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			spr.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			spr.addEventListener(TouchEvent.TOUCH_OUT, onTouchEnd);					
		}		
		public function removeListener():void{
			spr.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			spr.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);	
			spr.removeEventListener(TouchEvent.TOUCH_OUT, onTouchEnd);	
		}
		private function onTouchBegin(eBegin:TouchEvent) {
			if(tNum==0){
				timer.start();
				dispatchEvent(new Event(MoreTouch.TOUCH_BEGIN));
			}
			tNum++;
		}
		private function onTouchEnd(eEnd:TouchEvent) {
			if(tNum==num){
				dispatchEvent(new Event(MoreTouch.TOUCH_ACOK));
			}
		}
	}
}