# ModDotaLib
A Flash library for Dota 2 custom gamemodes

## LocalStorage
A Flash, Lua and optionally Panorama Library to give gamemodes the ability to have Local Storage in a flat Key Value system, much like Cookies found in Web Browsers.

### Installation
1. Drag and drop the `assets/resource/flash3/` folder to your `game/resource/` folder (if it exists) and you might need to merge with any existing `custom_ui.txt`.

2. Drag and drop the `assets/scripts/custom_events.txt` to `game/scripts/` and merge if it already exists.

3. Drag and drop the `assets/scripts/vscripts/ModDotaLib/` folder to `game/scripts/vscripts/`

4. in `addon_game_mode.lua` add `local storage = require("ModDotaLib.LocalStorage")`, and anywhere else in server-side Lua that wants access to client key/values.

5. Create the folder `tools` in `scripts/` for this to work in tools mode. This is to protect you from accidently shipping data to the end user via a VPK, which will override any read you attempt to do.

6. (Optional) Drag and drop the `assets/panorama/scripts/ModDota` folder to `content/panorama/scripts/`

7. (Optional) Merge `assets/panorama/layout/custom_game/custom_ui_manifest.xml` with your existing `custom_ui_manifest.xml` (adding our JS to your scripts tag **BEFORE** any of your existing code that relies on LocalStorage)

### Examples
Lua Example is available at [addon_game_mode.lua](https://github.com/ModDota/ModDotaLib/blob/master/assets/scripts/vscripts/addon_game_mode.lua)
* Using this example, you gain a command called `storage_test key value`. If value isn't specified, assumes a Get request rather than a set.
* Writes to `testing.kv`

Panorama Example is available at [example.js](https://github.com/ModDota/ModDotaLib/blob/master/assets/panorama/scripts/custom_game/example.js)
* Using this example, you gain a command called `storage_testpanorama key value`. If value isn't specified, assumes a Get request rather than a set.
* Writes to `testing2.kv`


### API
#### Lua
```lua
local storage = require("ModDotaLib.LocalStorage")
-- playerID: number, fileName: string, key: string, value: string, callback: function
function getCallback(sequenceNumber, success, value)
    --success of 0 means it worked, and value will exist as a variable, otherwise value is nil.
end
local sequenceNumber = storage:getKey(playerID, fileName, key, getCallback)

function setCallback(sequenceNumber, success)
    --success of 0 means it worked.
end
local sequenceNumber = storage:getKey(playerID, fileName, key, value, setCallback)
```
#### Panorama
```js
//success of 0 means it worked.
function SetCallback(sequenceNumber, success) {};
var sequenceNumber = GameEvents.SetKey(filename, key, value, SetCallback);

//success of 0 means it worked, and value will be defined, otherwise value is undefined.
function GetCallback(sequenceNumber, success, value) {};
var sequenceNumber = GameEvents.GetKey(filename, key, GetCallback);
```