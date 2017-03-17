package com.wsascb.utils.DataBind
{
	public class BindableObject
	{
		public var bindProperty:*;
		public function BindableObject(value:* = null):void
		{
			bindProperty = value;
		}
		public function set property(p:*):void
		{
			bindProperty = p;
			BindManager.refresh(this);
		}
		public function get property():*
		{
			return bindProperty;
		}
		public function bind(obj:*,property:String):void
		{
			BindManager.registBindableObject(obj,property,this);
		}
		public function unlock(obj:*,property:String):void
		{
			BindManager.unlockBindableObject(obj,property,this);
		}
	}
}