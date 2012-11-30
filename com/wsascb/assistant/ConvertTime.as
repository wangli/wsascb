//时间格式转换
//用户时间转秒数   01:01:01-->3661  
//秒数转用户时间   3661-->0.:01:01


package com.wsascb.assistant
{
	public class ConvertTime
	{
		public static function getUserTime(t : Number,seType:uint=1) : String//格式化时间处理函数
		{
			var s : Number = Math.floor(t);//取整数
			var hour : Number = int(s/3600);//取小时
			var minute : Number = int((s-hour*3600)/60);//取分钟
			var second : Number = s-hour*3600-minute*60;//取秒
			var p : Number = Math.round( ( t - s ) * 1000 );//取毫秒
			var str:String="";
			switch(seType){
				case 1:
					str=padStr(hour.toString(), 2) + ":" + padStr(minute.toString(), 2) + ":" + padStr(second.toString(), 2);
					break;
				case 2:
					str=padStr(minute.toString(), 2) + ":" + padStr(second.toString(), 2);
					break;
				case 3:
					str=padStr(second.toString(), 2);
					break;
				default:
					str=padStr(hour.toString(), 2) + ":" + padStr(minute.toString(), 2) + ":" + padStr(second.toString(), 2);
			}
			return str;
		}
		//小时：分钟：秒钟：毫秒
		public static function getMillisecond(strTime:String):String{
			var _strArr:Array =strTime.split(":");
			return millisecond(int(_strArr[0]),int(_strArr[1]),int(_strArr[2]),int(_strArr[3])).toString();
			
		}
		public static function millisecond(_hour:int,_minute:int,_second:int,_millisecond:int=0,_day:int=0):int
		{
			return _hour*3600000+_minute*60000+_second*1000+_millisecond+_day*86400000;
		}
		public static function padStr(src : String, len : int ) : String//添加前导零
		{	
			if ( src.length > len )//若字符串长度超过指定长度，则截断字符串 
				return src.substr(0, len);			
			var s : String = src;
			for ( var i : int = s.length;  s.length < len; )//添加前导零 
			{
				s = "0" + s;
			}
			return s;
		}
	}
}