package com.wsascb.spriteTool
{
	import com.wsascb.Draw.drawBase;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class TransformSprite extends Sprite
	{

		private var borderSpr:Sprite;
		private var myDraw:drawBase;
		private var tgSpr:DisplayObjectContainer;
		private var tgParent:DisplayObjectContainer;
		public function TransformSprite(val:DisplayObjectContainer=null)
		{
			myDraw=new drawBase();
			if (val!=null) {
				this.target = val;
			}
		}
		public function set target(val:DisplayObjectContainer):void
		{
			tgSpr = val;
			tgParent = val.parent;
			borderSpr = myDraw.ws_drawRect(1,1,0,0,0xffcc00,0,0,0x9922000);
			this.addChild(borderSpr);
			createTransform();
			this.addEventListener(MouseEvent.MOUSE_DOWN,msDown);
			this.addEventListener(MouseEvent.MOUSE_MOVE,msMove);
			this.addEventListener(MouseEvent.MOUSE_UP,msUp);
			this.x = tgSpr.x-1;
			this.y = tgSpr.y-1;
		}
		private function msDown(evt:MouseEvent):void
		{
			this.startDrag();
		}
		private function msMove(evt:MouseEvent):void
		{
			tgSpr.x = this.x+1;
			tgSpr.y = this.y+1;
		}
		private function msUp(evt:MouseEvent):void
		{
			this.stopDrag();
		}
		private function createTransform():void
		{
			borderSpr.width = tgSpr.width;
			borderSpr.height = tgSpr.height;
			tgParent.addChild(this);
		}
		public function remove():void
		{
			if (tgSpr!=null) {
				tgSpr.parent.removeChild(this);
			}
		}

	}

}