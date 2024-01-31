ESX = exports['es_extended']:getSharedObject()
adminCoords = {}

RegisterServerEvent('GMD_Entry:WrongGameBuild')
AddEventHandler('GMD_Entry:WrongGameBuild', function()
    print("\n^3----------------------------------------------------------------------------------^7")
    print("\n The script GMD_Entry can ^1not^7 start correctly because you have a wrong gamebuild. Here you find more information: ^2https://docs.fivem.net/docs/server-manual/server-commands/#sv_enforcegamebuild-build")
    print("\n^3----------------------------------------------------------------------------------^7")
end)

RegisterServerEvent('GMD_Entry:SkinTrigger')
AddEventHandler('GMD_Entry:SkinTrigger', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local row = MySQL.single.await('SELECT `entry_isnew` FROM `users` WHERE `identifier` = ? LIMIT 1', {
        xPlayer.getIdentifier()
    })
    if row.entry_isnew == false then
        TriggerClientEvent('GMD_Entry:PlayerIsNew', source, row)
    end
end)

RegisterServerEvent('GMD_Entry:notifyAdmin')
AddEventHandler('GMD_Entry:notifyAdmin', function(playerServerId)
    local adminPlayers = {}
    for _, playerId in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer and xPlayer.getGroup() == 'admin' then
            table.insert(adminPlayers, playerId)
        end
    end

    if #adminPlayers > 0 then
        for _, adminId in ipairs(adminPlayers) do
            TriggerClientEvent('GMD_Entry:showNotify', adminId, playerServerId)
        end
    end
end)


RegisterNetEvent('GMD_Entry:PlayerEntry')
AddEventHandler('GMD_Entry:PlayerEntry', function(playerid)
    local xPlayer = ESX.GetPlayerFromId(playerid)
    MySQL.Async.fetchScalar('SELECT entry_type FROM users WHERE identifier = @identifier', 
    {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(entryType)
        if entryType == false or entryType == true then
            MySQL.Async.execute('UPDATE users SET entry_dimension = @entry_dimension WHERE identifier = @identifier',
            {
                ['@entry_dimension'] = 0,
                ['@identifier'] = xPlayer.getIdentifier()
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    TriggerClientEvent('GMD_Entry:FinishedEntryTeleport', playerid, entryType)
                else
                    print((Config.Language[Config.Local]['db_type_error']))
                end
            end)
        else
            print((Config.Language[Config.Local]['db_type_nil']))
        end
    end)
end)

RegisterServerEvent('GMD_Entry:SyncLegalWay')
AddEventHandler('GMD_Entry:SyncLegalWay', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    MySQL.Async.execute('UPDATE users SET entry_type = @entry_type, entry_isnew = @entry_isnew, entry_dimension = @entry_dimension WHERE identifier = @identifier',
    {
        ['@entry_type'] = 0,
        ['@entry_isnew'] = 1,
        ['@entry_dimension'] = Config.BasicEntryDimension,
        ['@identifier'] = identifier
    }, function(rowsChanged)
        TriggerClientEvent('GMD_Entry:HasLegalWay', source)
    end)
end)


RegisterServerEvent('GMD_Entry:SetSceneBucket')
AddEventHandler('GMD_Entry:SetSceneBucket', function()
    Dimension = Dimension + 1
    SetPlayerRoutingBucket(source, Dimension)
end)

RegisterServerEvent('GMD_Entry:SetNPCBucket')
AddEventHandler('GMD_Entry:SetNPCBucket', function()
    SetPlayerRoutingBucket(source, Config.BasicEntryDimension)
end)

RegisterServerEvent('GMD_Entry:SetEntryBucket')
AddEventHandler('GMD_Entry:SetEntryBucket', function()
    SetPlayerRoutingBucket(source, Config.BasicEntryDimension)
end)

RegisterServerEvent('GMD_Entry:SyncIllegalWay')
AddEventHandler('GMD_Entry:SyncIllegalWay', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    MySQL.update.await('UPDATE users SET entry_type = @entry_type, entry_isnew = @entry_isnew, entry_dimension = @entry_dimension WHERE identifier = @identifier',
	{
        ['@entry_type'] = 1,
        ['@entry_isnew'] = 1,
        ['@entry_dimension'] = Config.BasicEntryDimension,
        ['@identifier'] = identifier
    }, function(rowsChanged)
        TriggerClientEvent('GMD_Entry:HasIllegalWay', source)
    end)
end)

RegisterServerEvent('GMD_Entry:KickPlayer')
AddEventHandler('GMD_Entry:KickPlayer', function()
    DropPlayer(source, (Config.Language[Config.Local]['ban_field']))
    local xPlayer = ESX.GetPlayerFromId(source)
    local entryDuration = os.time()
    local formattedDate = os.date("%Y-%m-%d %H:%M:%S", entryDuration)
    MySQL.update.await('UPDATE users SET entry_ban = @entry_ban, entry_duration = @entry_duration WHERE identifier = @identifier',
	{
        ['@entry_ban'] = 1,
        ['@entry_duration'] = formattedDate,
        ['@identifier'] = xPlayer.getIdentifier()
	})
end)

function SaveAdminCoords(Type, PlayerID, EntryType, SkinID)
    local xPlayer = ESX.GetPlayerFromId(PlayerID)
    local identifier = xPlayer.getIdentifier()
    local EntryTypeID

    -- Create table if not exist
    if not adminCoords[identifier] then
        adminCoords[identifier] = {}
    end

    if Type == 'Add' then
        EntryTypeID = 1

        adminCoords[identifier].heading = GetEntityHeading(GetPlayerPed(PlayerID))
        adminCoords[identifier].coords = GetEntityCoords(GetPlayerPed(PlayerID))
        TriggerClientEvent('GMD_Entry:teleportPlayer', PlayerID, EntryType, SkinID)
    elseif Type == 'Remove' then
        EntryTypeID = 0
        
        if adminCoords[identifier] then
            TriggerClientEvent('GMD_Entry:teleportPlayerExit', PlayerID, adminCoords[identifier].heading, adminCoords[identifier].coords)
            -- Data from Player gets deleted from table
            adminCoords[identifier] = nil
        end
    end
    if EntryTypeID == 0 or EntryTypeID == 1 then
        -- Saves Dimension in DB
        SetPlayerRoutingBucket(PlayerID, EntryTypeID)
        MySQL.update('UPDATE users SET entry_dimension = @entry_dimension WHERE identifier = @identifier',
        {
            ['@entry_dimension'] = EntryTypeID,
            ['@identifier'] = identifier
        },
        function(rowsChanged)
            if Config.DebugMode then
                if rowsChanged > 0 then
                    print((Config.Language[Config.Local]['db_edit']))
                else
                    print((Config.Language[Config.Local]['db_error']))
                end
            end
        end)
    else 
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Server", "Deine Koordinaten wurden nicht gespeichert."}
        })
    end
end