package com.wsascb.Draw
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.geom.*;
	public class drawBase extends Sprite
	{
		/**
		//次类为一个绘制基本图形的类
		//包含矩形，带圆角矩形，圆形，椭圆形，三角形，正多边形
		//通过类当中的方法来创建，返回的是一个已经建好的Sprite对象
		//举例使用方法如下：
		var drawBase:drawBase = new drawBase();
		var new_mc1:Sprite=drawBase.ws_drawRect(100,50);
		var new_mc2:Sprite=drawBase.drawCircle(10);
		addChild(new_mc1);
		addChild(new_mc2);
		//参数说明, 打*号参数为必填内容----------------------------
		//—————矩形：ws_drawRect(*宽，*高，填充颜色，透明度,边线粗细，边线颜色)
		//———圆角矩形：ws_drawRoundRect(*宽，*高，填充颜色，圆角，透明度,边线粗细，边线颜色)
		//——————圆：ws_drawCircle(*圆半径，圆心x坐标，圆心y坐标，透明度,边线粗细，边线颜色)
		//—————椭圆：ws_drawEllipse(*椭圆在x主轴方向半径，*椭圆在y次轴坐标半径，椭圆中心x坐标，椭圆中心y坐标，透明度,边线粗细，边线颜色)
		//—————三角：ws_drawTriangle(*ab边长度，*ac边长度，重心x坐标，重心y坐标，角度，旋转度，透明度,边线粗细，边线颜色)
		//———正多边形：ws_drawRegularPolygon(*边数量，*边长，*中心x坐标，*中心y坐标，旋转度，透明度,边线粗细，边线颜色)
		**/
		private var ws_target:Sprite;
		private var ws_pointsX:Array;
		private var ws_pointsY:Array;
		private var ws_bLineStyleSet:Boolean;
		private var ws_ShapePoints:ShapePoints;

		public function drawBase(spr:Sprite=null)
		{
			if (spr != null) {
				ws_target = spr;
			} else {
				ws_target = this;
			}
		}
		private function ws_strStyle(_mc:Sprite,ws_colorm:uint,ws_alpha:Number,ws_line:Number,ws_colorl:uint):void
		{
			_mc.graphics.beginFill(ws_colorm,ws_alpha/100);
			_mc.graphics.lineStyle(ws_line,ws_colorl);
		}
		//画直线;
		public function ws_drawLine(ws_mc:Sprite,ws_x1:Number,ws_y1:Number,ws_x2:Number,ws_y2:Number,ws_line:Number=1,ws_colorl:uint=0xFFFFFF):void
		{
			//绘制对象，起始x坐标，起始y坐标，结束x坐标，结束y坐标
			ws_mc.graphics.lineStyle(ws_line,ws_colorl);
			ws_mc.graphics.moveTo(ws_x1, ws_y1);
			ws_mc.graphics.lineTo(ws_x2, ws_y2);

		}
		//画带矩形;
		public function ws_drawRect(ws_width:Number,ws_height:Number,ws_x:Number=0, ws_y:Number=0,ws_colorm:uint=0xFFFFFF,ws_alpha:Number=100,ws_line:Number=undefined,ws_colorl:uint=0xFFFFFF):Sprite
		{
			//*宽，*高，x坐标，y坐标，填充颜色，透明度,边线粗细，边线颜色；
			var ws_mc:Sprite=new Sprite();
			ws_strStyle(ws_mc,ws_colorm,ws_alpha,ws_line,ws_colorl);
			ws_mc.graphics.drawRect(ws_x,ws_y,ws_width,ws_height);
			ws_mc.graphics.endFill();
			return ws_mc;
		}
		//画带有圆角的矩形
		public function ws_drawRoundRect(ws_width:Number,ws_height:Number,ws_x:Number=0, ws_y:Number=0,ws_colorm:uint=0xFFFFFF,ws_round:Number=0,ws_alpha:Number=100,ws_line:Number=undefined,ws_colorl:uint=0xFFFFFF):Sprite
		{
			//*宽，*高，x坐标，y坐标，填充颜色，圆角，透明度,边线粗细，边线颜色；
			var ws_mc:Sprite = new Sprite  ;
			ws_strStyle(ws_mc,ws_colorm,ws_alpha,ws_line,ws_colorl);
			ws_mc.graphics.drawRoundRect(ws_x,ws_y,ws_width,ws_height,ws_round);
			ws_mc.graphics.endFill();
			return ws_mc;
		}
		//画圆
		public function ws_drawCircle(ws_radius:Number,ws_x:Number=0,ws_y:Number=0,ws_colorm:uint=0xFFFFFF,ws_alpha:Number=100,ws_line:Number=undefined,ws_colorl:uint=0xFFFFFF):Sprite
		{
			//*圆半径，圆心x坐标，圆心y坐标，透明度,边线粗细，边线颜色；
			var ws_mc:Sprite = new Sprite  ;
			ws_strStyle(ws_mc,ws_colorm,ws_alpha,ws_line,ws_colorl);
			ws_mc.graphics.drawCircle(ws_x,ws_y,ws_radius);
			ws_mc.graphics.endFill();
			return ws_mc;
		}
		//画椭圆
		public function ws_drawEllipse(ws_xRadius:Number,ws_yRadius:Number,ws_x:Number=0,ws_y:Number=0,ws_colorm:uint=0xFFFFFF,ws_alpha:Number=100,ws_line:Number=undefined,ws_colorl:uint=0xFFFFFF):Sprite
		{
			//*椭圆在x主轴方向半径，*椭圆在y次轴坐标半径，椭圆中心x坐标，椭圆中心y坐标，透明度,边线粗细，边线颜色；
			var ws_mc:Sprite = new Sprite  ;
			ws_strStyle(ws_mc,ws_colorm,ws_alpha,ws_line,ws_colorl);
			ws_mc.graphics.drawEllipse(ws_x,ws_y,ws_xRadius,ws_yRadius);
			ws_mc.graphics.endFill();
			return ws_mc;
		}
		//画三角
		public function ws_drawTriangle(ws_ab:Number,ws_ac:Number,ws_x:Number=0,ws_y:Number=0,ws_angle:Number=60,ws_rotation:Number=0,ws_colorm:uint=0xFFFFFF,ws_alpha:Number=100,ws_line:Number=undefined,ws_colorl:uint=0xFFFF00):Sprite
		{
			//*ab边长度，*ac边长度，重心x坐标，重心y坐标，角度，旋转度，透明度,边线粗细，边线颜色；
			var ws_mc:Sprite = new Sprite  ;
			ws_strStyle(ws_mc,ws_colorm,ws_alpha,ws_line,ws_colorl);
			var ws_rotation:Number = ws_rotation * Math.PI / 180;
			var ws_angle:Number = ws_angle * Math.PI / 180;
			var ws_bx:Number = Math.cos(ws_angle - ws_rotation) * ws_ab;
			var ws_by:Number = Math.sin(ws_angle - ws_rotation) * ws_ab;
			var ws_cx:Number = Math.cos( -  ws_rotation) * ws_ac;
			var ws_cy:Number = Math.sin( -  ws_rotation) * ws_ac;
			var ws_CentroidX:Number = 0;
			var ws_CentroidY:Number = 0;
			ws_drawLine(ws_mc,-ws_CentroidX + ws_x, -ws_CentroidY + ws_y, ws_cx - ws_CentroidX + ws_x, ws_cy - ws_CentroidY + ws_y,ws_line,ws_colorl);
			ws_mc.graphics.lineTo(ws_bx - ws_CentroidX + ws_x, ws_by - ws_CentroidY + ws_y);
			ws_mc.graphics.lineTo(-ws_CentroidX + ws_x, -ws_CentroidY + ws_y);

			ws_mc.graphics.endFill();
			return ws_mc;
		}
		//星形
		public function ws_star(ws_sides:int,ws_innerRadius:Number,ws_outerRadius:Number,ws_x:Number=0,ws_y:Number=0,ws_angle:Number=0,ws_colorm:uint=0xFFFFFF,ws_alpha:Number=100,ws_line:Number=undefined,ws_colorl:uint=0xFFFFFF):Sprite
		{
			//*角数量，*内角半径，*外角半径，*x坐标，*y坐标，旋转度，透明度,边线粗细，边线颜色；
			var ws_mc:Sprite = new Sprite  ;
			if (ws_sides > 2) {
				ws_strStyle(ws_mc,ws_colorm,ws_alpha,ws_line,ws_colorl);
				var centerX:Number = ws_outerRadius;
				var centerY:Number = ws_outerRadius;
				var step:Number,halfStep:Number,startAngle:Number,ws_dx:Number,ws_dy:Number;
				step=(Math.PI*2)/ws_sides;
				halfStep = step / 2;
				startAngle = (ws_angle / 180) * Math.PI;
				ws_dx=centerX+(Math.cos(startAngle)*ws_outerRadius)+ws_x;
				ws_dy=centerY+(Math.sin(startAngle)*ws_outerRadius)+ws_y;
				ws_mc.graphics.moveTo(ws_dx, ws_dy);
				for (var i:int=1; i<=ws_sides; i++) {
					ws_dx=centerX+Math.cos(startAngle+(step*i)-halfStep)*ws_innerRadius+ws_x;
					ws_dy=centerY-Math.sin(startAngle+(step*i)-halfStep)*ws_innerRadius+ws_y;
					ws_mc.graphics.lineTo(ws_dx, ws_dy);

					ws_dx=centerX+Math.cos(startAngle+(step*i))*ws_outerRadius+ws_x;
					ws_dy=centerY-Math.sin(startAngle+(step*i))*ws_outerRadius+ws_y;
					ws_mc.graphics.lineTo(ws_dx, ws_dy);
				}
				ws_mc.graphics.endFill();
			}
			return ws_mc;
		}
		//画正多边形
		public function ws_drawRegularPolygon(ws_sides:Number,ws_length:Number,ws_x:Number=0,ws_y:Number=0,ws_rotation:Number=0,ws_colorm:uint=0xFFFFFF,ws_alpha:Number=100,ws_line:Number=undefined,ws_colorl:uint=0xFFFFFF):Sprite
		{
			//*边数量，*边长，*x坐标，*y坐标，旋转度，透明度,边线粗细，边线颜色；
			var ws_mc:Sprite = new Sprite  ;
			if (ws_sides > 2) {
				ws_strStyle(ws_mc,ws_colorm,ws_alpha,ws_line,ws_colorl);
				var ws_rotation:Number = ws_rotation * Math.PI / 180;
				var ws_angle:Number = (2 * Math.PI) / ws_sides;
				var ws_radius:Number = (ws_length/2)/Math.sin(ws_angle/2);
				var ws_px:Number = (Math.cos(ws_rotation) * ws_radius) + ws_x;
				var ws_py:Number = (Math.sin(ws_rotation) * ws_radius) + ws_y;
				ws_mc.graphics.moveTo(ws_px, ws_py);
				for (var i:Number = 1; i <= ws_sides; i++) {
					ws_px = (Math.cos((ws_angle * i) + ws_rotation) * ws_radius) + ws_x;
					ws_py = (Math.sin((ws_angle * i) + ws_rotation) * ws_radius) + ws_y;
					ws_mc.graphics.lineTo(ws_px, ws_py);
				}
				ws_mc.graphics.endFill();
			}
			return ws_mc;
		}
		//画扇形
		public function ws_drawFan(ws_x:Number=200,ws_y:Number=200,r:Number=100,ws_angle:Number=127,start_angle:Number=270,color:Number=0xFFFFFF,ws_alpha:Number=100):Sprite
		{
			//*圆心X点，*圆心Y点，*半径，*扇形角度，*开始所在圆角度，颜色，透明度
			var ws_mc:Sprite = new Sprite  ;
			ws_mc.graphics.beginFill(color,ws_alpha/100);
			ws_mc.graphics.moveTo(ws_x,ws_y);
			var angle=(Math.abs(ws_angle)>360)?360:ws_angle;
			var n:Number = Math.ceil(Math.abs(angle) / 45);
			var angleA:Number = angle / n;
			angleA = angleA * Math.PI / 180;
			var startFrom = start_angle * Math.PI / 180;
			ws_mc.graphics.lineTo(ws_x+r*Math.cos(startFrom),ws_y+r*Math.sin(startFrom));
			for (var i=1; i<=n; i++) {
				startFrom +=  angleA;
				var angleMid = startFrom - angleA / 2;
				var bx=ws_x+r/Math.cos(angleA/2)*Math.cos(angleMid);
				var by=ws_y+r/Math.cos(angleA/2)*Math.sin(angleMid);
				var cx = ws_x + r * Math.cos(startFrom);
				var cy = ws_y + r * Math.sin(startFrom);
				ws_mc.graphics.curveTo(bx,by,cx,cy);
			}
			if (angle!=360) {
				ws_mc.graphics.lineTo(ws_x,ws_y);
			}
			ws_mc.graphics.endFill();
			return ws_mc;
		}
		//弧线;
		public function drawArc(nX:Number, nY:Number, nRadius:Number, nArc:Number, nStartingAngle:Number = 0, bRadialLines:Boolean = false):void
		{
			if (nArc > 360) {
				nArc = 360;
			}
			nArc = Math.PI / 180 * nArc;
			var nAngleDelta:Number = nArc / 8;
			var nCtrlDist:Number = nRadius / Math.cos(nAngleDelta / 2);

			nStartingAngle *=  Math.PI / 180;

			var nAngle:Number = nStartingAngle;
			var nCtrlX:Number;
			var nCtrlY:Number;
			var nAnchorX:Number;
			var nAnchorY:Number;

			var nStartingX:Number = nX + Math.cos(nStartingAngle) * nRadius;
			var nStartingY:Number = nY + Math.sin(nStartingAngle) * nRadius;

			if (bRadialLines) {
				moveTo(nX, nY);
				lineTo(nStartingX, nStartingY);
			} else {
				moveTo(nStartingX, nStartingY);
			}
			for (var i:Number = 0; i < 8; i++) {
				nAngle +=  nAngleDelta;
				nCtrlX = nX + Math.cos(nAngle-(nAngleDelta/2))*(nCtrlDist);
				nCtrlY = nY + Math.sin(nAngle-(nAngleDelta/2))*(nCtrlDist);
				nAnchorX = nX + Math.cos(nAngle) * nRadius;
				nAnchorY = nY + Math.sin(nAngle) * nRadius;
				curveTo(nCtrlX, nCtrlY, nAnchorX, nAnchorY);
			}
			if (bRadialLines) {
				lineTo(nX, nY);
			}
		}
		public function moveTo(nX:Number, nY:Number):void
		{
			ws_target.graphics.moveTo(nX, nY);
		}

		public function lineTo(nX:Number, nY:Number):void
		{
			if (! ws_bLineStyleSet) {
				ws_strStyle(ws_target,0x000000,1,0,0x000000);
			}
			ws_target.graphics.lineTo(nX, nY);
		}

		public function curveTo(nCtrlX:Number, nCtrlY:Number, nAnchorX:Number, nAnchorY:Number):void
		{
			if (! ws_bLineStyleSet) {
				ws_strStyle(ws_target,0x000000,1,0,0x000000);
			}
			ws_target.graphics.curveTo(nCtrlX, nCtrlY, nAnchorX, nAnchorY);
		}
		public function ws_free(_target:Sprite,ws_x:Number=0,ws_y:Number=0,ws_colorm:uint=0xFFFFFF,ws_alpha:Number=50,ws_line:Number=0,ws_colorl:uint=0xFFFFFF):void
		{
			ws_target = _target;
			/* ws_target.graphics.lineStyle(ws_line,ws_colorl); */
			ws_strStyle(ws_target,ws_colorm,ws_alpha,ws_line,ws_colorl);
			ws_target.addEventListener(MouseEvent.MOUSE_DOWN,init_draw);
		}
		private function init_draw(evt:MouseEvent):void
		{
			/* ws_pointsX=new Array();
			ws_pointsY=new Array();
			ws_pointsX.push(evt.localX);
			ws_pointsX.push(evt.localY); */
			ws_target.graphics.moveTo(evt.localX,evt.localY);
			ws_target.addEventListener(MouseEvent.MOUSE_MOVE,start_draw);
			ws_target.addEventListener(MouseEvent.MOUSE_UP,sotp_draw);
		}
		private function start_draw(evt:MouseEvent):void
		{
			ws_target.graphics.lineTo(evt.localX, evt.localY);
			/* ws_pointsX.push(evt.localX);
			ws_pointsX.push(evt.localY); */
			evt.updateAfterEvent();
		}
		private function sotp_draw(evt:MouseEvent):void
		{

			/* if(ws_pointsX!=null||ws_pointsY!=null){
			ws_target.graphics.beginFill(0xFFFFFF,0.5);
			var poingsLength:Number=ws_pointsX.length;
			for(var i:int;i<poingsLength;i++){
			ws_target.graphics.lineTo(ws_pointsX[i],ws_pointsY[i])
			}
			ws_target.graphics.endFill();
			}
			trace(ws_pointsX.length); */
			ws_target.removeEventListener(MouseEvent.MOUSE_DOWN,init_draw);
			ws_target.removeEventListener(MouseEvent.MOUSE_MOVE,start_draw);
			ws_target.removeEventListener(MouseEvent.MOUSE_UP,sotp_draw);
		}
		public function clearGraphics(_spr:Sprite=null):void
		{
			if (_spr != null) {
				_spr.graphics.clear();
			} else {
				ws_target.graphics.clear();
			}
		}
	}
}