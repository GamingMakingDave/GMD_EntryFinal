if Config.DebugMode then
    RegisterCommand('debugisNew', function(source, args)
        TriggerEvent('GMD_Entry:PlayerIsNew')
    end, false)

    RegisterCommand('debugdimension', function(source, args)
        print(Dimension)
    end, false)

    RegisterCommand('debugillegalscene', function(source, args)
        TriggerClientEvent('GMD_Entry:IllegalCutscene', source)
    end, false)

    RegisterCommand('debugpaycheck', function(source, args)
        StartPayCheckGMD()
    end, false)

    RegisterCommand('debuglegalscene', function(source, args)
        TriggerClientEvent('GMD_Entry:LegalCutscene', source)
    end, false)
end

RegisterCommand("enterentry", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "gmd.entry") or Config.DebugMode then
        if CheckCommandValid({'illegal', 'legal'}, args[1]) and CheckCommandValid({'admin1', 'admin2'}, args[2]) then
            EntryType = args[1]
            SkinID = args[2]
            SaveAdminCoords('Add', source, EntryType, SkinID)
        else
            print("Falsche parameter")
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                multiline = true,
                args = {"Server", "Du hast falsche Parameter für den Command benutzt."}
            })
        end
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Server", "Dieser Befehl ist nur für Admins verfügbar."}
        })
    end
end, false)

RegisterCommand("exitentry", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "gmd.entry") or Config.DebugMode then
        SaveAdminCoords('Remove', source)
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Server", "Du bist kein Admin!"}
        })
    end
end, false)

RegisterCommand("playerentry", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "gmd.entry") or Config.DebugMode then
        local playerid = tonumber(args[1])
        if playerid ~= nil then
            local players = GetPlayers()
            local isPlayerOnline = false
            for _, player in ipairs(players) do
                if tonumber(player) == playerid then
                    isPlayerOnline = true
                    break
                end
            end
            if isPlayerOnline then
                TriggerEvent('GMD_Entry:PlayerEntry', playerid)
            else
                TriggerClientEvent('esx:showNotification', source, 'Es ist kein Spieler mit dieser ID Online!')
                print('Der Spieler ist nicht online.')
            end
        end
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Server", "Dieser Befehl ist nur für Admins verfügbar."}
        })
    end
end, false)