package com.wsascb.touch
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class MoveTouch extends EventDispatcher
	{
		private var touchTimeA:Number=0;
		private var touchTimeB:Number=0;
		private var touchMoveXA:Number=0;
		private var touchMoveXB:Number=0;
		private var touchMoveYA:Number=0;
		private var touchMoveYB:Number=0;
		private var spr:Sprite;
		private var dist:Number=100;
		private var time:Number=100000;
		private var way:String="lr";
		public static var TOUCH_BEGIN:String="touch_begin";
		public static var TOUCH_MOVE:String="touch_move";
		public static var TOUCH_END:String="touch_end";
		public static var TOUCH_ACOK:String="touch_action_ok";
		public function MoveTouch(_spr:Sprite,_dist:Number=100,_time:Number=100000,_way:String="lr",lst:Boolean=true)
		{
			spr=_spr;
			dist=_dist;
			time=_time;
			way=_way;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			if(lst){
				builderListener();
			}
		}
		public function builderListener():void{
			spr.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			spr.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			spr.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			spr.addEventListener(TouchEvent.TOUCH_OUT, onTouchEnd);					
		}		
		public function removeListener():void{
			spr.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			spr.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			spr.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);	
		}
		private function onTouchBegin(eBegin:TouchEvent) {
			touchTimeA=new Date().time;	
			touchMoveXA=eBegin.stageX;
			touchMoveYA=eBegin.stageY;			
			dispatchEvent(new Event(MoveTouch.TOUCH_BEGIN));
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
				dispatchEvent(new Event(MoveTouch.TOUCH_MOVE));
			}
		}
		private function onTouchEnd(eEnd:TouchEvent) {
			touchTimeB=new Date().time;
			touchMoveXB=eEnd.stageX;
			touchMoveYB=eEnd.stageY;
			var acok:Boolean=false;
			switch(way){
				case "lr":
					acok=touchCount(touchMoveXB-touchMoveXA,touchTimeB-touchTimeA);
					break;
				case "rl":
					acok=touchCount(touchMoveXA-touchMoveXB,touchTimeB-touchTimeA);
					break;
				case "tb":
					acok=touchCount(touchMoveYB-touchMoveYA,touchTimeB-touchTimeA);
					break;
				case "bt":
					acok=touchCount(touchMoveYA-touchMoveYB,touchTimeB-touchTimeA);
					break;
			}
			if(acok){
				dispatchEvent(new Event(MoveTouch.TOUCH_ACOK));
			}
			dispatchEvent(new Event(MoveTouch.TOUCH_END));
		}
		private function touchCount(_dist:Number=100,_time:Number=10000):Boolean{
			if(_dist>dist&&_time<time){
				return true;
			}else{
				return false;
			}
		}
		
	}
}
