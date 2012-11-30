package com.wsascb.Draw
{
	import com.wsascb.Position.DragDisObj;
	import com.wsascb.Position.DyPoint;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.*;
	import flash.events.*;
	import flash.events.EventDispatcher;
	
	public class dyDrawBase extends EventDispatcher
	{
		/**
		 * 次类为一个为一个在指定Sprite对象里动态绘制矩形的类
		 * 此类包含返回一个Sprite对象和一个point对象的两个方法
		 * 以及一个清楚Sprite对象的公共方法
		 * 此类公共属性有矩形填充颜色，透明度，边线颜色，边线粗细
		 * 举例使用方法如下：建立一个名为"nSprite"的Sprite对象，并放置在舞台之上
		var ndyDrawBase=new dyDrawBase(nSprite);
		ndyDrawBase.selectSprite();
		ndyDrawBase.ws_lineColor=0xff0000;
		 * 返回"nSprite"对应的Sprite的point坐标值
		trace(ndyDrawBase.point())
		///相关说明, 打*号参数为必填内容----------------------------
		 * 构造函数：dyDrawBase(*放置对象，填充颜色，透明度，边线颜色)
		 * 建立对象：selectSprite()
		 * 清楚对象：Cancel()
		 * 返回对象：drawSp
		 * 返回对象的x,y坐标，point()
		*/
		private var ws_pointX:Number;
		private var ws_pointY:Number;
		private var ws_TpointX:Number;
		private var ws_TpointY:Number;
		private var ws_width:Number;
		private var ws_height:Number;
		private var ws_target:Sprite;
		private var ws_onlayer:Sprite;
		private var ws_drawRect:Rectangle;
		private var ws_drawSp:Sprite;
		private var ws_point:Point;
		
		private var ws_drawBase:drawBase;
		private var ws_strSprite:String;
		private var ws_DyPoint:DyPoint;
		
		public var ws_lineColor:uint=0xFFFFFF;//边线颜色
        public var ws_fillColor:uint=0xFFFFFF;//填充颜色
        public var ws_fillAlpha:Number=50;//透明度
        public var ws_lineSize:Number=0;//边线粗细
        public var ws_round:Number=5;//圆角弧度
        public var ws_angle:Number=60;//三角形角度
        public var ws_rotation:Number=-30;//三角形旋转度
        public var ws_tips:Number=5;//外角数量
        public var ws_sides:Number=5;//多边形边数量
		
		public static const RECT:String="Rect";//矩形
		public static const ROUNDRECT:String="RoundRect";//圆角矩形
		public static const CIRCLE:String="Circle";//圆
		public static const ELLIPSE:String="Ellipse";//椭圆
		public static const TRIANGLE:String="Triangle";//三角
		public static const STAR:String="Star";//星形
		public static const REGULARPOLYGON:String="RegularPolygon";//正多边形
		public static const FREE:String="Free";//自定义
		public static const MOUSEDOWN:String = "mousedown";
		public static const MOUSEMOVE:String = "mousemove";

		public function dyDrawBase(target:Sprite,lineColor:uint=0xFFFFFF,fillColor:uint=0xFFFFFF,fillAlpha:Number=50)
		{
			this.ws_drawBase=new drawBase();
			
			//载入外部sprite
			this.ws_target = target;
            //创建名为"ws_point"的point对象
			this.ws_point=new Point()
			//相关颜色，透明度，边线色赋值
			this.ws_lineColor = lineColor;
        	this.ws_fillColor = fillColor;
        	this.ws_fillAlpha = fillAlpha;
        	//this.selectSprite();
			//this.dy_drawRoundRect();
		}
		//初始化相关属性值
		public function infoNo(in_fillColor:uint=0xFFFFFF,in_lineColor:uint=0xFFFFFF,in_fillAlpha:Number=50,in_lineSize:Number=0,in_round:Number=5,in_angle:Number=60,in_rotation:Number=-30,in_tips:Number=5,in_sides:Number=5):void{
			
			ws_lineColor=in_lineColor;
			ws_fillColor=in_fillColor;
			ws_fillAlpha=in_fillAlpha;
			ws_lineSize=in_lineSize;
			ws_round=in_round;
			ws_angle=in_angle;
			ws_rotation=in_rotation;
			ws_tips=in_tips;
			ws_sides=in_sides;
		}
		private function rotate(evt:MouseEvent):void{
			this.ws_drawSp.rotation+=20;
		}
		//矩形
		public function dy_drawRect():void{
			this.ws_strSprite=RECT;
			selectSprite();
		}
		//圆角矩形
		public function dy_drawRoundRect():void{
			this.ws_strSprite=ROUNDRECT;
			selectSprite();
		}
		//圆
		public function dy_drawCircle():void{
			this.ws_strSprite=CIRCLE;
			selectSprite();
		}
		//椭圆
		public function dy_drawEllipse():void{
			this.ws_strSprite=ELLIPSE;
			selectSprite();
		}
		//三角
		public function dy_drawTriangle():void{
			this.ws_strSprite=TRIANGLE;
			selectSprite();
			//*ab边长度，*ac边长度
		}
		//星形
		public function dy_Star():void{
			this.ws_strSprite=STAR;
			selectSprite();
			//*ab边长度，*ac边长度
		}
		//正多边形
		public function dy_drawRegularPolygon(borderSL:Number=5):void{
			this.ws_strSprite=REGULARPOLYGON;
			selectSprite();
			//*边数量，*边长
		}
		//自由画笔区域
		public function dy_drawFree():void{
			//this.ws_strSprite=FREE;
			//selectSprite();
			this.Cancel();
			this.ws_drawSp=this.ws_drawBase.ws_drawRect(this.ws_target.width,this.ws_target.height,0,0,ws_fillColor,0);
			this.ws_target.addChild(this.ws_drawSp);
			this.ws_drawBase.ws_free(this.ws_drawSp);
			/* this.ws_target.addEventListener(MouseEvent.MOUSE_DOWN,strPoint);
			this.ws_target.addEventListener(MouseEvent.MOUSE_UP,move_mc);
			function strPoint(evt:MouseEvent):void{
				this.ws_point.x=evt.localX;
				this.ws_point.y=evt.localY;
			}
			function move_mc(evt:MouseEvent):void{
				var dragObj3:DragDisObj=new DragDisObj(this.ws_drawSp,new Rectangle(-this.ws_point.x,-this.ws_point.y,this.ws_target.width-this.ws_drawSp.width,this.ws_target.height-this.ws_drawSp.height));
			} */
		}
		//建立选区对象
		public function selectSprite():void{
			try{
				this.Cancel();
			}catch(e:Error){
				trace("--------------"+e.message);
   			}
   			this.ws_target.addEventListener(MouseEvent.MOUSE_DOWN, this.startDrawRect);
		}
		//开始绘制选区对象
		private function startDrawRect(event:MouseEvent):void{
			dispatchEvent(new Event(dyDrawBase.MOUSEDOWN));
			this.ws_pointX = this.ws_target.mouseX;
            this.ws_pointY = this.ws_target.mouseY;
            this.ws_point.x=this.ws_pointX
            this.ws_point.y=this.ws_pointY;
            this.ws_target.addEventListener(MouseEvent.MOUSE_MOVE, this.drawingRect);
            this.ws_target.addEventListener(MouseEvent.MOUSE_UP, this.endDrawRect);
		}
		//鼠标在图形对象上点击按下之后拖动开始绘制选区对象
		private function drawingRect(event:MouseEvent):void{
			//trace(this.ws_target.mouseX);
			if((this.ws_target.mouseX - this.ws_pointX)>0&&(this.ws_target.mouseY - this.ws_pointY)>0){
				this.numberDrawSp(this.ws_pointX,this.ws_pointY,this.ws_target.mouseX - this.ws_pointX,this.ws_target.mouseY - this.ws_pointY);
			}else{
				this.numberDrawSp(0,0,0,0);
				Cancel();
			}
			
		}
		//鼠标在图形对象上释放鼠标时结束绘制选区对象
		private function endDrawRect(e:MouseEvent):void{
			if(this.ws_target.mouseX<this.ws_pointX||this.ws_target.mouseY<this.ws_pointY){
				this.ws_pointX = this.ws_target.mouseX;
            	this.ws_pointY = this.ws_target.mouseY;
			}
            this.ws_point.x=this.ws_pointX;
            this.ws_point.y=this.ws_pointY;
            //this.ws_target.removeEventListener(MouseEvent.MOUSE_DOWN, this.startDrawRect);
            this.ws_target.removeEventListener(MouseEvent.MOUSE_MOVE, this.drawingRect);
            this.ws_target.removeEventListener(MouseEvent.MOUSE_UP, this.endDrawRect);
            if(this.ws_drawSp!=null){
            	if(this.ws_strSprite==CIRCLE||this.ws_strSprite==REGULARPOLYGON){
            		var dragObj:DragDisObj=new DragDisObj(this.ws_drawSp,new Rectangle(-this.ws_point.x+this.ws_drawSp.width/2,-this.ws_point.y+this.ws_drawSp.height/2,this.ws_target.width-this.ws_drawSp.width,this.ws_target.height-this.ws_drawSp.height));
        		}else{
           		 	var dragObj2:DragDisObj=new DragDisObj(this.ws_drawSp,new Rectangle(-this.ws_point.x,-this.ws_point.y,this.ws_target.width-this.ws_drawSp.width,this.ws_target.height-this.ws_drawSp.height));
           		}
            }
        }
		//绘制选区对象
		private function numberDrawSp(pointX:Number,pointY:Number,width:Number,height:Number):void{
			var n_pointX:Number=pointX;
			var n_pointY:Number=pointY;
			var n_width:Number=width;
			var n_height:Number=height;
			this.ws_drawRect = new Rectangle(n_pointX,n_pointY,n_width,n_height);
			this.Cancel();
			switch(this.ws_strSprite){
				 case RECT:
					this.ws_drawSp=this.ws_drawBase.ws_drawRect(n_width,n_height,n_pointX,n_pointY,ws_fillColor,ws_fillAlpha,ws_lineSize,ws_lineColor);
					break;
				case ROUNDRECT:
					this.ws_drawSp=this.ws_drawBase.ws_drawRoundRect(n_width,n_height,n_pointX,n_pointY,ws_fillColor,ws_round,ws_fillAlpha,ws_lineSize,ws_lineColor);		
        			break;
				case CIRCLE:
					var radius:Number=Math.round(Math.sqrt(n_width*n_width+n_height*n_height));
					this.ws_drawSp=this.ws_drawBase.ws_drawCircle(radius,n_pointX,n_pointY,ws_fillColor,ws_fillAlpha,ws_lineSize,ws_lineColor);
					break;
				case ELLIPSE:
					this.ws_drawSp=this.ws_drawBase.ws_drawEllipse(n_width,n_height,n_pointX,n_pointY,ws_fillColor,ws_fillAlpha,ws_lineSize,ws_lineColor);
					break;
				case TRIANGLE:
					this.ws_drawSp=this.ws_drawBase.ws_drawTriangle(n_width,n_height,n_pointX,n_pointY,ws_angle,ws_rotation,ws_fillColor,ws_fillAlpha,ws_lineSize,ws_lineColor);
        			break;
        		case STAR:
					var star_radiu:Number=Math.round(Math.sqrt(n_width*n_width+n_height*n_height));
					this.ws_drawSp=this.ws_drawBase.ws_star(ws_tips,Math.round(star_radiu/4),Math.round(star_radiu/2),n_pointX,n_pointY,0,ws_fillColor,ws_fillAlpha,ws_lineSize,ws_lineColor);
        			break;
				case REGULARPOLYGON:
					var length:Number=Math.round(Math.sqrt(n_width*n_width+n_height*n_height));
					this.ws_drawSp=this.ws_drawBase.ws_drawRegularPolygon(ws_sides,length,n_pointX,n_pointY,ws_rotation,ws_fillColor,ws_fillAlpha,ws_lineSize,ws_lineColor);
					break;
				case FREE:
					//结束点是起始点坐标加上鼠标移动的长度
					this.ws_drawSp=this.ws_drawBase.ws_drawRect(this.ws_target.width,this.ws_target.height,0,0,ws_fillColor,0);
					this.ws_drawBase.ws_free(this.ws_drawSp,n_pointX,n_pointY);
					break;
				default:
					this.ws_drawSp=this.ws_drawBase.ws_drawRect(n_width,n_height,n_pointX,n_pointY,ws_fillColor,ws_fillAlpha,ws_lineSize,ws_lineColor);
			}
   			this.ws_target.addChild(this.ws_drawSp);
		}
		//改变选区对象的相关值
		public function adjustDrawSp (pointX:Number,pointY:Number,width:Number,height:Number):void{
			//this.selectSprite();
			this.numberDrawSp(pointX,pointY,width,height);
		}
		//拖动对象
		public function handleDrag():void{
			//this.ws_target.removeEventListener(MouseEvent.MOUSE_MOVE, this.drawingRect);
            this.ws_target.removeEventListener(MouseEvent.MOUSE_UP, this.endDrawRect);
            if(this.ws_drawSp!=null){
            	if(this.ws_strSprite==CIRCLE||this.ws_strSprite==REGULARPOLYGON){
            		var dragObj:DragDisObj=new DragDisObj(this.ws_drawSp,new Rectangle(-this.ws_point.x+this.ws_drawSp.width/2,-this.ws_point.y+this.ws_drawSp.height/2,this.ws_target.width-this.ws_drawSp.width,this.ws_target.height-this.ws_drawSp.height));
        		}else{
           		 	var dragObj2:DragDisObj=new DragDisObj(this.ws_drawSp,new Rectangle(-this.ws_point.x,-this.ws_point.y,this.ws_target.width-this.ws_drawSp.width,this.ws_target.height-this.ws_drawSp.height));
           		}
            }
		}
		//返回选区对象
		public function get drawSp():Sprite{
			return this.ws_drawSp;
		}
		//返回选区对象的相对坐标
		public function get point():Point{
			return this.ws_point;
		}
		//清楚选区对象
        public function Cancel():void
        {
        	try{
            	this.ws_target.removeChild(this.ws_drawSp);
         	}catch(e:Error){
         		trace(e.message);
         	}
        }

	}
}