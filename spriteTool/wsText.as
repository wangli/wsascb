package com.wsascb.spriteTool{
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class wsText extends TextField {
		private var format:TextFormat = new TextFormat();
		public function wsText(str:String,size:Object=12,color:Object=0xffffff,w:int=0,h:int=0,align:String="left",bold:Object=null,html:Boolean=false) {
			format.color = color;
			format.size = size;
			format.align = align;
			format.bold = bold;
			if (html) {
				this.htmlText = str;
			} else {
				this.text = str;
			}
			if(w>0)this.width=w;
			if(h>0)this.height=h;
			this.defaultTextFormat=format;
		}

	}

}