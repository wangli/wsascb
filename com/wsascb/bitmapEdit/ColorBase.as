/**将目标对象的一个(RGB)颜色的色相转换为两一个颜色的色相，但是其亮度和饱和度不变，并返回其颜色RGB值**/
package com.wsascb.bitmapEdit
{
	import com.wsascb.bitmapEdit.*;
	public class ColorBase
	{
		public function ColorBase()
		{
		}
		//将目标对象的一个(RGB)颜色的色相转换为两一个颜色的色相，但是其亮度和饱和度不变，并返回其颜色RGB值
		public static function setColorHsb(aRgb:uint,newHsbRgb:uint):uint{
			//获取对象的RGB颜色值并分割成RGB独立值
			//将对象的RGB值转换为HSB值数组
			var alphaValue:uint = aRgb >> 24 & 0xFF;
			var red:uint = aRgb >> 16 & 0xFF;
			var green:uint = aRgb >> 8 & 0xFF;
			var blue:uint = aRgb & 0xFF;
			var hsb:Array=colorValueTransform.rgbtohsb(red,green,blue);
			//将引用的RGB颜色值并分割成RGB独立值
			//将引用的RGB色彩转换为HSB值数组
			var nalphaValue:uint = newHsbRgb >> 24 & 0xFF;
			var nred:uint = newHsbRgb >> 16 & 0xFF;
			var ngreen:uint = newHsbRgb >> 8 & 0xFF;
			var nblue:uint = newHsbRgb & 0xFF;
			var newHsb:Array=colorValueTransform.rgbtohsb(nred,ngreen,nblue)
			//trace(nred);
			//重组新的HSB值并转换为RGB值数组
			var newRGB:Array=colorValueTransform.hsbtorgb(newHsb[0],hsb[1],hsb[2]);
			//var newrgb:uint=newRGB[0].toString(16)<<16|newRGB[1].toString(16)<<8|newRGB[2].toString(16)
			//trace(newHsb);
			//获取新RGB值转换为十六进制字符串值
			//trace("rgb:"+newrgb);
			var _rgb16:String="0x"+fuling(alphaValue)+fuling(newRGB[0])+fuling(newRGB[1])+fuling(newRGB[2]);
			return uint(_rgb16);
		}
		private static function fuling(_val:Number):String{
			if(_val<16){
				//trace(_val.toString(16).toString());
				return "0"+_val.toString(16);
			}else{
				//trace("---------"+_val.toString(16))
				return _val.toString(16);
			}
		}
	}
}