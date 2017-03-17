package com.wsascb.assistant
{
	public class RegularRegexp
	{
		//正整数
		public static function numberNa(_str:String):Boolean{
			var numberNA:RegExp= /^[0-9]*[1-9][0-9]*$/;
			return numberNA.test(_str);
		}
		//非正整数
		public static function numberNb(_str:String):Boolean{
			var numberNA:RegExp= /^((-\d+)|(0+))$/;
			return numberNA.test(_str);
		}
		//负整数
		public static function numberNc(_str:String):Boolean{
			var numberNA:RegExp= /^-[0-9]*[1-9][0-9]*$/;
			return numberNA.test(_str);
		}
		//整数
		public static function numberNd(_str:String):Boolean{
			var numberNA:RegExp= /^-?\d+$/;
			return numberNA.test(_str);
		}
		//小于6位数的正整数
		public static function numberNe(_str:String):Boolean{
			var numberNA:RegExp= /^\+?\d{0,4}$/;
			return numberNA.test(_str);
		}
		//小于500的正整数
		public static function numberNf(_str:String):Boolean{
			var numberNA:RegExp= /^([0-9]{1,5}|5[0-9][0-9]|500)$/;
			return numberNA.test(_str);
		}
	}
}