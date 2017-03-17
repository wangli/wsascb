package com.wsascb.Draw
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ShapePoints extends Sprite
	{
		private var ws_target:Sprite;
		private var pointsX:Array;
		private var pointsY:Array;
		
		public function ShapePoints(_target:Sprite)
		{
			ws_target=_target;
			pointsX=new Array();
			pointsY=new Array();
		}
		public function ws_free(_target:Sprite):void{
			if(_target!=null) ws_target=_target;
			ws_target.addEventListener(MouseEvent.MOUSE_DOWN,init_draw);
		}
		private function init_draw(evt:MouseEvent):void{
			pointsX.push(evt.localX);
			pointsY.push(evt.localY);
			ws_target.addEventListener(MouseEvent.MOUSE_MOVE,start_draw);
			ws_target.addEventListener(MouseEvent.MOUSE_UP,sotp_draw);
		}
		private function start_draw(evt:MouseEvent):void{
			pointsX.push(evt.localX);
			pointsY.push(evt.localY);
		}
		private function sotp_draw(evt:MouseEvent):void{
			ws_target.removeEventListener(MouseEvent.MOUSE_DOWN,init_draw);
			ws_target.removeEventListener(MouseEvent.MOUSE_MOVE,start_draw);
			ws_target.removeEventListener(MouseEvent.MOUSE_UP,sotp_draw);
		}
		public function get getPointsX():Array{
			return pointsX;
		}
		public function get getPointsY():Array{
			return pointsY;
		}
	}
}