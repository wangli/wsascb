package com.wsascb.bitmapEdit.filters{
	public class ColorMatrixArrays {
		protected static var lumR:Number = 0.212671; //Red constant - used for a few color matrix filter functions
		protected static var lumG:Number = 0.715160; //Green constant - used for a few color matrix filter functions
		protected static var lumB:Number = 0.072169; //Blue constant - used for a few color matrix filter functions
		//灰度
		public static function grayscaleArray():Array {
			return [0.3086,0.6094,0.0820,0,0,0.3086,0.6094,0.0820,0,0,0.3086,0.6094,0.0820,0,0,0,0,0,1,0];
		}
		//数码负片
		public static function negativeArray():Array {
			return [-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0];

		}
		//饱和度nValue范围0到3
		public static function saturationArray(nValue:Number):Array {
			var nRed:Number = 0.3086;
			var nGreen:Number = 0.6094;
			var nBlue:Number = 0.0820;
			var nA:Number = (1 - nValue) * nRed + nValue;
			var nB:Number = (1 - nValue) * nGreen;
			var nC:Number = (1 - nValue) * nBlue;
			var nD:Number = (1 - nValue) * nRed;
			var nE:Number = (1 - nValue) * nGreen + nValue;
			var nF:Number = (1 - nValue) * nBlue;
			var nG:Number = (1 - nValue) * nRed;
			var nH:Number = (1 - nValue) * nGreen;
			var nI:Number = (1 - nValue) * nBlue + nValue;
			return [nA,nB,nC,0,0,nD,nE,nF,0,0,nG,nH,nI,0,0,0,0,0,1,0];
		}
		//亮度nValue范围-255到255
		public static function brightnessArray(nValue:Number):Array {
			return [1,0,0,0,nValue,0,1,0,0,nValue,0,0,1,0,nValue,0,0,0,1,nValue];

		}
		//对比度nValue范围-100到100
		public static function contrastArray(nValue:Number):Array {
			var nScale:Number = 1+nValue/200;
			var nOffset:Number = -nValue/2;
			return [nScale,0,0,0,nOffset,0,nScale,0,0,nOffset,0,0,nScale,0,nOffset,0,0,0,1,0];
		}
		//调整色相nValue范围-180到180
		public static function hueArray(nValue:Number):Array {
			nValue = Math.min(180,Math.max(-180,nValue))/180*Math.PI;
			var cosVal:Number = Math.cos(nValue);
			var sinVal:Number = Math.sin(nValue);
			var HueMatrix: Array=[
			                lumR+cosVal*(1-lumR)+sinVal*(-lumR),lumG+cosVal*(-lumG)+sinVal*(-lumG),lumB+cosVal*(-lumB)+sinVal*(1-lumB),0,0,
			                lumR+cosVal*(-lumR)+sinVal*(0.143),lumG+cosVal*(1-lumG)+sinVal*(0.140),lumB+cosVal*(-lumB)+sinVal*(-0.283),0,0,
			                lumR+cosVal*(-lumR)+sinVal*(-(1-lumR)),lumG+cosVal*(-lumG)+sinVal*(lumG),lumB+cosVal*(1-lumB)+sinVal*(lumB),0,0,
			                0,0,0,1,0
			                    ];
			return HueMatrix;
		}
		//着色
		public static function colorize( nValue:Number, amount:Number = 1):Array {
			if (isNaN(amount)) {
				amount = 1;
			}
			var r:Number = ((nValue >> 16) & 0xff) / 255;
			var g:Number = ((nValue >> 8)  & 0xff) / 255;
			var b:Number = (nValue & 0xff) / 255;
			var inv:Number = 1 - amount;
			var temp:Array =  [inv + amount * r * lumR, amount * r * lumG,        amount * r *lumB,        0, 0,
							  amount * g * lumR,        inv + amount * g * lumG,  amount * g *lumB,        0, 0,
							  amount * b * lumR,        amount * b *lumG,         inv + amount * b * lumB, 0, 0,
							  0, 				          0, 					     0, 		           1, 0];
			//trace(temp);
			return temp;
		}
		public static function hueAdvArray():Array{
			return null
		}
	}
}