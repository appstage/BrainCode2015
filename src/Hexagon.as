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
	
	
	
	

	[SWF(width="1024",height = "768",frameRate="40",backgroundColor="#DE0000")]

	public class Hexagon extends Sprite
	{
		
		//public var bgStart
		//public var headphones
		public var headphones:Headphones = new Headphones;
		public var tlo_tlo:tlo = new tlo;
		//public var begin:Begin = new Begin;
		public var begin:pla = new pla;
		public var boo:Boolean= new Boolean(false);
		//public var cyfra:numer = new numer;
		//private var wynik:okno = new okno
		
		//alien
		private var greenMobs = new Array(25,20,15,10,5,3,2);
		private var blueMobs = new Array(0,0,0,0,0,0,0);
		private var yellowMobs = new Array(0,0,0,0,0,0,0);
		private var purpleMobs = new Array(0,0,0,0,0,0,0);
		private var mobsToDestroy = new Array(14,12,10,8,6,4,2);
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
		private var fing:finger = new finger;
		private var _flash:dwa2 = new dwa2;
		private var gameTitle:GameTitle = new GameTitle;
		private var battleField:Sprite;
		private var levelIntro:LevelIntro;
		//private var howMany:HowMany = new HowMany;
		private var howMany:okno = new okno;

		private var _maska:maska = new maska;
		//private var Tlo:uiui = new uiui;
		
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
			begin.x = 440;
			begin.y = 800;
			TweenLite.to(begin, .5, {x:440, y:580, delay:3});
			begin.addEventListener(MouseEvent.CLICK, gogo);
			//var gg:finger = new finger();
			//addChild(gg);
			var gameMusic:GameMusic2 = new GameMusic2();
			var soundChannel:SoundChannel=gameMusic.play(0,10000);
			
		}
		
		public function gogo(Event:MouseEvent):void{
			begin.removeEventListener(MouseEvent.CLICK, gogo);
			TweenLite.to(headphones, 1, {x:400, y:-480});
			TweenLite.to(begin, 1, {x:440, y:800, onComplete:startScreenEnd});
		}
		
		public function startScreenEnd():void{
			removeChild(begin);
			removeChild(headphones);
			_main();
		}
		
		public function _main():void{
			var bg:BackgroundImage = new BackgroundImage();
			addChild(tlo_tlo);
			//addChild(cyfra);
			//cyfra.alpha = 0;
			//cyfra.x = 360;
			//cyfra.y = 50;
			
			addChild(_flash);
			//addChild(Tlo);
			//_flash.jojo22();
			_flash.alpha = 0;
			
			
			//addChild(bg);
			addChild(gameTitle);
			gameTitle.x = 530;
			gameTitle.y = 280;
			addChild(playerCircle);
			addChild(fing);
			fing.alpha = 0;
			
			//fing.alpha = 0;
			playerCircle.alpha = 0;
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_UP, gameGame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, pp);
			//addChild(_maska);
			//_maska.x = 1040;
			//_maska.y = 780
			//TweenLite.to(_maska, .5, {scaleX:1300, scaleY:1300});
		}
		
		private function pp(event:MouseEvent):void{
			//if(boo == true){
			fing.alpha = 1;
			fing.zo();
			
			//var gameMusic3:muza1 = new muza1;
			//var soundChannel3:SoundChannel=gameMusic3.play(0,1);
			//boo == false;
			//}
			//else if (boo == false){
			//	removeChild(fing);
			//	boo = true;
			//}
			
		}
		
		private function update(e:Event):void{
			playerCircle.x = stage.mouseX;
			playerCircle.y = stage.mouseY;
			
			fing.x = stage.mouseX;
			fing.y = stage.mouseY;
			
			_flash.x = stage.mouseX;
			_flash.y = stage.mouseY;
			
			
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
						//howMany.howManyText.text= mobsDestroyed+"/"+mobsToDestroy[levelToPlay];
						howMany.cc.text=mobsDestroyed+"/"+mobsToDestroy[levelToPlay];

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
						//addChild(fing);
					}	
				}
			}
			
		
		
		
	
			
			
		}
		
		
		
		private function gameGame(event:MouseEvent):void{
			//removeChild(fing);
			//removeChild(_maska);
			//var bg:BackgroundImage = new BackgroundImage();
			//addChild(bg);
			//battleField.removeChild(levelIntro);
			//playerStarted=true;
			//addChild(cyfra);
			//cyfra.alpha = .1;
			var gameMusic2:muza1 = new muza1;
			var soundChannel2:SoundChannel=gameMusic2.play(0,1);
			
			//TweenLite.to(levelIntro, 0, {scaleX:0, scaleY:0, delay:2});
			fing.jojo();
			//_flash.zo22();
			//_flash.alpha = .6;
			//_flash.zo22();
			fing.alpha = 0;
			if (! playingGame) {
				playingGame = true;
				removeChild(gameTitle);
				removeChild(playerCircle);
				//playerStarted=true;
				//removeChild(fing);
				//fing.alpha = 0;
				//boo = true;
				playLevel();
				//boo = true;
			}
			else {
				if (playerStarted && !playerExploded){
					playerExploded = true;
					_flash.alpha = .6;
					_flash.zo22();
					for (var i:Number=1; i<=4; i++){
						var theBullet:TheBullet=new TheBullet(new PlayerBullet(),playerCircle,Math.PI*i/2);
						bulletVector.push(theBullet);
						battleField.addChild(theBullet.theSprite);
						
					}
					playerCircle.alpha=0;
					//fing.alpha = 0;
					
				}
				if (! playerStarted) {
					battleField.removeChild(levelIntro);
					// game jeden start
					//addChild(Tlo);
					playerStarted=true;
			}
			
		}
		}
		
		
		private function playLevel():void{
			if (levelToPlay==20) {
				//var congratzScreen:CongratzScreen=new CongratzScreen();
				//addChild(congratzScreen);
			}
			else {
				dieAnyway=false;
				mobVector=new Vector.<TheMob>();
				bulletVector=new Vector.<TheBullet>();
				playerStarted=false;
				playerExploded=false;
				if (battleField!=null) {
					removeChild(battleField);
				}
				battleField=new Sprite();
				addChild(battleField);
				var loseAnyway:Boolean=false;
				var numberOfMobs:Number=greenMobs[levelToPlay]+blueMobs[levelToPlay]+yellowMobs[levelToPlay]+purpleMobs[levelToPlay];
				mobsDestroyed=0;
				var collisionArray:Array= new Array();
				howMany=new okno();
				//howMany.howManyText.text=mobsDestroyed+"/"+mobsToDestroy[levelToPlay];
				howMany.cc.text=mobsDestroyed+"/"+mobsToDestroy[levelToPlay];

				//cyfra.tete.text = "5";
				battleField.addChild(howMany);
				levelIntro=new LevelIntro();
				levelIntro.x=480;//250
				levelIntro.y=400;//250
				levelIntro.levelName.text="Level "+(levelToPlay+1);
				
				levelIntro.levelNotes.text=levelDescription[levelToPlay];
				TweenLite.to(levelIntro, 0, {scaleX:0, scaleY:0});
				battleField.addChild(levelIntro);
				
				TweenLite.to(levelIntro, .7, {scaleX:1, scaleY:1});
				playerCircle=new PlayerCircle();
				//fing.alpha = 0;
				
				playerCircle.alpha = 0;
				battleField.addChild(playerCircle);
				for (var i:Number=0; i<greenMobs[levelToPlay]; i++) {
					var theMob:TheMob=new TheMob(new GreenMob());
					mobVector.push(theMob);
					battleField.addChild(theMob.theSprite);
				}
				for (i=0; i<blueMobs[levelToPlay]; i++) {
					theMob=new TheMob(new BlueMob());
					mobVector.push(theMob);
					battleField.addChild(theMob.theSprite);
				}
				for (i=0; i<yellowMobs[levelToPlay]; i++) {
					theMob=new TheMob(new YellowMob());
					mobVector.push(theMob);
					battleField.addChild(theMob.theSprite);
				}
				for (i=0; i<purpleMobs[levelToPlay]; i++) {
					theMob=new TheMob(new PurpleMob());
					mobVector.push(theMob);
					battleField.addChild(theMob.theSprite);
				}
			}
		
			
		}
	}
}