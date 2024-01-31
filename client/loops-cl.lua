ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    while true do
        local sleep = 1500
        if EnabledNUI then
            sleep = 0
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
            DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
            DisableControlAction(0, 142, true) -- MeleeAttackAlternate
            DisableControlAction(0, 30, true) -- MoveLeftRight
            DisableControlAction(0, 31, true) -- MoveUpDown
            DisableControlAction(0, 21, true) -- disable sprint
            DisableControlAction(0, 24, true) -- disable attack
            DisableControlAction(0, 25, true) -- disable aim
            DisableControlAction(0, 47, true) -- disable weapon
            DisableControlAction(0, 58, true) -- disable weapon
            DisableControlAction(0, 263, true) -- disable melee
            DisableControlAction(0, 264, true) -- disable melee
            DisableControlAction(0, 257, true) -- disable melee
            DisableControlAction(0, 140, true) -- disable melee
            DisableControlAction(0, 141, true) -- disable melee
            DisableControlAction(0, 143, true) -- disable melee
            DisableControlAction(0, 75, true) -- disable exit vehicle
            DisableControlAction(27, 75, true) -- disable exit vehicle
        else
            sleep = 1500
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while not IsLoopClosed do
        Wait(1)
        if PlayerInEntry then
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 4, true)
            EnableControlAction(0, 6, true)
            EnableControlAction(0, 10, true)
            EnableControlAction(0, 11, true)
            EnableControlAction(0, 18, true)
            DisableControlAction(0, 73, true)
            DisableControlAction(0, 75, true) -- disable exit vehicle
            HideHudComponentThisFrame(5)
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)
            DisplayRadar(false)
            if Config.UseEsxHUD then
                ESX.UI.HUD.SetDisplay(0.0)
            else
                -- here you hide event from HUD
            end

            if Config.UseEsxStatusBar then
                TriggerEvent('esx_status:setDisplay', 0.0)
            else
                -- here you hide event from STATUSBAR
            end
        else
            ShowHudComponentThisFrame(5)
            ShowHudComponentThisFrame(6)
            ShowHudComponentThisFrame(7)
            ShowHudComponentThisFrame(8)
            ShowHudComponentThisFrame(9)
            DisplayRadar(true)
            if Config.UseEsxHUD then
                ESX.UI.HUD.SetDisplay(1.0)
            else
                -- here you show event from HUD
            end

            if Config.UseEsxStatusBar then
                TriggerEvent('esx_status:setDisplay', 0.5)
            else
                -- here you show event from STATUSBAR
            end
            Wait(550)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        if not LegalnpcSpawned then
            if PlayerNearLegalNPC then
                local modelHash = GetHashKey("s_m_m_pilot_01") -- Beispiel-NPC-Modell, du kannst dies anpassen
                RequestModel(modelHash)
                while not HasModelLoaded(modelHash) do
                    Wait(200)
                end
                local npc1 = CreatePed(5, modelHash, Config.LegalEntryNotifyNPC, false, true) -- Der dritte Parameter (networked) wurde auf true gesetzt
                SetEntityInvincible(npc1, true)
                SetEntityHeading(npc1, Config.LegalEntryNotifyNPCHeading)
                FreezeEntityPosition(npc1, true) -- Der NPC wird eingefroren und kann sich nicht bewegen
                SetPedCanBeTargetted(npc1, false) -- Der NPC kann nicht als Ziel ausgewählt werden
                FreezeEntityPosition(npc1, true)
                SetEntityInvincible(npc1, true)
                SetBlockingOfNonTemporaryEvents(npc1, true)
                SetEveryoneIgnorePlayer(PlayerPedId(), true)
                SetPedCanBeTargettedByPlayer(npc1, PlayerPedId(), false) -- Der NPC kann nicht vom Spieler als Ziel ausgewählt werden
                local propHash = GetHashKey("prop_amb_coffeecup_01")
                local boneIndex = GetPedBoneIndex(npc1, 60309)
                local coords = GetPedBoneCoords(npc1, boneIndex)
                local prop1 = CreateObject(propHash, coords.x, coords.y, coords.z, true, true, true)
                AttachEntityToEntity(prop1, npc1, boneIndex, 0.09, 0.02, -0.05, -60.0, 0.0, 0.0, true, true, false, true, 1, true)
                TaskStartScenarioInPlace(npc1, "WORLD_HUMAN_DRINKING", 0, true)
                LegalnpcSpawned = true
                PlayerNearLegalNPC = false
                TriggerServerEvent('GMD_Entry:SetNPCBucket', npc1)
            end
        end
        Wait(550)
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        if not IllegalnpcSpawned then
            if PlayerNearIllegalNPC then
                local modelHash = GetHashKey("s_m_y_blackops_01")

                RequestModel(modelHash)
                while not HasModelLoaded(modelHash) do
                    Wait(200)
                end
                local npc2 = CreatePed(5, modelHash, Config.IllegalEntryNotifyNPC, false, true)
                SetEntityInvincible(npc2, true)
                SetEntityHeading(npc2, Config.IllegalEntryNotifyNPCHeading)
                FreezeEntityPosition(npc2, true)
                SetPedCanBeTargetted(npc2, false)
                FreezeEntityPosition(npc2, true)
                SetEntityInvincible(npc2, true)
                SetBlockingOfNonTemporaryEvents(npc2, true)
                SetEveryoneIgnorePlayer(PlayerPedId(), true)
                SetPedCanBeTargettedByPlayer(npc2, PlayerPedId(), false)
                SetPedCombatAttributes(npc2, 46, true)
                SetPedCombatAttributes(npc2, 17, true)
                SetPedCombatAttributes(npc2, 5, true)
                SetPedCombatAttributes(npc2, 20, true)
                SetPedCombatAttributes(npc2, 52, true)
                SetPedFleeAttributes(npc2, 0, false)
                SetPedFleeAttributes(npc2, 128, false)
                SetPedRelationshipGroupHash(npc2, GetHashKey("MILITARY"))
                SetPedAccuracy(npc2, 70)
                SetPedDropsWeaponsWhenDead(npc2, false)
                IllegalnpcSpawned = true
                PlayerNearIllegalNPC = false
                GiveWeaponToPed(npc2, GetHashKey("WEAPON_CARBINERIFLE"), 250, true, true)
                TriggerServerEvent('GMD_Entry:SetNPCBucket', npc2)
            end
        end
        Wait(550)
    end
