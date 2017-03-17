package com.wsascb.utils.DataBind
{

	public class InnerBindableObject
	{
		public var obj:*;
		public var property:String;

		public function InnerBindableObject(o:*,p:String):void
		{
			obj = o;
			property = p;
		}
	}
}