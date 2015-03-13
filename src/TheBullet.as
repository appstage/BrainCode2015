package
{
	import flash.display.Sprite;
	public class TheBullet extends Sprite{
		public var theSprite:Sprite;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public function TheBullet(sprite:Sprite,father:Sprite,bulletDirection:Number) {
			theSprite=sprite;
			xSpeed=14*Math.cos(bulletDirection);//6
			ySpeed=14*Math.sin(bulletDirection);
			theSprite.x=father.x;
			theSprite.y=father.y;
		}
	}
}