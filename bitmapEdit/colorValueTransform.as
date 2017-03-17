/**HSB与RGB之间的值十进制值转换
***RGB转CMYK的值
**/
package com.wsascb.bitmapEdit{
	public class colorValueTransform {
		//HSB(色相饱和明度)转换RGB
		public static function hsbtorgb(hue:Number,saturation:Number,brightness:Number):Array {
			var red:Number, green:Number, blue:Number;
			hue%=360;
			if (brightness==0) {
				return [0,0,0];
			}
			saturation/=100;
			brightness/=100;
			hue/=60;
			var i:Number = Math.floor(hue);
			var f:Number = hue-i;
			var p:Number = brightness*(1-saturation);
			var q:Number = brightness*(1-(saturation*f));
			var t:Number = brightness*(1-(saturation*(1-f)));
			switch (i) {
				case 0 :
					red=brightness;
					green=t;
					blue=p;
					break;
				case 1 :
					red=q;
					green=brightness;
					blue=p;
					break;
				case 2 :
					red=p;
					green=brightness;
					blue=t;
					break;
				case 3 :
					red=p;
					green=q;
					blue=brightness;
					break;
				case 4 :
					red=t;
					green=p;
					blue=brightness;
					break;
				case 5 :
					red=brightness;
					green=p;
					blue=q;
					break;
			}
			red=Math.round(red*255);
			green=Math.round(green*255);
			blue=Math.round(blue*255);
			return [red,green,blue];
		}
		//RGB转HSB
		public static function rgbtohsb(red:Number,green:Number,blue:Number):Array {
			var min:Number=Math.min(Math.min(red,green),blue);
			var brightness:Number=Math.max(Math.max(red,green),blue);
			var delta:Number=brightness-min;
			var saturation:Number=(brightness == 0) ? 0 : delta/brightness;
			var hue:Number;
			if (saturation == 0) {
				hue=0;
			} else {
				if (red == brightness) {
					hue=(60*(green-blue))/delta;
				} else if (green == brightness) {
					hue=120+(60*(blue-red))/delta;
				} else {
					hue=240+(60*(red-green))/delta;
				}
				if (hue<0) {
					hue+=360;
				}
			}
			saturation*=100;
			brightness=(brightness/255)*100;
			return [hue,saturation,brightness];
		}
		//RGB转换为CMYK
		public static function rgbtocmyk(red:Number, green:Number, blue:Number,rep_v:Number=0):Array {
			var cyan:Number = 255-red;
			var magenta:Number = 255-green;
			var yellow:Number = 255-blue;
			var temp2:Number,rep_k:Number,rep_c:Number,rep_m:Number,rep_y:Number;
			if (rep_v >= 0) {
				var temp:Number = Math.min(Math.min(cyan, magenta), yellow);
				if (temp != 0) {
					temp2 = Math.round((rep_v/100)*temp);
					rep_k = Math.round((temp2/255)*100);
					rep_c = Math.round(((cyan-temp2)/255)*100);
					rep_m = Math.round(((magenta-temp2)/255)*100);
					rep_y = Math.round(((yellow-temp2)/255)*100);
				} else {
					rep_c = Math.round((cyan/255)*100);
					rep_m = Math.round((magenta/255)*100);
					rep_y = Math.round((yellow/255)*100);
					rep_k = 0;
				}
			}
			return [rep_c,rep_m,rep_y,rep_k];
		}
		//CMYK转RGB
		public static function cmyktorgb(cyan:Number,magenta:Number,yellow:Number,black:Number):Array{
			  var r:Number=255*(100-cyan)*(100-black)/10000;   
  			  var g:Number=255*(100-magenta)*(100-black)/10000;   
    		  var b:Number=255*(100-yellow)*(100-black)/10000;   
    		  return [r,g,b]
		}
	}
}