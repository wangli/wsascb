package com.wsascb.utils
{

	public class UKey
	{

		import flash.utils.ByteArray;
		import com.hurlant.crypto.symmetric.ICipher;
		import com.hurlant.crypto.symmetric.IVMode;
		import com.hurlant.crypto.symmetric.IMode;
		import com.hurlant.crypto.symmetric.NullPad;
		import com.hurlant.crypto.symmetric.PKCS5;
		import com.hurlant.crypto.symmetric.IPad;
		import com.hurlant.crypto.prng.Random;
		import com.hurlant.crypto.hash.HMAC;
		import com.hurlant.util.Base64;
		import com.hurlant.util.Hex;
		import com.hurlant.crypto.Crypto;
		import com.hurlant.crypto.hash.IHash;
		public function UKey()
		{
			
		}
		public static function encrypt(_key:String,_inTxt:String,_typ:String="des-cbc"):String
		{
			var k:String = _key;
			var kdata:ByteArray;
			kdata = Hex.toArray(Hex.fromString(k));

			var inputTxt:String = _inTxt;
			var data:ByteArray;
			data = Hex.toArray(Hex.fromString(inputTxt));

			var name:String = _typ;

			var pad:IPad=new NullPad();
			var mode:ICipher = Crypto.getCipher(name,kdata,pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.encrypt(data);

			var ivStr:String = "";
			if (mode is IVMode) {
				var ivmode:IVMode = mode as IVMode;
				ivStr = Hex.fromArray(ivmode.IV);
			}

			var txt:String = Base64.encodeByteArray(data) + ivStr;
			return txt;
		}
		public static function decrypt(_key:String,_inTxt:String,_typ:String="des-cbc"):String
		{
			var rtxt:String="";
			var k:String = _key;
			var kdata:ByteArray;
			kdata = Hex.toArray(Hex.fromString(k));

			var txtArr:Array = _inTxt.split("==");
			if(txtArr.length>1){
				var data:ByteArray;
				data = Base64.decodeToByteArray(txtArr[0] + "==");

				var name:String = _typ;

				var pad:IPad=new NullPad();
				var mode:ICipher = Crypto.getCipher(name,kdata,pad);
				pad.setBlockSize(mode.getBlockSize());
				if (mode is IVMode) {
					var ivmode:IVMode = mode as IVMode;
					ivmode.IV = Hex.toArray(txtArr[1]);
				}
				mode.decrypt(data);

				rtxt = Hex.toString(Hex.fromArray(data));
			}
			return rtxt;
		}

	}

}