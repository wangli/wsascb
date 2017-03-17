//弹出提示窗口
package com.wsascb.spriteTool
{
	import com.wsascb.Draw.drawBase;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class alert extends Sprite
	{

		public static var stage_root:*;
		public static var stage_width:Number;
		public static var stage_heigh:Number;

		private static var _instance:alert;
		private static var _singleton:Boolean = false;
		private static var alertBg:Sprite;
		private static var drawSpr:drawBase;
		private static var alertInfo:TextField;


		public function alert(_stage:Object)
		{
			if (_singleton) {
				throw new Error("请使用getInstance()创建");
			}
			if(!stage_root){
				throw new Error("stage目标还没有初始化");
			}
			drawSpr = new drawBase();
			alertBg = drawSpr.ws_drawRect(210,50,0,0,0xffffff,90,0,0x000000);
			addChild(alertBg);

			alertInfo=new TextField();
			alertInfo.defaultTextFormat.size="20px";
			alertInfo.selectable=false;
			alertInfo.wordWrap=true;
			alertInfo.width = 200;
			alertInfo.autoSize = "center";
			addChild(alertInfo);
			this.addEventListener(MouseEvent.CLICK,closeAlert);
		}
		public static function init(_stage:Object):void{
			stage_root=_stage;
		}
		public static function show(str:String=null):void
		{
			if(!stage_root){
				throw new Error("stage目标还没有初始化");
			}
			try {
				msEnabled(stage_root,false);
				stage_root.addChild(_instance);
				alertInfo.text = str + "   ";
				_instance.visible = true;
				//
				alertBg.height=alertInfo.height+10;
				
				alertBg.x=(stage_root.stage.stageWidth-alertBg.width)/2;
				alertBg.y=(stage_root.stage.stageHeight-alertBg.height)/2;
				alertInfo.x=(stage_root.stage.stageWidth-alertInfo.width)/2+5;
				alertInfo.y = (stage_root.stage.stageHeight-alertInfo.height)/2+5;
			} catch (e:Error) {
				
			}
		}
		private function closeAlert(evt:MouseEvent):void
		{
			_instance.visible = false;
			msEnabled(stage_root,true);
		}
		public static function getInstance(_stage:Object=null):alert
		{
			if(_stage!=null){
				stage_root=_stage;
			}
			if (_instance == null) {
				_singleton = false;
				_instance=new alert(stage_root);
				_singleton = true;
			}
			return _instance;
		}
		private static function msEnabled(_stage:DisplayObject,_tf:Boolean=true):void{
			if(_stage is SimpleButton){
				(_stage as SimpleButton).mouseEnabled=_tf;
				return;
			}
			var stg:Object;
			if(_stage is Sprite){
				stg=_stage as Sprite;
			}else if(_stage is MovieClip){
				stg=_stage as MovieClip;
			}
			if(stg==null){
				return;
			}
			if(stg.numChildren>0){
				for (var i:int = 0; i <stg.numChildren; i ++) {
					msEnabled(stg.getChildAt(i),_tf);
				}
			}else{
				stg.mouseEnabled=_tf;
				return;
			}
		}
	}
}