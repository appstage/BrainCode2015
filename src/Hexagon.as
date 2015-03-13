package
{
	import com.greensock.TweenLite;
	
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
	
	
	
	

	[SWF(width="1024",height = "768",frameRate="60",backgroundColor="#CCCCCC")]

	public class Hexagon extends Sprite
	{
		
		//public var bgStart
		//public var headphones
		public var headphones:Headphones = new Headphones;
		public var begin:Begin = new Begin;
		
		public function Hexagon()
		{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.addEventListener(MouseEvent.CLICK, _startGame);
			_startGame();
			
		}
		
		public function _startGame(){
			
			addChild(headphones);
			headphones.x = 400;
			headphones.y = -480;
			TweenLite.to(headphones, 1.5, {x:400, y:80, delay:.8});
			addChild(begin);
			begin.x = 200;
			begin.y = 800;
			TweenLite.to(begin, 1, {x:200, y:580, delay:3});
			begin.addEventListener(MouseEvent.CLICK, gogo);
			
		}
		
		public function gogo(Event:MouseEvent){
			begin.removeEventListener(MouseEvent.CLICK, gogo);
			TweenLite.to(headphones, 1, {x:400, y:-480});
			TweenLite.to(begin, 1, {x:200, y:800, onComplete:startScreenEnd});
		}
		
		public function startScreenEnd(){
			removeChild(begin);
			removeChild(headphones);
		}
		
	}
}