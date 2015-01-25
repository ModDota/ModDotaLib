package ModDotaLib.RealAssets {
	
	import flash.display.MovieClip;
	import ValveLib.Globals;
	
    import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class AbilityIcon extends MovieClip {
		public var img;
		
		public function SetAbility(abilityName) {
			var img = new ResourceIcon(abilityName);
			trace("Instanced icon");
			img.addEventListener(MouseEvent.ROLL_OVER, onMouseRollOver, false, 0, true);
			img.addEventListener(MouseEvent.ROLL_OUT, onMouseRollOut, false, 0, true);
			img.itemName = abilityName;
			img.resourceName = abilityName;
			Globals.instance.LoadAbilityImage(abilityName, img);

			trace("loaded image");
			img.scaleX = this.width*this.scaleX / 128;
			img.scaleY = this.height*this.scaleY / 128;
			addChild(img);
		}
       	public function onMouseRollOver(keys:MouseEvent){
       		var s:Object = keys.target;
       		trace("roll over! " + s.itemName);
            // Workout where to put it
            var lp:Point = s.localToGlobal(new Point(0, 0));
			trace("1");
            // Decide how to show the info
            if(lp.x < Globals.instance.Loader_teve2.movieClip.width/2) {
				trace("2");
                // Workout how much to move it
                var offset:Number = this.width; //TODO: make this not a special number
				trace("3");
                // Face to the right
                Globals.instance.Loader_rad_mode_panel.gameAPI.OnShowAbilityTooltip(lp.x+offset, lp.y, s.getResourceName());
				trace("4");
            } else {
				trace("5");
                // Face to the left
                Globals.instance.Loader_heroselection.gameAPI.OnSkillRollOver(lp.x, lp.y, s.getResourceName());
				trace("6");
            }
       	}

       	public function onMouseRollOut(keys:Object){
       		 Globals.instance.Loader_heroselection.gameAPI.OnSkillRollOut();
       	}
	}
	
}
