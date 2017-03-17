package com.wsascb.utils.DataBind
{
	import flash.utils.Dictionary;
	public class BindManager
	{
		public static var valueDic:Dictionary = new Dictionary();
		public static function registBindableObject(obj:*,property:String,value:BindableObject):void
		{
			if (value.property != null)
			{
				obj[property] = value.property;
			}
			if (valueDic[value] == null)
			{
				valueDic[value] = [];
			}
			valueDic[value].push(new InnerBindableObject(obj,property));
		}
		public static function unlockBindableObject(obj:*,property:String,value:BindableObject):void
		{
			if (value != null)
			{
				var needCheckObjs:Array = valueDic[value];
				for each (var item:InnerBindableObject in needCheckObjs)
				{
					if (obj == item.obj && property == item.property)
					{
						var index:int = needCheckObjs.indexOf(item);
						if (index != -1)
						{
							needCheckObjs.splice(index,1);
						}
					}
				}
			}
		}
		public static function refresh(value:BindableObject = null):void
		{
			if (value != null)
			{
				var needRefObjs:Array = valueDic[value];
				for each (var item:InnerBindableObject in needRefObjs)
				{
					if (item.obj != null)
					{
						item.obj[item.property] = value.property;
					}
				}
			}
		}
	}
}