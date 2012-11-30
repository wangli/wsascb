package com.wsascb.spriteTool
{
	import com.wsascb.Draw.drawBase;
	import flash.display.Sprite;
	
	public class ScrollSpr extends Sprite
	{
		private var ndraw:drawBase;
		private var _scrollBarArea:Sprite;
		private var _scroller:Sprite;
		private var _scrollerUp:Sprite;
		private var _scrollerDown:Sprite;
		//拖动区域，拖动条，向上移动箭头按钮，向下移动箭头按钮
		public function ScrollSpr(scrollBarArea:Sprite=null,scroller:Sprite=null,scrollerUp:Sprite=null,scrollerDown:Sprite=null)
		{
			
			ndraw=new drawBase(this);
			if(scrollBarArea!=null){
				_scrollBarArea=scrollBarArea;
			}else{
				_scrollBarArea=ndraw.ws_drawRect(8,100,0,0,0xDDDDDD);
				this.addChild(_scrollBarArea);
			}
			
			if(scroller!=null){
				_scroller=scroller;
			}else{
				_scroller=ndraw.ws_drawRect(8,20,0,0,0x666666);
				this.addChild(_scroller);
			}
			
			if(scrollerUp!=null){
				_scrollerUp=scrollerUp;
			}
			if(scrollerDown!=null){
				_scrollerDown=scrollerDown;
			}
		}

		public function get scrollerDown():Sprite
		{
			return _scrollerDown;
		}

		public function set scrollerDown(value:Sprite):void
		{
			_scrollerDown = value;
		}

		public function get scrollerUp():Sprite
		{
			return _scrollerUp;
		}

		public function set scrollerUp(value:Sprite):void
		{
			_scrollerUp = value;
		}

		public function get scroller():Sprite
		{
			return _scroller;
		}

		public function set scroller(value:Sprite):void
		{
			_scroller = value;
		}

		public function get scrollBarArea():Sprite
		{
			return _scrollBarArea;
		}

		public function set scrollBarArea(value:Sprite):void
		{
			_scrollBarArea = value;
		}

	}
}