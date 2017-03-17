package com.wsascb.spriteTool
{
	import flash.display.DisplayObject;

	public class Zoom
	{
		public static function execute(_mc:DisplayObject,mcWidth:Number,mcHeight:Number,zoomFill:Boolean=true){			
			var _bfb_w:Number = mcWidth / _mc.width;
			var _bfb_h:Number = mcHeight / _mc.height;			
			if(mcWidth==0){
				_mc.height=mcHeight;
				_mc.width=_mc.width*_bfb_h;
			}else if(mcHeight==0){
				_mc.width=mcWidth;
				_mc.height=_mc.height*_bfb_w;
			}else{
				//是否填满
				if(zoomFill){
					if (_bfb_w > _bfb_h) {
						_mc.width = mcWidth;
						_mc.height = _mc.height * _bfb_w;
					} else {
						_mc.height = mcHeight;
						_mc.width = _mc.width * _bfb_h;
					}
				}else{
					if (_bfb_w < _bfb_h) {
						_mc.width = mcWidth;
						_mc.height = _mc.height * _bfb_w;
					} else {
						_mc.height = mcHeight;
						_mc.width = _mc.width * _bfb_h;
					}
				}
			}
		}
	}
}