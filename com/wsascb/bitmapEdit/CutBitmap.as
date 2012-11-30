package com.wsascb.bitmapEdit
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class CutBitmap
	{
		public static function outSuper( target:DisplayObject, template:DisplayObject, isAnti:Boolean = false ):BitmapData
		{
			var rectTarget:Rectangle = target.transform.pixelBounds;
			var rectTemplate:Rectangle = template.transform.pixelBounds;
			var targetBitmapData:BitmapData = outRect(target,rectTarget.width,rectTarget.height,0,0,true,0x00000000);
			var templateBitmapData:BitmapData = outRect(template,rectTemplate.width,rectTemplate.height,0,0,true,0x00000000);
			for (var pixelY:int = 0; pixelY < rectTemplate.height; pixelY++)
			{
				for (var pixelX:int = 0; pixelX < rectTemplate.width; pixelX++)
				{
					var tempColor32:uint = templateBitmapData.getPixel32(pixelX,pixelY);
					var targetColor32:uint = targetBitmapData.getPixel32( pixelX + rectTemplate.x - rectTarget.x, pixelY + rectTemplate.y - rectTarget.y );
					if ( tempColor32 != 0 )
					{
						if (isAnti)
						{
							var tempAlpha:uint = tempColor32 >> 24 & 0xFF;
							var targetRGB:uint = targetColor32 & 0xFFFFFF;
							templateBitmapData.setPixel32( pixelX, pixelY, tempAlpha << 24 | targetRGB );
						}
						else
						{
							templateBitmapData.setPixel32( pixelX, pixelY, targetColor32 );
						}
					}
				}
			}
			return templateBitmapData;
		}
		public static function outRect( target:DisplayObject, width:Number, height:Number, distanceX:Number, distanceY:Number, transparent:Boolean = true, fillColor:uint = 0x00000000 ):BitmapData
		{
			var m:Matrix = target.transform.matrix;
			m.tx -=  target.getBounds(target.parent).x + distanceX;
			m.ty -=  target.getBounds(target.parent).y + distanceY;
			var bmpData:BitmapData = new BitmapData(width,height,transparent,fillColor);
			bmpData.draw( target, m );
			return bmpData;
		}
	}
}