package com.wsascb.assistant{
	public class MathExtend {
		//返回指定范围内的整数数组
		public static function randRange(min:Number,max:Number):Number {
			var randomNum:Number=Math.floor(Math.random() * max - min + 1) + min;
			return randomNum;
		}
		//返回指定数字范围内的整数随机排列的数组
		public static function randomNumArr(min:Number,max:Number):Array {
			//建立一个存储0到数组数量为范围的数组
			var temArr:Array=new Array;
			var temLg:Number=int(max - min);
			for (var i:int=min; i < temLg + min; i++) {
				temArr.push(i);
			}
			temArr.sort(randomSort);
			return temArr;
		}
		private static function randomSort(eA:Object,eB:Object):Number {
			return Math.random() - 0.5;
		}
	}
}