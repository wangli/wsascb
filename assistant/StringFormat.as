package com.wsascb.assistant
{
	public class StringFormat
	{
		private static var num:Array = ["零","壹","贰","叁","肆","伍","陆","柒","捌","玖","拾"];
		private static var num2:Array = ["万","亿","兆"];
		//将阿拉伯数字转换为中文数字
		public static function numTcn(val:int):String
		{
			var cnnum:String;
			if (val<=10) {
				return num[val];
			} else {
				switch (val) {
					case 10 :
						cnnum = "拾";
						break;
					case 100 :
						cnnum = "佰";
						break;
					case 1000 :
						cnnum = "仟";
						break;
					case 10000 :
						cnnum = "万";
						break;
					case 100000000 :
						cnnum = "亿";
						break;
					default :
						cnnum = "";
				}
				return cnnum;
			}
		}
		//将中文数字转换为阿拉伯数字
		public static function cnTnum(val:String):Number
		{
			var num:Number;
			switch (val) {
				case "零" :
					num = 0;
					break;
				case "壹" :
					num = 1;
					break;
				case "贰" :
					num = 2;
					break;
				case "叁" :
					num = 3;
					break;
				case "肆" :
					num = 4;
					break;
				case "伍" :
					num = 5;
					break;
				case "陆" :
					num = 6;
					break;
				case "柒" :
					num = 7;
					break;
				case "捌" :
					num = 8;
					break;
				case "玖" :
					num = 9;
					break;
				case "拾" :
					num = 10;
					break;
				case "佰" :
					num = 100;
					break;
				case "仟" :
					num = 1000;
					break;
				case "万" :
					num = 10000;
					break;
				case "亿" :
					num = 100000000;
					break;
				default :
					num = 0;
			}
			return num;
		}
		//将数字日期转换为中文数字日期
		public static function cnDate(val:String):String
		{
			var lg:int = val.length;
			var dataArr:Array;
			var cndata:String;
			for (var i:int=0; i<lg; i++) {
				if (val.charAt(i) == "-") {
					dataArr = val.split("-");
					break;
				} else if (val.charAt(i)=="/") {
					dataArr = val.split("/");
					break;
				} else if (val.charAt(i)=="|") {
					dataArr = val.split("|");
					break;
				} else if (val.charAt(i)==".") {
					dataArr = val.split(".");
					break;
				}
			}
			if (dataArr==null) {
				dataArr = new Array(val);
			}
			cndata = cnNum(dataArr[0]) + cnNum(dataArr[1]) + cnNum(dataArr[2]);
			return cndata;
		}
		//阿拉伯数字转汉字字符
		public static function cnNum(val:String):String
		{
			var lg:int = val.length;
			var cn:String = "";
			for (var i:int=0; i<lg; i++) {
				cn +=  numTcn(int(val.charAt(i)));
			}
			return cn;
		}
		public static function chNum(val:Number):String
		{
			var cn:String = "";
			var num:Number = val;
			var numStr:String = val.toString();
			var fgStr:Array = numStr.split(".");
			if (fgStr.length == 1) {
				return cnNumInt(val)+"圆整";
			} else {
				var numIntStr:String = fgStr[0];
				var numLsStr:String = fgStr[1];
				var lsCn:String = "";
				if (numLsStr.length<2) {
					lsCn = numTcn(int(numLsStr.charAt(0))) + "角";
				} else if (int(numLsStr)<10) {
					lsCn = "零" + numTcn(int(numLsStr)) + "分";
				} else {
					if(int(numLsStr)%10==0){
						lsCn = numTcn(int(numLsStr.charAt(0))) + "角";
					}else{
						lsCn = numTcn(int(numLsStr.charAt(0))) + "角" + numTcn(int(numLsStr.charAt(1))) + "分";
					}
				}
				return cnNumInt(Number(numIntStr))+"圆"+lsCn;
			}
		}
		public static function cnNumInt(val:Number):String
		{
			var num:Number = val;
			var numStr:String = val.toString();
			var numLg:int = numStr.length;
			var cn:String = "";
			if (numLg>5&&numLg<9) {
				var sw:Number=int(num/10000);
				var gw:Number = num % (sw * 1000);
				//加零
				var lingStr:String = "";
				if (gw<1000) {
					lingStr = "零";
				}
				cn +=  cnNumWan(sw) + "万" + lingStr + cnNumWan(gw);
			} else if (numLg>=9) {
				var yw:Number=int(num/100000000);
				var ww:Number = num % (yw * 100000000);
				//加零
				var lingStr2:String = "";
				if (ww<10000000) {
					lingStr2 = "零";
				}
				cn +=  cnNumInt(yw) + "亿" + lingStr2 + cnNumInt(ww);
			} else {
				cn +=  cnNumWan(num);
			}
			return cn;
		}
		//万级别以下
		private static function cnNumWan(val:int):String
		{
			var numStr:String = val.toString();
			var numLg:int = numStr.length;
			var cn:String = "";
			var ling:Boolean = false;
			if (val>10) {
				for (var i:int=0; i<numLg; i++) {
					if ((numLg-i)!=1) {
						if (int(numStr.charAt(i))!=0) {
							ling = false;
							cn +=  numTcn(int(numStr.charAt(i))) + numTcn(Math.pow(10,(numLg - i - 1)));
						} else {
							if (int(numStr.charAt(i-1))!=0) {
								//前一位不等于0时添加数字"零"
								cn +=  numTcn(int(numStr.charAt(i)));
							}
						}
					} else {
						if (int(numStr.charAt(i))!=0) {
							cn = cn + numTcn(int(numStr.charAt(numStr.length - 1)));
						}
					}
				}

			} else {
				if (val>=10) {
					//大于等于10小于20直接添加"拾"
					cn +=  "拾";
				} else {
					cn +=  numTcn(val);
				}
			}
			//去除末尾"零"字符
			if (cn.charAt(cn.length - 1) == "零") {
				cn = cn.substr(0,cn.length - 1);
			}
			return cn;
		}
	}
}