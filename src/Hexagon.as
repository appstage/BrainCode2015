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
		private var mobsDestroyed:Number;
		private var playingGame:Boolean = false;
		private var levelToPlay:Number = 0;
		private var playerStarted:Boolean = false;
		private var playerExploded:Boolean = false;
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
		
		public function _startGame():void{
			
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
		
		public function gogo(Event:MouseEvent):void{
			begin.removeEventListener(MouseEvent.CLICK, gogo);
			TweenLite.to(headphones, 1, {x:400, y:-480});
			TweenLite.to(begin, 1, {x:200, y:800, onComplete:startScreenEnd});
		}
		
		public function startScreenEnd():void{
			removeChild(begin);
			removeChild(headphones);
			_main();
		}
		
		public function _main():void{
			var bg:BackgroundImage = new BackgroundImage();
			//addChild(bg);
			addChild(gameTitle);
			addChild(playerCircle);
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, gameGame);
		}
		
		private function update(e:Event):void{
			playerCircle.x = stage.mouseX;
			playerCircle.y = stage.mouseY;
			
			for (var i:Number=0; i<mobVector.length; i++){
				mobVector[i].theSprite.x+=mobVector[i].xSpeed;
				mobVector[i].theSprite.y+=mobVector[i].ySpeed;
				if (mobVector[i].theSprite.x>1024) {
					mobVector[i].theSprite.x-=1024;
				}
				if (mobVector[i].theSprite.x<0) {
					mobVector[i].theSprite.x+=1024;
				}
				if (mobVector[i].theSprite.y>768) {
					mobVector[i].theSprite.y-=768;
				}
				if (mobVector[i].theSprite.y<0) {
					mobVector[i].theSprite.y+=768;
				}
				
				
			}
			for (i=0; i<bulletVector.length; i++){
				bulletVector[i].theSprite.x+=bulletVector[i].xSpeed;
				bulletVector[i].theSprite.y+=bulletVector[i].ySpeed;
				for (var j:Number=0; j<mobVector.length; j++){
					var distanceX:Number=bulletVector[i].theSprite.x-mobVector[j].theSprite.x;
					var distanceY:Number=bulletVector[i].theSprite.y-mobVector[j].theSprite.y;
					var theDistance:Number=distanceX*distanceX+distanceY*distanceY;
					var bulletMobDistance:Number=mobVector[j].theSprite.width*mobVector[j].theSprite.width/4+bulletVector[i].theSprite.width*bulletVector[i].theSprite.width/4;
					if (theDistance<bulletMobDistance) {
						if (getQualifiedClassName(mobVector[j].theSprite)!="BlueMob") {
							if (getQualifiedClassName(mobVector[j].theSprite)!="PurpleMob") {
								for (var k:Number=1; k<=4; k++) {
									if (getQualifiedClassName(mobVector[j].theSprite)=="GreenMob") {
										var theBullet:TheBullet=new TheBullet(new GreenBullet(),mobVector[j].theSprite,Math.PI*k/2);
									}
									else {
										theBullet=new TheBullet(new YellowBullet(),mobVector[j].theSprite,Math.PI*k/2+Math.PI/4);
									}
									bulletVector.push(theBullet);
									battleField.addChild(theBullet.theSprite);
								}
							}
	
							//
							else {
								for (k=1; k<=8; k++) {//8
									theBullet=new TheBullet(new PurpleBullet(),mobVector[j].theSprite,Math.PI*k/4);
									bulletVector.push(theBullet);
									battleField.addChild(theBullet.theSprite);
								}
							}
						}
						else {
							dieAnyway=true;
						}
						battleField.removeChild(bulletVector[i].theSprite);
						battleField.removeChild(mobVector[j].theSprite);
						mobVector.splice(j,1);
						bulletVector.splice(i,1);
						if (i>0) {
							i--;
						}
						if (j>0) {
							j--;
						}
						mobsDestroyed++;
						howMany.howManyText.text="Exploded: "+mobsDestroyed+"/"+mobsToDestroy[levelToPlay];
					}
				}
				if (bulletVector[i].theSprite.y>768||bulletVector[i].theSprite.y<0||bulletVector[i].theSprite.x>1024||bulletVector[i].theSprite.x<0) {
					battleField.removeChild(bulletVector[i].theSprite);
					bulletVector.splice(i,1);
					if (bulletVector.length==0) {
						if (mobsDestroyed>=mobsToDestroy[levelToPlay] && !dieAnyway) {
							levelToPlay++;
						}
						//animacja
						playLevel();
					}	
				}
			}
			
		
		
		
	
			
			
		}
		
		
		
		private function gameGame(event:MouseEvent):void{
			if (! playingGame) {
				playingGame = true;
				removeChild(gameTitle);
				removeChild(playerCircle);
				playLevel();
			}
			else {
				if (playerStarted && !playerExploded){
					playerExploded = true;
					for (var i:Number=1; i<=4; i++){
						var theBullet:TheBullet=new TheBullet(new PlayerBullet(),playerCircle,Math.PI*i/2);
						bulletVector.push(theBullet);
						battleField.addChild(theBullet.theSprite);
						
					}
					playerCircle.alpha=0.25;
					
				}
				if (! playerStarted) {
					battleField.removeChild(levelIntro);
					// game jeden start
					playerStarted=true;
			}
			
		}
		}
		
		
		private function playLevel():void{
			
		}
	}
}