package com.wsascb.Position{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class DyPoint {
		private var ws_target:DisplayObject;
		private var ws_point:Point;
		private var ws_Matrix:Matrix;
		
		public function DyPoint(target:DisplayObject, registrationPoint:Point=null) {
			this.ws_target=target;
			this.ws_Matrix=new Matrix();
			setRegistrationPoint(registrationPoint);
		}
		public function setRegistrationPoint(registrationPoint:Point=null):void {
			if (registrationPoint!=null) {
				this.ws_point=registrationPoint;
			}
			var tx:Number=this.ws_point.x;
			var ty:Number=this.ws_point.y;
			this.ws_Matrix.translate(tx,ty);
			this.ws_target.transform.matrix=this.ws_Matrix;
			//this.ws_target.x-=tx;
			//this.ws_target.y-=ty;
		}
	}
}