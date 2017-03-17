package com.wsascb.spriteTool
{
	import com.wsascb.Draw.drawBase;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class Scroller extends EventDispatcher
	{
		private var _drawSpr:drawBase;
		private var _bodySpr:Sprite;
		private var _maskSpr:Sprite;
		private var _speed:Number;
		private var _scrollBar:ScrollSpr;
		private var _scrollBarArea:Sprite;
		private var _scroller:Sprite;
		private var _scrollerUp:Sprite;
		private var _scrollerDown:Sprite;
		private var _parent:Sprite;
		//
		private var sd:Number;
		private var sr:Number;
		private var cd:Number;
		private var cr:Number;
		private var new_y:Number;
		private var drag_area:Rectangle;
		private var clickTF:Boolean;
		private var _scroll:Boolean = false;
		public function Scroller(bodySpr:Sprite,maskSpr:Sprite,speed:Number=0.2,scrollBar:ScrollSpr=null)
		{
			_bodySpr = bodySpr;
			_maskSpr = maskSpr;
			_speed = speed;
			_parent = Sprite(bodySpr.parent);

			if (scrollBar!=null) {
				_scrollBar = scrollBar;
			} else {
				_scrollBar=new ScrollSpr();
				_scrollBar.x = _maskSpr.x + _maskSpr.width;
				_scrollBar.y = _maskSpr.y;
				_scrollBar.height = _maskSpr.height;
				_parent.addChild(_scrollBar);
			}
			_scrollBarArea = _scrollBar.scrollBarArea;
			_scroller = _scrollBar.scroller;
			_scrollerUp = _scrollBar.scrollerUp;
			_scrollerDown = _scrollBar.scrollerDown;
			init();
		}
		public function upData():void
		{
			init();
		}
		public function get getScrollSpr():ScrollSpr
		{
			return _scrollBar;
		}
		private function init():void
		{
			_scrollBar.height = _maskSpr.height;
			_scrollBar.x = _maskSpr.x + _maskSpr.width;
			_scrollBar.y = _maskSpr.y;
			if ( _speed < 0 || _speed > 1 ) {
				_speed = 0.50;
			}
			var _bodySprH:Number=( _bodySpr.height>0)?_bodySpr.height:1;
			_scrollBar.height = _maskSpr.height;

			_bodySpr.mask = _maskSpr;
			_bodySpr.x = _maskSpr.x;
			_bodySpr.y = _maskSpr.y;

			_scroller.x = _scrollBarArea.x;
			_scroller.y = _scrollBarArea.y;

			sr =( _maskSpr.height / _bodySprH>1)?1:_maskSpr.height / _bodySprH;
			_scroller.height = _scrollBarArea.height * sr;

			sd = _scrollBarArea.height - _scroller.height;
			cd = _bodySprH - _maskSpr.height;
			cr = cd / sd * 1.01;

			drag_area = new Rectangle(_scrollBar.scroller.x,_scrollBar.scroller.y,0,_scrollBarArea.height - _scroller.height);
			if (_bodySprH <= _maskSpr.height) {
				_scroller.visible = _scrollBarArea.visible = false;
			} else {
				_scroller.visible = _scrollBarArea.visible = true;
			}
			_scroller.stage.addEventListener(MouseEvent.MOUSE_WHEEL,msWheel);
			_scroller.addEventListener( MouseEvent.MOUSE_DOWN, scroller_drag );
			_scroller.addEventListener( MouseEvent.MOUSE_UP, scroller_drop );
			_maskSpr.addEventListener(MouseEvent.MOUSE_OVER,scroller_drag);
		}
		private function scroller_drag(event:MouseEvent):void
		{
			clickTF = true;
			event.target.startDrag(false, drag_area);
			_maskSpr.addEventListener(Event.ENTER_FRAME, on_scroll);
			_scroller.stage.addEventListener(MouseEvent.MOUSE_UP, up);

		}
		private function msWheel(event:MouseEvent):void
		{
			//trace(event.delta);
			var wheelXa = _maskSpr.x;
			var wheelXb = _maskSpr.width + 10;
			var wheelYa = _maskSpr.y;
			var wheelYb = _maskSpr.height + 10;
			if (_parent.mouseX > wheelXa && _parent.mouseX < wheelXb && _parent.mouseY > wheelYa && _parent.mouseY < wheelYb) {
				clickTF = true;
				_maskSpr.addEventListener(Event.ENTER_FRAME, on_scroll);
				if (_scroller.y - event.delta < 0) {
					_scroller.y = 0;
				} else if (_scroller.y+_scroller.height-event.delta>_scrollBarArea.y+_scrollBarArea.height) {
					_scroller.y = _scrollBarArea.height - _scroller.height;
				} else {
					_scroller.y +=   -  event.delta;
				}
			} else {
				clickTF = false;
				_maskSpr.removeEventListener(Event.ENTER_FRAME, on_scroll);
			}
		}
		private function scroller_drop(event:MouseEvent):void
		{
			clickTF = false;
			event.target.stopDrag();
			//_maskSpr.removeEventListener(Event.ENTER_FRAME, on_scroll);
			_scroller.removeEventListener(MouseEvent.MOUSE_UP, up);
		}
		private function up( me:MouseEvent ):void
		{
			//_maskSpr.removeEventListener(Event.ENTER_FRAME, on_scroll);
			_scroller.stopDrag();
			clickTF = false;
		}
		private function on_scroll(evt:Event ):void
		{
			new_y = _maskSpr.y + _scrollBarArea.y * cr - _scroller.y * cr;
			_bodySpr.y += ( new_y - _bodySpr.y ) * _speed;
			var chazhi:Number = int(Math.round(_bodySpr.y) - Math.round(new_y));
			if (chazhi==0&&clickTF==false) {
				_maskSpr.removeEventListener(Event.ENTER_FRAME, on_scroll);
			}
		}
	}
}