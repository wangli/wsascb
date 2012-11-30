package com.wsascb.assistant
{
	import flash.text.TextFormat;
	
	public class FormatText extends TextFormat
	{
		public function FormatText(font:String="Verdana", size:Object=12, color:Object=null, bold:Object=null, italic:Object=null, underline:Object=null, url:String=null, target:String=null, align:String="left", leftMargin:Object=null, rightMargin:Object=null, indent:Object=null, leading:Object=null)
		{
			super(font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
		}
	}
}