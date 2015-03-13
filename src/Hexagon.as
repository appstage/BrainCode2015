package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.utils.getQualifiedClassName;
	import com.greensock.TweenLite;
	
	
	
	

	[SWF(width="1024",height = "768",frameRate="60",backgroundColor="#CCCCCC")]

	public class Hexagon extends Sprite
	{
		
		//public var bgStart
		//public var headphones
		public var begin:Begin = new Begin;
		
		public function Hexagon()
		{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(MouseEvent.CLICK, _startGame);
			
		}
		
		public function _startGame(Event:MouseEvent){
			//TweenLite.to(, 1, {x:65, y:117});
			addChild(begin);
			begin.x = 200;
			begin.y = 800;//580
			TweenLite.to(begin, 1, {x:200, y:580});
			
		}
		
	}
}