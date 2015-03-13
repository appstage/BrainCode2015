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
	
	
	
	

	[SWF(width="1024",height = "768",frameRate="60",backgroundColor="#ccc51c")]

	public class Hexagon extends Sprite
	{
		
		//public var bgStart
		//public var headphones
		public var headphones:Headphones = new Headphones;
		public var begin:Begin = new Begin;
		
		//alien
		private var greenMobs = new Array(5,10,15,20,25);
		private var blueMobs = new Array(0,0,0,0,1);
		private var yellowMobs = new Array(0,0,0,0,0);
		private var purpleMobs = new Array(0,0,0,0,0);
		private var mobsToDestroy = new Array(2,5,10,15,3);
		private var levelDescription = new Array();
		private var playingGame:Boolean = false;
		private var levelToPlay:Number = 0;
		private var playerStartet:Boolean = false;
		private var dieAnyway:Boolean;
		
		//last
		private var mobVector:Vector.<TheMob>=new Vector.<TheMob>();
		private var bulletVector:Vector.<TheBullet>=new Vector.<TheBullet>();
		private var playerCircle:PlayerCircle = new PlayerCircle;
		private var gameTitle:GameTitle = new GameTitle;
		private var battleField:Sprite;
		private var levelIntro:LevelIntro;
		private var howMany:HowMany = new HowMany;
		
		//end
		
		
		
		public function Hexagon()
		{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			levelDescription[0] = "Opis level 1";
			levelDescription[1] = "Opis level 2";
			levelDescription[2] = "Opis level 3";
			levelDescription[3] = "Opis level 4";
			levelDescription[4] = "Opis level 5";
				
			
			
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
			_main();
		}
		
		public function _main(){
			var bg:BackgroundImage = new BackgroundImage();
			//addChild(bg);
			addChild(playerCircle);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event){
			playerCircle.x = stage.mouseX;
			playerCircle.y = stage.mouseY;
			
			for (var i:Number=0; i<mobVector.length; i++){
				mobVector[i].theSprite.x+=mobVector[i].xSpeed;
				mobVector[i].theSprite.y+=mobVector[i].ySpeed;
				
				
			}
			
		}
		
		
	}
}