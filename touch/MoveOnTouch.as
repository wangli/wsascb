package com.wsascb.touch
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	
	public class MoveOnTouch extends EventDispatcher
	{
		private var sprA:Sprite;
		private var mc:MovieClip;
		private var way:String;
		private var fra:Object;
		private var dist:Number;
		private var time:Number;
		private var movetouch:MoveTouch;
		public function MoveOnTouch(_sprA:Sprite,_mc:MovieClip,_fra:Object,_way:String="lr",_dist:Number=100,_time:Number=100000,lst:Boolean=true)
		{
			sprA=_sprA;
			way=_way;
			mc=_mc;
			fra=_fra;
			dist=_dist;
			time=_time;
			if(lst){
				builderListener();
			}			
		}
		public function builderListener():void{
			movetouch=new MoveTouch(sprA,dist,time,way);
			movetouch.addEventListener(MoveTouch.TOUCH_ACOK,touchOk);
		}
		private function touchOk(evt:Event):void{
			mc.gotoAndStop(fra);
		}
	}
}