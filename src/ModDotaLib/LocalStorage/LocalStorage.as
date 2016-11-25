package ModDotaLib.LocalStorage {
	public class LocalStorage {
		public var gameAPI:Object;
		public var globals:Object;
		
		
		public LocalStorage(gameAPI:Object, globals:Object) {
			this.gameAPI = gameAPI;
			this.globals = globals;
			gameAPI.SubscribeToGameEvent("moddota_localstorage_inbound", this.onMessage);
		}
		
		public void onMessage(keys:Object) {
			
		}
	}
}