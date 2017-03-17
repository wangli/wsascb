package com.wsascb.spriteTool
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.greensock.events.TweenEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	public class TouchNodeLine extends EventDispatcher
	{
		private var spr:Sprite;
		private var goSprArr:Array;
		private var lineArr:Array;
		private var lg:int=0;
		private var target:Sprite;
		private var allLine:Sprite;
		private var pl:Boolean;
		public function TouchNodeLine(_sprA:Sprite,_goSprArr:Array,_pl:Boolean=false)
		{
			spr=_sprA;
			goSprArr=_goSprArr;
			lg=goSprArr.length;
			pl=_pl;
			target=Sprite(spr.parent);
			init();
		}
		private function init(){
			allLine=new Sprite();
			lineArr=new Array();
			target.addChild(allLine);
			for(var i:int=0;i<lg;i++){
				var _line:Sprite=drawLine(spr,goSprArr[i]);
				_line.scaleX=0;
				_line.scaleY=0;
				allLine.addChild(_line);
				lineArr.push(_line);
				goSprArr[i].alpha=0;
			}
			if(pl) tweenLine();
		}
		public function show():void{
			for(var i:int=0;i<lg;i++){
				lineArr[i].scaleX=0;
				lineArr[i].scaleY=0;
				goSprArr[i].alpha=0;
			}
			tweenLine();
		}
		private function tweenLine():void{
			for(var k:int=0;k<lg;k++){
				TweenMax.to(lineArr[k], 0.8, {scaleX:1,scaleY:1, ease:Cubic.easeOut,onComplete:moveOver,onCompleteParams:[k]});
			}		
		}
		private function moveOver(k:int):void{
			TweenMax.to(goSprArr[k], 0.5, {alpha:1, ease:Cubic.easeOut});
		}
		private function drawLine(aSpr:Sprite,bSpr:Sprite,py:Point=null):Sprite{
			//计算出发点位置
			if(py==null)py=new Point(0,0);
			var aPTemp:Point=angleLinePiont(angleSpr(aSpr,bSpr),aSpr.width/1.4);
			var aP:Point=new Point(aSpr.x+aPTemp.x+py.x,aSpr.y+aPTemp.y+py.y);
			
			//计算目标点位置
			var bP:Point=new Point();
			
			if(aP.x<bSpr.x){
				bP.x=bSpr.x-aP.x;
			}else{
				bP.x=bSpr.x-aP.x+bSpr.width;
			}
			
			if(aP.y<bSpr.y){
				bP.y=bSpr.y-aP.y;
			}else{
				bP.y=bSpr.y-aP.y+bSpr.height;
			}
			var line:Sprite=new Sprite();
			line.x=aP.x;
			line.y=aP.y;
			line.graphics.moveTo(0,0);
			line.graphics.lineStyle(1,0x999999);
			line.graphics.lineTo(bP.x,bP.y);
			return line;
		}
		private function angleSpr(spA:Sprite,spB:Sprite):Number{
			return Math.atan2(spB.y-spA.y,spB.x-spA.x)* 180/Math.PI;
		}
		private function angleLinePiont(angle:Number,line:Number):Point{			
			var pY:Number=line*Math.sin(angle * Math.PI/180);
			var pX:Number=line*Math.cos(angle * Math.PI/180);
			var point:Point=new Point(pX,pY);
			return point;
		}
	}
}