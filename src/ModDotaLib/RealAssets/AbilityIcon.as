package ModDotaLib.RealAssets {
	
	import flash.display.MovieClip;
	import ValveLib.Globals;
	
    import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class AbilityIcon extends MovieClip {
		public var img;
		
		public function SetAbility(abilityName) {
			var img = new ResourceIcon(abilityName);
			img.addEventListener(MouseEvent.ROLL_OVER, onMouseRollOver, false, 0, true);
			img.addEventListener(MouseEvent.ROLL_OUT, onMouseRollOut, false, 0, true);
			img.itemName = abilityName;
			img.resourceName = abilityName;
			Globals.instance.LoadAbilityImage(abilityName, img);
			img.x = 1;
			img.y = 1;
			img.scaleX = this.width*this.scaleX / 80;
			img.scaleY = this.height*this.scaleY / 80;
			addChild(img);
		}
       	public function onMouseRollOver(keys:MouseEvent){
       		var s:Object = keys.target;
            // Workout where to put it
            var lp:Point = s.localToGlobal(new Point(0, 0));
            // Decide how to show the info
            if(lp.x < Globals.instance.Loader_teve2.movieClip.width/2) {
                // Workout how much to move it
                var offset:Number = this.width;
                // Face to the right
                Globals.instance.Loader_rad_mode_panel.gameAPI.OnShowAbilityTooltip(lp.x+offset, lp.y, s.getResourceName());
            } else {
                // Face to the left
                Globals.instance.Loader_heroselection.gameAPI.OnSkillRollOver(lp.x, lp.y, s.getResourceName());
            }
       	}

       	public function onMouseRollOut(keys:Object){
       		 Globals.instance.Loader_heroselection.gameAPI.OnSkillRollOut();
       	}
	}
	
}
