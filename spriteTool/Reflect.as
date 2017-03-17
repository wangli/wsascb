
//import com.pixelfumes.reflect.*;
//var r1 = new Reflect({mc:ref_mc, alpha:84, ratio:143, distance:10, updateTime:0, reflectionDropoff:0});
package com.wsascb.spriteTool{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	public class Reflect extends MovieClip{
		private static var VERSION:String = "4.0";
		private var mc:Sprite;
		private var mcBMP:BitmapData;
		private var reflectionBMP:Bitmap;
		private var gradientMask_mc:MovieClip;
		private var updateInt:Number;
		private var bounds:Object;
		private var distance:Number = 0;
	
	
		function Reflect(args:Object){
			mc = args.mc;
			var alpha:Number = args.alpha/100;
			var ratio:Number = args.ratio;
			var updateTime:Number = args.updateTime;
			var reflectionDropoff:Number = args.reflectionDropoff;
			var distance:Number = args.distance;
			var mcHeight:Number = mc.height;
			var mcWidth:Number = mc.width;
			bounds = new Object();
			bounds.width = mcWidth;
			bounds.height = mcHeight;
			//建立一个新的图像数据对象
			mcBMP = new BitmapData(bounds.width, bounds.height, true, 0xFFFFFF);
			//填充图像数据内容
			mcBMP.draw(mc);
			//建立一个新图像
			reflectionBMP = new Bitmap(mcBMP);
			//设置新图像垂直缩放比例
			reflectionBMP.scaleY = -1;
			//设置新图像Y坐标为目标倒影对象的两倍高加上倒影距离目标对象的Y轴距离
			reflectionBMP.y = (bounds.height*2) + distance;
			//添加倒影到目标对象中，并起名称reflectionBMP
			var reflectionBMPRef:DisplayObject = mc.addChild(reflectionBMP);
			reflectionBMPRef.name = "reflectionBMP";
			//建立一个新的倒影的遮罩对象
			var gradientMaskRef:DisplayObject = mc.addChild(new MovieClip());
			gradientMaskRef.name = "gradientMask_mc";
			//返回目遮罩对象
			gradientMask_mc = mc.getChildByName("gradientMask_mc") as MovieClip;
			//设置填充对象的相关属性
			var fillType:String = GradientType.LINEAR;
		 	var colors:Array = [0xFFFFFF, 0xFFFFFF];
		 	var alphas:Array = [alpha, 0];
		  	var ratios:Array = [0, ratio];
			var spreadMethod:String = SpreadMethod.PAD;
		  	var matr:Matrix = new Matrix();
			var matrixHeight:Number;
			if (reflectionDropoff<=0) {
				matrixHeight = bounds.height;
			} else {
				matrixHeight = bounds.height/reflectionDropoff;
			}
			matr.createGradientBox(bounds.width, matrixHeight, (90/180)*Math.PI, 0, 0);
			gradientMask_mc.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
		    gradientMask_mc.graphics.drawRect(0,0,bounds.width,bounds.height);
			gradientMask_mc.y = mc.getChildByName("reflectionBMP").y - mc.getChildByName("reflectionBMP").height;
			gradientMask_mc.cacheAsBitmap = true;
			mc.getChildByName("reflectionBMP").cacheAsBitmap = true;
			mc.getChildByName("reflectionBMP").mask = gradientMask_mc;
			
			if(updateTime > -1){
				updateInt = setInterval(update, updateTime, mc);
			}
		}
		
		
		public function setBounds(w:Number,h:Number):void{
			bounds.width = w;
			bounds.height = h;
			gradientMask_mc.width = bounds.width;
			redrawBMP(mc);
		}
		public function redrawBMP(mc:Sprite):void {
			mcBMP.dispose();
			mcBMP = new BitmapData(bounds.width, bounds.height, true, 0xFFFFFF);
			mcBMP.draw(mc);
		}
		private function update(mc:DisplayObject):void {
			mcBMP = new BitmapData(bounds.width, bounds.height, true, 0xFFFFFF);
			mcBMP.draw(mc);
			reflectionBMP.bitmapData = mcBMP;
		}
		public function destroy():void{
			mc.removeChild(mc.getChildByName("reflectionBMP"));
			reflectionBMP = null;
			mcBMP.dispose();
			clearInterval(updateInt);
			mc.removeChild(mc.getChildByName("gradientMask_mc"));
		}
	}
}