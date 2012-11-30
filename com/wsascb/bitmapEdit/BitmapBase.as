package com.wsascb.bitmapEdit{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.*;

	import com.wsascb.Draw.drawBase;
	import com.wsascb.Draw.dyDrawBase;
	import com.wsascb.Position.Rotator;
	/**
	 * 基本功能：图像的缩放、裁切、旋转
	 **/
	public class BitmapBase {
		private var ws_bmpData:BitmapData;
		private var ws_bmpObj:Bitmap;
		private var ws_temObj:Bitmap;
		private var ws_target:DisplayObject;
		private var ws_widthObj:Number;
		private var ws_heightObj:Number;
		private var ws_point:Point;
		private var ws_matrix:Matrix;
		private var ws_matrix2:Matrix;
		private var ws_rotator:Rotator;
		private var ws_dyDrawBase:dyDrawBase;
		private var ws_drawBase:drawBase;
		//裁切所创建的相关元素
		private var ws_cutMask:Sprite;
		private var _target:Sprite;

		public function BitmapBase(disObj:DisplayObject) {
			if (disObj != null) {
				ws_target=disObj;
				if (ws_target is Bitmap) {
					var _Bitmap:Bitmap=Bitmap(ws_target);
					ws_bmpData=_Bitmap.bitmapData.clone();
					ws_bmpObj=_Bitmap;
				} else {
					DisplayObject(ws_bmpObj);
				}
				ws_widthObj=disObj.width;
				ws_heightObj=disObj.height;
			}
		}
		//----------缩放----------
		public function zoomBitmap(sx:Number,sy:Number):void {
			if (sx > 0 && sy > 0) {
				var _sx:Number=sx;
				var _sy:Number=sy;
				ws_matrix=new Matrix  ;
				ws_matrix.translate(- ws_widthObj / 2,- ws_heightObj / 2);
				ws_matrix.scale(_sx,_sy);
				ws_matrix.translate(ws_widthObj / 2,ws_heightObj / 2);
				transform();
			}
		}
		//裁切对象
		public function cutBitmap(drawSp:Sprite,point:Point):void {
			var _recW:Number=drawSp.width;
			var _recH:Number=drawSp.height;
			var _bmpData:BitmapData=new BitmapData(_recW,_recH,ws_bmpData.transparent);
			var _rect:Rectangle=new Rectangle(point.x,point.y,_recW,_recH);
			var _point:Point=new Point  ;
			_bmpData.copyPixels(this.ws_bmpData,_rect,_point);
			this.ws_bmpObj.bitmapData=_bmpData;
			this.ws_bmpObj.alpha=1;
			this.ws_bmpObj.x=_rect.x;
			this.ws_bmpObj.y=_rect.y;
		}
		//----------旋转----------
		public function angleBitmap(angle:Number):void {
			var _angle:Number=2 * Math.PI * angle / 360;
			ws_matrix=new Matrix  ;
			ws_matrix.translate(- ws_widthObj / 2,- ws_heightObj / 2);
			ws_matrix.rotate(_angle);
			ws_matrix.translate(ws_widthObj / 2,ws_heightObj / 2);
			transform();
		}
		//----------执行----------
		private function transform():void {
			ws_bmpObj.transform.matrix=ws_matrix;
			if (ws_bmpObj is Bitmap) {
				var _temObj:Bitmap=Bitmap(ws_bmpObj);
				_temObj.smoothing=true;
			}
		}
	}
}