package {
	import ModDotaLib.Utils.DebugUtils;
	import flash.display.MovieClip;
	
	import ModDotaLib.LocalStorage.LocalStorage;
	
	public class ModDotaLib extends MovieClip {
		// Game API related stuff
        public var gameAPI:Object;
        public var globals:Object;
        public var elementName:String;
		
		public var localStorage:LocalStorage;
		
		//Entry point for Valve Scaleform
		public function onLoaded() : void {
			localStorage = new LocalStorage(gameAPI, globals);
		}
	}
	
}
