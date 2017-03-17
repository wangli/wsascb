package com.wsascb.media
{
	import flash.errors.IOError;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	
	public class MusicPlay extends EventDispatcher
	{
		private var sound:Sound;
		private var channel:SoundChannel;
		private var url:String;
		private var time:Number=0;
		private var position:Number=0;
		private var state:String="stop";
		private var single:Single=Single.getInstance();
		private static var instance:MusicPlay;
		public function MusicPlay()
		{
			if ( instance != null )
			{
				throw new Error("只能创建一次MusicPlay");
			}
			sound=new Sound();
			single.music=this;		
			instance = this;
		}
		public static function getInstance():MusicPlay
		{
			if ( instance == null )
			{
				instance = new MusicPlay();
			}
			return instance;
		}
		public function loadUrl(str:String,py:Boolean=false):void{
			if(state=="stop"){
				url=str;
				if(channel!=null){
					channel=sound.play(position);
					state="play";
				}else{
					sound.load(new URLRequest(url));
					if(py){
						channel=sound.play();
						state="play";
					}
				}
			}
		}
		public function goPlay(_time:Number=0):void{
			channel=sound.play(_time);
			state="play";			
		}
		public function stop():void{
			if(channel!=null){
				position=channel.position;
				channel.stop();
				try {
					sound.close();
				}
				catch (error:IOError) {
					error.message;    
				}
				state="stop";
			}
		}
		public function get sta():String{
			return state;
		}
	}
}