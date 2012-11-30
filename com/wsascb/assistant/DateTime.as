package com.wsascb.assistant
{
	public class DateTime
	{
		//data格式Year.Month.Day  ,  2010,10,1   返回日期之间的天数差值
		public static function DateTimeJS(dateA:String,dataB:String):int
		{
			var dateAArr:Array=dateA.split(".");
			var dateBArr:Array=dataB.split(".");
			var da:Date = new Date(int(dateAArr[0]), int(dateAArr[1]), int(dateAArr[2]));
			var db:Date =new Date(int(dateBArr[0]), int(dateBArr[1]), int(dateBArr[2]));
			var day:int = Math.floor((db.time-da.time) / (1000 * 60 * 60 *24));
			return day;
		}
		//返回格式Year.Month.Day  ,  2010,10,1
		public static function getDateStrJS(dateA:String,dateNum:int):String
		{
			var dateAArr:Array=dateA.split(".");
			var da:Date = new Date(int(dateAArr[0]), int(dateAArr[1]), int(dateAArr[2]));
			var db:Date = new Date();
			var newmill:Number=da.time+dateNum*24*60*60*1000;
			db.setTime(newmill);
			return String(db.getFullYear())+"."+String(db.getMonth())+"."+String(db.getDate());
		}
	}
}