package com.wsascb.spriteTool
{
	import com.wsascb.touch.MoreTouch;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public class McBudEvt extends EventDispatcher
	{
		public static function KlStopWaitAction(btn:Sprite,mc:MovieClip,val:Object):void{
			if(!btn.willTrigger(MouseEvent.CLICK)){
				btn.addEventListener(MouseEvent.CLICK,function(){mc.gotoAndPlay(val);});
			}
		}
		public static function KlActionToStop(btn:Sprite,mc:MovieClip,val:Object):void{
			if(!btn.willTrigger(MouseEvent.CLICK)){
				btn.addEventListener(MouseEvent.CLICK,function(){mc.gotoAndStop(val);});
			}
		}
		public static function KlVisible(btn:Sprite,mc:MovieClip,val:Boolean):void{
			if(!btn.willTrigger(MouseEvent.CLICK)){
				btn.addEventListener(MouseEvent.CLICK,function(){mc.visible=val});
			}
		}
		public static function KlVisibleOver(btn:Sprite,mc:MovieClip,val:Boolean):void{
			if(!btn.willTrigger(MouseEvent.MOUSE_OVER)){
				btn.addEventListener(MouseEvent.MOUSE_OVER,function(){mc.visible=val});
			}
		}
		public static function KlVisibleOut(btn:Sprite,mc:MovieClip,val:Boolean):void{
			if(!btn.willTrigger(MouseEvent.MOUSE_OUT)){
				btn.addEventListener(MouseEvent.MOUSE_OUT,function(){mc.visible=val});
			}
		}
		public static function KlActionToPrevFra(btn:Sprite,mc:MovieClip=null):void{
			if(mc==null)mc=MovieClip(btn.parent);
			if(!btn.willTrigger(MouseEvent.CLICK)){
				btn.addEventListener(MouseEvent.CLICK,function(){mc.prevFrame();});
			}	
		}
		public static function KlActionToNextFra(btn:Sprite,mc:MovieClip=null):void{
			if(mc==null)mc=MovieClip(btn.parent);
			if(!btn.willTrigger(MouseEvent.CLICK)){
				btn.addEventListener(MouseEvent.CLICK,function(){mc.nextFrame();});
			}
		}
		public static function KlTouchNumToGo(btn:Sprite,mc:MovieClip,val:Object,num:int=2):void{			
			var dobTouch:MoreTouch=new MoreTouch(btn,num);
			dobTouch.addEventListener(MoreTouch.TOUCH_ACOK,function(){mc.gotoAndStop(val)});
		}
	}
}