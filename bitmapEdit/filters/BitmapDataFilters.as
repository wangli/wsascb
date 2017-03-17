package com.wsascb.bitmapEdit.filters
{
    import flash.display.BitmapData;
	import flash.display.DisplayObject;
    import flash.filters.BitmapFilter;
    import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Matrix;
	import flash.geom.Point;
	public class BitmapDataFilters
	{
		//素描效果
		public static function sketchFilter( source:BitmapData, threshold:Number = 5 ):BitmapData
		{
			var color:uint = 0;
			var gray1:uint = 0;
			var gray2:uint = 0;
			
			var returnBitmapData:BitmapData = source.clone();
			
			for( var i:int = 0; i < source.height - 1; i++ )
			{
				for( var j:int = 0; j < source.width - 1; j++ )
				{
					color = returnBitmapData.getPixel( j, i );
					gray1 = (color & 0xff0000) >> 16;
					color = returnBitmapData.getPixel( j + 1, i + 1 );
					gray2 = (color & 0xff0000) >> 16;
					
					if( Math.abs( gray1 - gray2 ) >= threshold )
					{
						returnBitmapData.setPixel( j, i, 0x222222 );
					} else
					{
						returnBitmapData.setPixel( j, i, 0xFFFFFF );
					}
				}
			}
			
			return returnBitmapData;
			
		}
		// 水彩效果
		public static function waterColorFilter( source:BitmapData, scaleX:Number = 5, scaleY:Number = 5 ):BitmapData
		{
			var returnBitmapData:BitmapData = source.clone();
			
			var tempBitmapData:BitmapData = new BitmapData( source.width, source.height, true, 0x00FFFFFF );
			tempBitmapData.perlinNoise( 3, 3, 1, 1, false, true, 1, false );
			
			var filter:DisplacementMapFilter = new DisplacementMapFilter( tempBitmapData, new Point( 0, 0 ), 1, 1, scaleX, scaleY, DisplacementMapFilterMode.COLOR, 0x000000, 0x000000 );
			returnBitmapData.applyFilter( returnBitmapData, returnBitmapData.rect, new Point( 0, 0 ), filter );
			
			return returnBitmapData;
			
		}
		//马赛克
		public static function mosaicFilter2( source:DisplayObject, scale:Number ):BitmapData
		{
			var tempBitmapData:BitmapData;
			var returnBitmapData:BitmapData = new BitmapData( source.width, source.height, true, 0x00000000);
			
			// 确保 scale 的范围在：[0.00001, 1]
			scale = Math.min( 1, Math.max( 0.0001, scale ) );
			
			if( scale == 0.0001 )
			{
				tempBitmapData = new BitmapData( 1, 1, true, 0x00000000 );
			}else
			{
				tempBitmapData = new BitmapData( Math.ceil( source.width * scale ), Math.ceil( source.height * scale ), true, 0x00000000 );
			}
			
			var m:Matrix = source.transform.matrix;
			m.scale( scale, scale );
			tempBitmapData.draw( source, m );
			
			m.a = m.d = 1 / scale;
			returnBitmapData.draw( tempBitmapData, m );
			tempBitmapData.dispose();
			
			return returnBitmapData;
		}
	}
}