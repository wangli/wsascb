package com.wsascb.net{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;

	public class GetUrl {
		private static  var _singleton:Boolean=true;
		private static  var _instance:GetUrl;
		public function GetUrl() {
			if (_singleton) {
				throw new Error("只能用getInstance()来获取实例");
			}
		}
		public static function getInstance():GetUrl {
			if ( _instance == null ) {
				_instance = new GetUrl();
				_singleton=true;
			}
			return _instance;
		}
		public static function getURL(_val:String,_windows:String="_self",_vars:Object=null,_method:String="POST"):void {
			var request:URLRequest = new URLRequest(_val);
			request.method = _method;
			if(_vars!=null){
				request.data=_vars;
			}
			navigateToURL(request,_windows);
		}
	}
}