package com.wsascb.assistant
{
	import flash.display.DisplayObject;
	/**
	      * [静态]排列类
	      * 用户排列场景里的元素位置
	      **/
	public class Arrange
	{
		/**
		  * 排列元素 
		  * @param mcArray 传入的一个包含同一舞台上DisplayObjict类型的数组
		  * @param rows   需要排列的列数
		  * @param spaceX 需要横坐标两个元素之间的间隔
		  * @param spaceY 需要纵坐标两个元素之间的间隔
		  * @param positionX 初始化整体列队的x坐标
		  * @param positionY 初始化整体列队的y坐标
		  * @return 返回横排行数
		  **/
		public static function ArrangeStic(mcArray:Array, rows:Number, spaceX:Number=0, spaceY:Number=0, positionX:Number=0, positionY:Number=0):int
		{
			var ws_mc_all:int = mcArray.length;
			//rows:列数， spaceX: X间隔， spaceY: Y间隔， positionX: X坐标， positionY: Y坐标
			var mc_x = positionX,mc_y = positionY;
			for (var i:int = 0; i<ws_mc_all; i++)
			{
				if (mcArray[i] is DisplayObject)
				{
					if (i%rows == 0 && i != 0)
					{
						mc_y +=  mcArray[i].height + spaceY;
						mc_x = positionX;
					}
					mcArray[i].x = mc_x;
					mcArray[i].y = mc_y;
					mc_x +=  mcArray[i].width + spaceX;
				}
			}
			//返回横排行数
			return Math.ceil(ws_mc_all/rows);
		}
	}
}