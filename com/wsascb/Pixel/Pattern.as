package  wsascb.Pixel
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	public class Pattern extends BitmapData
	{
		private const IDENTITY: Matrix = new Matrix();
		
		private var texture: BitmapData;
		private var shape: Shape;
		
		public function Pattern( width: int, height: int, texture: BitmapData = null )
		{
			super( width, height, false, 0 );
			this.texture = texture;
			
			shape = new Shape();
		}
		
		public function drawUnify(): void
		{
			shape.graphics.beginBitmapFill( texture, IDENTITY, true, false );
			shape.graphics.moveTo( 0, 0 );
			shape.graphics.lineTo( width, 0 );
			shape.graphics.lineTo( width, height );
			shape.graphics.lineTo( 0, height );
			shape.graphics.lineTo( 0, 0 );
			shape.graphics.endFill();
			
			draw( shape, IDENTITY );
		}
	}
}