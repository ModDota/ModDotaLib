local localStorage = require("ModDotaLib.LocalStorage")

Convars:RegisterCommand("storage_test", function(cmdname, key, value)
    if value then
        local seqNum = localStorage:setKey(Convars:GetCommandClient():GetPlayerID(), "testing", key, value, function(sequenceNumber, success)
            print("[Test] " .. sequenceNumber .. "|" .. success)
        end)
        print("[Test] " .. seqNum)
    else
        local seqNum = localStorage:getKey(Convars:GetCommandClient():GetPlayerID(), "testing", key, function(sequenceNumber, success, value)
            if success == 0 then
                print("[Test] " .. sequenceNumber .. "|" .. success .. "|" .. value)
            else
                print("[Test] " .. sequenceNumber .. "|" .. success)
            end
        end)
        print("[Test] " .. seqNum)
    end
end, "Fuck", 0)