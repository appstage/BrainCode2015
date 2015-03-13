package {
	import flash.display.Sprite;
	public class TheMob extends Sprite {
		public var theSprite:Sprite;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public function TheMob(sprite:Sprite) {
			theSprite=sprite;
			theSprite.x=Math.random()*600;
			theSprite.y=Math.random()*600;
			var randomDirection:Number=Math.random()*2*Math.PI;
			xSpeed=2*Math.cos(randomDirection);
			ySpeed=2*Math.sin(randomDirection);
		}
	}
}