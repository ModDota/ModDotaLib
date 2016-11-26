package ModDotaLib.LocalStorage {
	import ModDotaLib.Utils.DebugUtils;

	public class LocalStorage {
		public var gameAPI:Object;
		public var globals:Object;
		
		//Our little enum of success
		public static const SUCCESS = 0;
		public static const WRITE_NOT_SUCCESSFUL = 1;
		public static const KEY_DOESNT_EXIST = 2;
		
		public function LocalStorage(gameAPI:Object, globals:Object) {
			this.gameAPI = gameAPI;
			this.globals = globals;
			gameAPI.SubscribeToGameEvent("moddota_localstorage_set", this.onSetKey);
			gameAPI.SubscribeToGameEvent("moddota_localstorage_get", this.onGetKey);
		}
		
		public function onSetKey(keys:Object) {
			//255 means local in our system. Panorama requested this.
			if (keys.pid == 255 || globals.Players.GetLocalPlayer() == keys.pid) {
				var file:Object = globals.GameInterface.LoadKVFile(keys.filename);
				trace("[ModDotaLib - LocalStorage] " + keys.filename + " Pre Write");
				ModDotaLib.Utils.DebugUtils.PrintTable(file);
				file[keys.key] = keys.value;
				globals.GameInterface.SaveKVFile(file, keys.filename, "ModDota_LocalStorage");
				//Just a test to see if our write worked.
				var file2:Object = globals.GameInterface.LoadKVFile(keys.filename);
				trace("[ModDotaLib - LocalStorage] " + keys.filename + " Post Write");
				ModDotaLib.Utils.DebugUtils.PrintTable(file2);
				
				gameAPI.SendServerCommand("moddota_localstorage_ack " + (file2[keys.key] == keys.value ? SUCCESS : WRITE_NOT_SUCCESSFUL) + " " + keys.sequenceNumber + " " + keys.pid)
			}			
		}
		public function onGetKey(keys:Object) {
			//255 means local in our system. Panorama requested this.
			if (keys.pid == 255 || globals.Players.GetLocalPlayer() == keys.pid) {
				var file:Object = globals.GameInterface.LoadKVFile(keys.filename);
				if (file.hasOwnProperty(keys.key)) {
					var value = file[keys.key];
					gameAPI.SendServerCommand("moddota_localstorage_value " + SUCCESS + " " + keys.sequenceNumber + " " + keys.pid + " " + value);
				} else {
					gameAPI.SendServerCommand("moddota_localstorage_value " + KEY_DOESNT_EXIST + " " + keys.sequenceNumber + " " + keys.pid);
				}
			}
		}
	}
}