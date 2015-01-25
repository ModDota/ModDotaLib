package ModDotaLib.Utils {
	import flash.utils.getDefinitionByName;
	
	public class AssetUtils {
		public static function CreateAsset(type) {
			var objclass = getDefinitionByName(type);
			var obj = objclass();
			return obj;
		}
		
		public static function AdoptAsset(child, adoptedParent) {
			var griefingMother = child.parent;
			griefingMother.removeChild(child);
			adoptedParent.addChild(child);
			
			return child;
		}
		public static function ReplaceAsset(btn, type) {
			var parent = btn.parent;
			var oldx = btn.x;
			var oldy = btn.y;
			var oldwidth = btn.width;
			var oldheight = btn.height;
			var olddepth = parent.getChildIndex(btn);
			var oldname = btn.name;

			var newObjectClass = getDefinitionByName(type);
			var newObject = new newObjectClass();
			newObject.x = oldx;
			newObject.y = oldy;
			newObject.width = oldwidth;
			newObject.height = oldheight;
			newObject.name = oldname;
			
			parent.removeChild(btn);
			parent.addChild(newObject);
			
			parent.setChildIndex(newObject, olddepth);
			
			return newObject;
		}
	}
}