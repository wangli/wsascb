package wsascb.Pixel
{
	public class Pixel
	{
		public var wx: Number;
		public var wy: Number;
		public var wz: Number;
		public var rx: Number;
		public var ry: Number;
		public var rz: Number;
		
		public var c: uint;
		
		public function Pixel( x: Number, y: Number, z: Number, c: uint )
		{
			wx = x;
			wy = y;
			wz = z;
			
			this.c = c;
		}
	}
}