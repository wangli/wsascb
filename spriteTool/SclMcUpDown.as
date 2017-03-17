package com.wsascb.spriteTool
{
	import com.wsascb.touch.RollOnSprTouch;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	
	public class SclMcUpDown extends EventDispatcher
	{
		private var spr:Sprite;
		private var mask:Sprite;
		private var roll:RollOnSprTouch;
		
		public function SclMcUpDown(_spr:Sprite,_mask:Sprite)
		{
			spr=_spr;
			mask=_mask;
			spr.mask=mask;
			roll=new RollOnSprTouch(spr,new Rectangle(mask.x,mask.y,spr.width,mask.height),true,0,100);
		}
	}
}