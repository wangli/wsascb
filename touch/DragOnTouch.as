package com.wsascb.touch
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.greensock.events.TweenEvent;
	import com.wsascb.Draw.drawBase;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class DragOnTouch extends EventDispatcher
	{
		private var sprA:Sprite;
		private var sprB:Sprite;
		private var sprC:MovieClip;
		private var fra:Object;
		private var line:Sprite;
		private var swipe:SwipeTouch;
		private var draw:drawBase;
		private var TBeginX:Number;
		private var TBeginY:Number;
		private var TEndX:Number;
		private var TEndY:Number;
		private var play:Boolean=false;
		public static var TOUCH_BEGIN:String="touch_begin";
		public static var TOUCH_MOVE:String="touch_move";
		public static var TOUCH_END:String="touch_end";
		public function DragOnTouch(_sprA:Sprite,_sprB:Sprite,_sprC:MovieClip,_fra:Object,_play:Boolean=false)
		{
			sprA=_sprA;
			sprB=_sprB;
			sprC=_sprC;
			fra=_fra;
			play=_play;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			sprA.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
		}
		private function onTouchBegin(evt:TouchEvent) {
			TBeginX=evt.stageX;
			TBeginY=evt.stageY;	
			line=new Sprite();
			line.x=TBeginX;
			line.y=TBeginY;
			sprA.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			sprA.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			sprA.stage.addChild(line);
		}		
		private function onTouchMove(evt:TouchEvent) {
			line.graphics.clear();
			line.graphics.moveTo(0,0);
			line.graphics.lineStyle(1,0x999999);
			line.graphics.lineTo(evt.stageX-TBeginX,evt.stageY-TBeginY);
		}
		private function onTouchEnd(evt:TouchEvent) {
			if(sprB.hitTestPoint(evt.stageX,evt.stageY)){
				if(play){
					sprC.gotoAndPlay(fra);
				}else{
					sprC.gotoAndStop(fra);
				}
				TweenMax.to(line, 0.2, {alpha:0, ease:Cubic.easeOut,onComplete:moveOver});
			}else{
				TweenMax.to(line, 0.3, {width:1,height:1, ease:Cubic.easeOut,onComplete:moveOver});
			}
		}
		private function moveOver():void{
			sprA.stage.removeChild(line);
			
		}
		private function sprBonTouchEnd(evt:TouchEvent) {
			trace("Ok");
		}
	}
}