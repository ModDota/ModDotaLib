package ModDotaLib {
	
	import flash.display.MovieClip;
	import ModDotaLib.Utils.AssetUtils;
	
	import ValveLib.Controls.VideoController;
	import scaleform.clik.motion.Tween;
	import fl.transitions.easing.*;

	
	public class VideoPanel extends MovieClip {
		public var cardVideoController:VideoController = new VideoController(1);
		public var videoContainer;
		
		public function VideoPanel() {
			var newcard = AssetUtils.CreateAsset("s_FullDeckCardWithMovie");
			
			videoContainer = AssetUtils.AdoptAsset(newcard.selectorBG.portraitVideoContainer, this);
			videoContainer.visible = true;
			videoContainer.x = 2 * this.width / 48;
			videoContainer.y = 4 * this.height / 48;
			videoContainer.width = 6*this.width /12;
			videoContainer.height = 6*this.height / 12;
		}
		
		public function startCardVideo(videoFilename:String) : * {
			 this.cardVideoController.startVideo(0,videoContainer,videoFilename);
			 videoContainer.mouseEnabled = false;
			 videoContainer.mouseChildren = false;
			 videoContainer.alpha = 0;
			 var t:Tween = new Tween(200,videoContainer,{"alpha":1},{"ease":None.easeNone});
			 t.delay = 100;
		}
	}
	
}
