package com.wsascb.spriteTool
{
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import com.wsascb.bitmapEdit.filters.ColorMatrixArrays;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.display.DisplayObject;

	public class SpriteTrans
	{
		//色彩覆盖应用
		static public function ColorTrans(spr:DisplayObject,color:uint):void
		{
			var resultColorTransform:ColorTransform = new ColorTransform();
			resultColorTransform.color = color;
			spr.transform.colorTransform = resultColorTransform;
		}
		//高级自定义色彩调整
		static public function ColorAdvTrans(spr:DisplayObject,r:Number,g:Number,b:Number):void
		{
			var resultColorTransform:ColorTransform = new ColorTransform();
			resultColorTransform.redOffset = r;
			resultColorTransform.greenOffset = g;
			resultColorTransform.blueOffset = b;
			spr.transform.colorTransform = resultColorTransform;
		}
		//清楚色彩应用
		static public function removeColorTrans(spr:DisplayObject):void
		{
			var resultColorTransform:ColorTransform = new ColorTransform();
			resultColorTransform.redOffset = 0;
			resultColorTransform.greenOffset = 0;
			resultColorTransform.blueOffset = 0;
			spr.transform.colorTransform = resultColorTransform;
		}
		//灰阶滤镜应用
		static public function GraysFilter(spr:DisplayObject):void
		{
			var _sharpening:ColorMatrixFilter = new ColorMatrixFilter(ColorMatrixArrays.grayscaleArray());
			spr.filters = [_sharpening];
		}
		//发光
		static public function GlowFilter(spr:DisplayObject,color:uint = 0xFF0000, alpha:Number = 1.0, blurX:Number = 6.0, blurY:Number = 6.0, strength:Number = 2, quality:int = 1, inner:Boolean = false):void
		{
			//var _glF:GlowFilter = new GlowFilter(color,alpha,blurX,blurY,strength,quality,inner);
			//spr.filters = [_glF];
		}
		//清楚滤镜应用
		static public function removeFilter(spr:Sprite):void
		{
			spr.filters = null;
		}

	}

}