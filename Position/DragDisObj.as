package com.wsascb.Position
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.events.EventDispatcher;
	import flash.events.Event;

	public class DragDisObj extends EventDispatcher
	{
		private var ws_Sprite:Sprite;
		private var ws_rect:Rectangle;
		public static const MOUSE_DOWN:String = "mousedown";
		public static const MOUSE_UP:String = "mouseup";
		public static const MOUSE_MOVE:String = "mousemove";
		public static const MOUSE_OUT:String = "mouseout";
		public function DragDisObj(_sprite:Sprite,bounds:Rectangle=null)
		{
			this.ws_Sprite = _sprite;
			this.ws_rect = bounds;
			moveDrawSp();
		}
		//选区对象的拖动监听
		private function moveDrawSp():void
		{
			this.ws_Sprite.addEventListener(MouseEvent.MOUSE_DOWN,handleDrag);
		}
		//选区对象按下拖动改变坐标;
		private function handleDrag(event:MouseEvent):void
		{
			dispatchEvent(new Event(DragDisObj.MOUSE_DOWN));
			this.ws_Sprite.addEventListener(MouseEvent.MOUSE_MOVE,handleMove);
			this.ws_Sprite.addEventListener(MouseEvent.MOUSE_OUT,handleOut);
			this.ws_Sprite.addEventListener(MouseEvent.MOUSE_UP,handleDrog);
			this.ws_Sprite.startDrag(false,this.ws_rect);
			event.stopPropagation();
		}
		//移动
		private function handleMove(event:MouseEvent):void
		{
			dispatchEvent(new Event(DragDisObj.MOUSE_MOVE));
		}
		//移出范围
		private function handleOut(event:MouseEvent):void
		{
			dispatchEvent(new Event(DragDisObj.MOUSE_OUT));
		}
		//选区对象释放鼠标后停止拖动
		private function handleDrog(event:MouseEvent):void
		{
			dispatchEvent(new Event(DragDisObj.MOUSE_UP));
			this.ws_Sprite.removeEventListener(MouseEvent.MOUSE_MOVE,handleMove);
			this.ws_Sprite.removeEventListener(MouseEvent.MOUSE_OUT,handleOut);
			this.ws_Sprite.removeEventListener(MouseEvent.MOUSE_UP,handleDrog);
			this.ws_Sprite.stopDrag();
		}
		public function rectangle(val:Rectangle):void
		{
			this.ws_rect = val;
		}
	}
}