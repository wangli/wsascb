package com.wsascb.bitmapEdit.filters{
	public class ConvolutionMatrixArrays {
		//锐化
		public static function sharpeningArray(_extent:Number=1):Array {
			trace(_extent);
			var _myFilters:Array=[0, -_extent, 0,-_extent, _extent * 4+1, -_extent,0, -_extent, 0];
			return _myFilters;
		}
		//浮雕
		public static function embossingArray(_extent:Number=1):Array {
			_extent=(_extent>100)?100:_extent;
			_extent=(_extent<1)?1:_extent;
			var _nx:Number=_extent/50;
			var _myFilters:Array=[ 0, -_nx, 0, 0, 0, 0, 0, _nx, 0 ];
			return _myFilters;
		}
		//检测边缘
		public static function detectEdgeArray(_extent:Number=1):Array {
			var _nx:Number=_extent/100;
			var _myFilters:Array=[0, 1, 0, 1, -4, 1, 0, 1, 0];
			return _myFilters;

		}
	}
}