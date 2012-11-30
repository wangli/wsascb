package com.wsascb.assistant
{
	public class StringFormat
	{
		private static var num:Array=["零","壹","贰","叁","肆","伍","陆","柒","捌","玖","拾"];
		//将阿拉伯数字转换为中文数字
		public static function numTcn(val:int):String
		{
			var cnnum:String;
			if(val<=10){
				return num[val];
			}else{
				switch (val){
					case 100:
						cnnum="佰";
						break;
					case 1000:
						cnnum="仟";
						break;
					case 10000:
						cnnum="万";
						break;
					case 100000000:
						cnnum="亿";
						break;
					default :
						cnnum="";
				}
				return cnnum;
			}
		}
		//将数字日期转换为中文数字日期
		public static function cnDate(val:String):String{
			var lg:int=val.length;
			var dataArr:Array;
			var cndata:String;
			for(var i:int=0;i<lg;i++){
				if(val.charAt(i)=="-"){
					dataArr=val.split("-");
					break;
				}else if(val.charAt(i)=="/"){
					dataArr=val.split("/");
					break;
				}else if(val.charAt(i)=="|"){
					dataArr=val.split("|");
					break;
				}else if(val.charAt(i)=="."){
					dataArr=val.split(".");
					break;
				}
			}
			if(dataArr==null){dataArr=new Array(val)}
			cndata=cnNum(dataArr[0])+cnNum(dataArr[1])+cnNum(dataArr[2]);
			return cndata;
		}
		public static function cnNum(val:String):String{
			var lg:int=val.length;
			var cn:String="";
			for(var i:int=0;i<lg;i++){
				cn+=numTcn(int(val.charAt(i)));
			}
			return cn;
		}
	}
}