end)


CreateThread(function()
    while true do
        local dist = #(GetEntityCoords(PlayerPedId()) - Config.LegalEntryNotifyNPC)
        if dist <= 4.0 and not LegalPressed then
            ESX.ShowHelpNotification((Config.Language[Config.Local]['npc_helptext']))
            if IsControlJustPressed(0, 38) then
                TriggerServerEvent('GMD_Entry:notifyAdmin', GetPlayerServerId(PlayerId()))
                ESX.ShowNotification((Config.Language[Config.Local]['npc_pressed']))
                LegalPressed = true
                Wait(Config.ReUseLegalNotifyTimer)
                LegalPressed = false
            end
        else
            Wait(2000)
        end
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        local dist = #(GetEntityCoords(PlayerPedId()) - Config.IllegalEntryNotifyNPC)
        if dist <= 4.0 and not IllegalPressed then
            ESX.ShowHelpNotification((Config.Language[Config.Local]['npc_helptext']))
            if IsControlJustPressed(0, 38) then
                TriggerServerEvent('GMD_Entry:notifyAdmin', GetPlayerServerId(PlayerId()))
                ESX.ShowNotification((Config.Language[Config.Local]['npc_pressed']))
                IllegalPressed = true
                Wait(Config.ReUseIllegalNotifyTimer)
                IllegalPressed = false
            end
        else
            Wait(2000)
        end
        Wait(1)
    end
end)