package com.wsascb.spriteTool
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.display.Sprite;

	public class Mcopy
	{
		static public function disObj(target:DisplayObject):DisplayObject
		{
			var targetClass:Class = Object(target).constructor;
			var _disObj:DisplayObject = new targetClass  ;
			_disObj.transform = target.transform;
			_disObj.filters = target.filters;
			_disObj.cacheAsBitmap = target.cacheAsBitmap;
			_disObj.opaqueBackground = target.opaqueBackground;
			return _disObj;
		}
	}
}