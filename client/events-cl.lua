ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('GMD_Entry:PlayerIsNew')
AddEventHandler('GMD_Entry:PlayerIsNew', function(source)
    if not ESX.PlayerData.dead then
        EnableNUI(true)
    end
end)

RegisterNetEvent('GMD_Entry:FinishedEntryTeleport')
AddEventHandler('GMD_Entry:FinishedEntryTeleport', function(entry_type)
    local playerPed = PlayerPedId()
    SetPlayerInvincible(playerPed, false)
    PlayerInEntryDimension = false
    DoScreenFadeOut(1500)
    Wait(1500)
    if entry_type then
        SetEntityCoords(playerPed, Config.PlayerIllegalEntrySpawn, false, false, false, false)
        SetEntityHeading(playerPed, Config.PlayerIllegalEntrySpawnHeading)
    else
        SetEntityCoords(playerPed, Config.PlayerLegalEntrySpawn, false, false, false, false)
        SetEntityHeading(playerPed, Config.PlayerLegalEntrySpawnHeading)
    end
    DoScreenFadeIn(1500)
end)


RegisterNUICallback('SelectEntryType', function(data, cb)
    if data.select == 'legal' then
        legal = true
        TriggerServerEvent('GMD_Entry:SyncLegalWay')
        TriggerServerEvent('GMD_Entry:SetSceneBucket')
    else
        TriggerServerEvent('GMD_Entry:SyncIllegalWay')
        TriggerServerEvent('GMD_Entry:SetSceneBucket')
    end
end)

RegisterNUICallback('NoRules', function(data, cb)
    EnableNUI(false)
      if legal then
        TriggerEvent('GMD_Entry:LegalCutscene')
        -- legal = false
      else
        TriggerEvent('GMD_Entry:IllegalCutscene')
      end
end)

RegisterNUICallback('failedQuestions', function(data, cb)
   TriggerServerEvent('GMD_Entry:KickPlayer')
end)

RegisterNUICallback('SuccesQuestions', function(data, cb)
    EnableNUI(false)
    if legal then
        TriggerEvent('GMD_Entry:LegalCutscene')
        -- legal = false
      else
        TriggerEvent('GMD_Entry:IllegalCutscene')
      end
end)

RegisterNetEvent('GMD_Entry:showNotify')
AddEventHandler('GMD_Entry:showNotify', function(playerServerId)
    local playerName = GetPlayerName(PlayerId())
    if playerServerId == GetPlayerServerId(PlayerId()) then
        if legal then
            SetNotificationTextEntry('STRING')
        AddTextComponentString("Der Spieler ~g~" .. playerName .. " ~w~mit der ID ~r~" .. playerServerId .. " ~w~befindet sich in der Legalen Einreise.")
        DrawNotification(false, false)
        else
        SetNotificationTextEntry('STRING')
        AddTextComponentString("Der Spieler ~g~" .. playerName .. " ~w~mit der ID ~r~" .. playerServerId .. " ~w~befindet sich in der Illegalen Einreise.")
        DrawNotification(false, false)
        end
    end
end)

RegisterNetEvent('GMD_Entry:teleportPlayerExit')
AddEventHandler('GMD_Entry:teleportPlayerExit', function(heading, coords)
    local ped = GetPlayerPed(-1)
    DoScreenFadeOut(500)
    Wait(1000)

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					local isMale = skin.sex == 0

					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
    SetEntityHeading(ped, heading)
    SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, false)
    Wait(1000)
    DoScreenFadeIn(500)
end)

RegisterNetEvent('GMD_Entry:teleportPlayer')
AddEventHandler('GMD_Entry:teleportPlayer', function(EntryType, SkinID)
    local playerPed = PlayerPedId()
    local skinConfig = nil
    DoScreenFadeOut(500)
    Wait(1000)
    if EntryType == 'legal' then
        if SkinID == 'admin1' then
            skinConfig = Config.LegalAdminSkins.admin1
        elseif SkinID == 'admin2' then
            skinConfig = Config.LegalAdminSkins.admin2
        elseif SkinID == 'admin3' then
            skinConfig = Config.LegalAdminSkins.admin3
        else
            return
        end
        if skinConfig then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then
                    if Config.LegalAdminSkins[SkinID].male then
                        TriggerEvent('skinchanger:loadClothes', skin, Config.LegalAdminSkins[SkinID].male)
                    else
                        ESX.ShowNotification((Config.Language[Config.Local]['no_outfit']), 5000)
                    end
                else
                    if Config.LegalAdminSkins[SkinID].female then
                        TriggerEvent('skinchanger:loadClothes', skin, Config.LegalAdminSkins[SkinID].female)
                    else
                        ESX.ShowNotification((Config.Language[Config.Local]['no_outfit']), 5000)
                    end
                end
            end)
        end
        SetEntityCoords(playerPed, Config.EntryGroupLegalSpawn, false, false, false, false)
        SetEntityHeading(playerPed, Config.EntryGroupLegalSpawnHeading)
    end
    if EntryType == 'illegal' then
        if SkinID == 'admin1' then
            skinConfig = Config.IllegalAdminSkins.admin1
        elseif SkinID == 'admin2' then
            skinConfig = Config.IllegalAdminSkins.admin2
        elseif SkinID == 'admin3' then
            skinConfig = Config.IllegalAdminSkins.admin3
        else
            return
        end
        if skinConfig then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then
                    if Config.IllegalAdminSkins[SkinID].male then
                        TriggerEvent('skinchanger:loadClothes', skin, Config.IllegalAdminSkins[SkinID].male)
                    else
                        ESX.ShowNotification((Config.Language[Config.Local]['no_outfit']), 5000)
                    end
                else
                    if Config.IllegalAdminSkins[SkinID].female then
                        TriggerEvent('skinchanger:loadClothes', skin, Config.IllegalAdminSkins[SkinID].female)
                    else
                        ESX.ShowNotification((Config.Language[Config.Local]['no_outfit']), 5000)
                    end
                end
            end)
        end
        SetEntityCoords(playerPed, Config.EntryGroupIllegalSpawn, false, false, false, false)
        SetEntityHeading(playerPed, Config.EntryGroupIllegalSpawnHeading)
    end
    Wait(1000)
    DoScreenFadeIn(500)
end)


TriggerEvent('chat:addSuggestion', '/enterentry', 'Teleport to EntryDimension', {
    { name="legal/illegal", help="entry spawnpoint" },
    { name="skin", help="select SkinName" }
})

TriggerEvent('chat:addSuggestion', '/playerentry', 'Entry Player', {
    { name="Player ID", help="Player ID" }
})