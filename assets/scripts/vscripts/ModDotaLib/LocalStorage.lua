local SUCCESS = 0

local storage = class({})

--This also exists in the Panorama section of the library
local function storage:setKey(playerID, filename, key, value, callback)
    self.sequenceNumber = self.sequenceNumber + 1
    if IsInToolsMode() then
        print("[ModDotaLib - LocalStorage] WARNING: Running LocalStorage in tools mode. Using alternate location to prevent read-only storage for end users")
    end
    FireGameEvent("moddota_localstorage_set", {
        filename = "scripts/moddota_storage/" + (IsInToolsMode() and "tools/" or "live/") + filename + ".kv",
        key = key,
        value = value,
        sequenceNumber = self.sequenceNumber,
        pid = playerID
    })
    self.db[sequenceNumber] = {
        callback = callback,
        pid = playerID
    }
    return self.sequenceNumber
end
local function storage:getKey(playerID, filename, key, value)
    self.sequenceNumber = self.sequenceNumber + 1
    FireGameEvent("moddota_localstorage_get", {
        filename = "scripts/moddota_storage/" + (IsInToolsMode() and "tools/" or "live/") + filename + ".kv",
        key = key,
        sequenceNumber = self.sequenceNumber,
        pid = playerID
    })
    self.db[sequenceNumber] = {
        callback = callback,
        pid = playerID
    }
    return self.sequenceNumber
end
Convars:RegisterCommand("moddota_localstorage_ack", function(success, sequenceNumber)
    if success ~= SUCCESS then
        print("[ModDotaLib - LocalStorage] Save failed.")
    end
    --Regardless of success or failure, we need to report back to the gamemode
    storage.db[sequenceNumber].callback(sequenceNumber, success)
end, "Fuck", 0)
Convars:RegisterCommand("moddota_localstorage_value", function(success, sequenceNumber, value)
    if success ~= SUCCESS then
        print("[ModDotaLib - LocalStorage] Load failed.")
        --TODO: Do more detailed analysis of why it fucked up.
        storage.db[sequenceNumber].callback(sequenceNumber, success)
    else
        storage.db[sequenceNumber].callback(sequenceNumber, success, value)
    end
end, "Fuck", 0)

return storage