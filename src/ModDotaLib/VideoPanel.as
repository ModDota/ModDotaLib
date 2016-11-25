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
			videoContainer.x = 0;
			videoContainer.y = 0;
			videoContainer.width = 512;
			videoContainer.height = 512;
		}
		
		public function startCardVideo(videoFilename:String) : * {
		     trace("Starting video: "+videoFilename);
			 this.cardVideoController.startVideo(0,videoContainer,videoFilename);
			 videoContainer.mouseEnabled = false;
			 videoContainer.mouseChildren = false;
			 videoContainer.alpha = 0;
			 var t:Tween = new Tween(200,videoContainer,{"alpha":1},{"ease":None.easeNone});
			 t.delay = 100;
		}
	}
	
}
