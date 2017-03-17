package com.wsascb.touch
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.greensock.events.TweenEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class RollOnSprTouch extends EventDispatcher
	{
		private var spr:DisplayObject;
		private var touchTimeA:Number=0;
		private var touchTimeB:Number=0;
		private var touchMoveXA:Number=0;
		private var touchMoveXB:Number=0;
		private var touchMoveYA:Number=0;
		private var touchMoveYB:Number=0;
		private var sprX:Number=0;
		private var sprY:Number=0;
		private var rect:Rectangle;
		private var moveState:String = "stop";//移动状态stop和play
		private var addRecX:Number;
		private var addRecY:Number;
		public static var TOUCHBEGIN:String = "TouchBegin";
		public static var TOUCHMOVE:String = "TouchMove";
		public static var TOUCHEND:String = "TouchEnd";
		public function RollOnSprTouch(_spr:DisplayObject,_rect:Rectangle,lst:Boolean=true,_addRecX:Number=0,_addRecY:Number=0)
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			spr=_spr;
			rect=_rect;
			addRecX=_addRecX;
			addRecY=_addRecY;
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
			spr.removeEventListener(TouchEvent.TOUCH_OUT, onTouchEnd);	
		}
		private function onTouchBegin(eBegin:TouchEvent) {
			touchTimeA=new Date().time;	
			touchMoveXA=eBegin.stageX;
			touchMoveYA=eBegin.stageY;
			sprX=spr.x;
			sprY=spr.y;
			dispatchEvent(new Event(RollOnSprTouch.TOUCHBEGIN));
		}		
		private function onTouchMove(eMove:TouchEvent) {
			//X坐标
			var _mx:Number=eMove.stageX-touchMoveXA;
			var pointX:Number=sprX+_mx;
			if(pointX<rect.x&&pointX>rect.x-(spr.width-rect.width)){
				spr.x=pointX;
			}else if(pointX<rect.x+addRecX&&pointX>rect.x-(spr.width-rect.width+addRecX)&&addRecX>0){
				spr.x=pointX;
			}
			//Y坐标
			var _my:Number=eMove.stageY-touchMoveYA;
			var pointY:Number=sprY+_my;
			if(pointY<rect.y&&pointY>rect.y-(spr.height-rect.height)){
				spr.y=pointY;
			}else if(pointY<rect.y+addRecY&&pointY>rect.y-(spr.height-rect.height+addRecY)&&addRecY>0){
				spr.y=pointY;
			}
			dispatchEvent(new Event(RollOnSprTouch.TOUCHMOVE));
		}		
		private function onTouchEnd(eEnd:TouchEvent) {
			touchTimeB=new Date().time;
			touchMoveXB=eEnd.stageX;
			touchMoveYB=eEnd.stageY;
			var moveX:Number=(touchMoveXB-touchMoveXA)/(touchTimeB-touchTimeA);
			var moveY:Number=(touchMoveYB-touchMoveYA)/(touchTimeB-touchTimeA);
			
			tweenMove(spr.x+moveX*spr.stage.stageWidth/2,spr.y+moveY*spr.stage.stageHeight/2);
			dispatchEvent(new Event(RollOnSprTouch.TOUCHEND));
		}
		private function tweenMove(valX:Number,valY:Number):void{
			//X坐标
			if(rect.width>0&&spr.width>rect.width){
				var goX:Number=0;
				if(valX>rect.x){
					goX=rect.x;
				}else if(valX<rect.x-(spr.width-rect.width)){
					goX=rect.x-(spr.width-rect.width);
				}else{
					goX=valX;
				}
				TweenMax.to(spr, 0.6, {x:goX, ease:Cubic.easeOut,onComplete:moveOver});
			}else if(spr.x>rect.x&&addRecX>0){
				TweenMax.to(spr, 0.3, {x:rect.x, ease:Cubic.easeOut,onComplete:moveOver});
			}else if(spr.x<rect.x-(spr.width-rect.width)&&addRecX>0){
				TweenMax.to(spr, 0.3, {x:rect.x-(spr.width-rect.width), ease:Cubic.easeOut,onComplete:moveOver});
			}
			//Y坐标
			if(rect.height>0&&spr.height>rect.height){
				var goY:Number=0;
				if(valY>rect.y){
					goY=rect.y;
				}else if(valY<rect.y-(spr.height-rect.height)){
					goY=rect.y-(spr.height-rect.height);
				}else{
					goY=valY;
				}
				TweenMax.to(spr, 0.6, {y:goY, ease:Cubic.easeOut,onComplete:moveOver});
			}else if(spr.y>rect.y&&addRecY>0){
				TweenMax.to(spr, 0.3, {y:rect.y, ease:Cubic.easeOut,onComplete:moveOver});
			}else if(spr.y<rect.y-(spr.height-rect.height)&&addRecY>0){
				TweenMax.to(spr, 0.3, {y:rect.y-(spr.height-rect.height), ease:Cubic.easeOut,onComplete:moveOver});			
			}
		}
		private function moveOver():void
		{
			moveState = "stop";
		}
	}
}