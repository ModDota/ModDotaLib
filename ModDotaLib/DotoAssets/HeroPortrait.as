package ModDotaLib.DotoAssets {
	
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import scaleform.clik.motion.Tween;
	import fl.transitions.easing.*;
	import ValveLib.Controls.VideoController;
	
	import ModDotaLib.Utils.AssetUtils;
	
	public class HeroPortrait extends MovieClip {
		
		public var heroName;
		public var videoContainer;
		public var statIcon;
		public var cardBG;
		
		public function HeroPortrait() {
			var oldcard = AssetUtils.CreateAsset("s_HeroCard");
			var newcard = AssetUtils.CreateAsset("s_FullDeckCardWithMovie");

			videoContainer = AssetUtils.AdoptAsset(newcard.selectorBG.portraitVideoContainer, this);
			videoContainer.visible = true;
			videoContainer.x = 2 * this.width / 48;
			videoContainer.y = 4 * this.height / 48;
			videoContainer.width = 6*this.width /12;
			videoContainer.height = 6*this.height / 12;

			cardBG = AssetUtils.AdoptAsset(oldcard.card.cardFront.cardBG, this);
			cardBG.imageHolder.visible = false;
			cardBG.x = this.x;
			cardBG.y = this.y;
			cardBG.width = this.width;
			cardBG.height = this.height;
			
			statIcon = AssetUtils.AdoptAsset(oldcard.card.cardFront.statIcon, this);
			statIcon.visible = true;
			statIcon.scaleX = statIcon.scaleX * 2;
			statIcon.scaleY = statIcon.scaleY * 2;
			statIcon.x = statIcon.x + 9*this.width/24;
			
			heroName = AssetUtils.AdoptAsset(oldcard.card.cardFront.heroName, this);
			heroName.scaleX = heroName.scaleX * 2;
			heroName.scaleY = heroName.scaleY * 2;
			heroName.x = heroName.x * 2;
			heroName.y = heroName.y * 2;
			heroName.visible = true;
			
			//Time to set the statIcon
			//Attribute, 1=Str, 2=Agi, 3=Int
			var statPipIndex = 3;		
			statIcon.gotoAndStop(statPipIndex + 1);
			statIcon.pipIndex = statPipIndex;
            statIcon.pipNumber = 0;
		}
		
		public function startCardVideo(heroName:String) : * {
			 var videoFilename:* = "videos/portraits/" + heroName + ".usm";
			 this.cardVideoController.startVideo(0,videoContainer,videoFilename);
			 videoContainer.mouseEnabled = false;
			 videoContainer.mouseChildren = false;
			 videoContainer.alpha = 0;
			 var t:Tween = new Tween(200,videoContainer,{"alpha":1},{"ease":None.easeNone});
			 t.delay = 100;
		}
	}
	
}
