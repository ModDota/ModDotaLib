﻿package ModDotaLib.RealAssets {
	
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;
	import scaleform.clik.motion.Tween;
	import fl.transitions.easing.*;
	
	import ModDotaLib.Utils.AssetUtils;
	import ModDotaLib.VideoPanel;
	
	public class HeroPortrait extends MovieClip {
		
		public var heroName;
		public var videoContainer;
		public var statIcon;
		public var cardBG;
		
		public function HeroPortrait() {
			var oldcard = AssetUtils.CreateAsset("s_HeroCard");
			
			videoContainer = new VideoPanel();
			videoContainer.visible = true;
			//videoContainer.x = 0;
			//videoContainer.y = 0;
			//videoContainer.width = 1337;
			//videoContainer.height = 1337;
			videoContainer.x = 2 * this.width / 48;
			videoContainer.y = 4 * this.height / 48;
			//videoContainer.width = 6*this.width /12;
			//videoContainer.height = 6*this.height / 12;
			videoContainer.width = this.width - videoContainer.x;
			videoContainer.height = this.height - videoContainer.y;
			addChild(videoContainer);

			cardBG = AssetUtils.AdoptAsset(oldcard.card.cardFront.cardBG, this);
			cardBG.imageHolder.visible = false;
			cardBG.x = this.x;
			cardBG.y = this.y;
			cardBG.width = 1.04 * this.width;
			cardBG.height = 1.11 * this.height;
			
			statIcon = AssetUtils.AdoptAsset(oldcard.card.cardFront.statIcon, this);
			statIcon.visible = true;
			statIcon.scaleX = statIcon.scaleX * 2.9;
			statIcon.scaleY = statIcon.scaleY * 2.9;
			statIcon.x = statIcon.x + 9*this.width/24;
			//statIcon.y = statIcon.y + 1*this.height/24;
			
			heroName = AssetUtils.AdoptAsset(oldcard.card.cardFront.heroName, this);
			heroName.scaleX = heroName.scaleX * 2;
			heroName.scaleY = heroName.scaleY * 2;
			heroName.x = heroName.x * 2.5;
			heroName.y = heroName.y * 2.5;
			heroName.visible = true;
			
			//Time to set the statIcon
			//Attribute, 1=Str, 2=Agi, 3=Int
			var statPipIndex = 1;		
			statIcon.gotoAndStop(statPipIndex + 1);
			statIcon.pipIndex = statPipIndex;
            statIcon.pipNumber = 0;
		}
		public function SetHero(name:String, attribute:int = 1, videoName:String = "") {
			heroName.text = name;
			
			//Time to set the statIcon
			//Attribute, 1=Str, 2=Agi, 3=Int
			var statPipIndex = attribute;		
			statIcon.gotoAndStop(statPipIndex + 1);
			statIcon.pipIndex = statPipIndex;
            statIcon.pipNumber = 0;
			
			if (videoName == "") {
				videoName = name;
			}
			startCardVideo(videoName);
		}
		public function startCardVideo(heroName:String) : * {
			 videoContainer.startCardVideo("videos/portraits/" + heroName + ".usm");
		}
	}
	
}
