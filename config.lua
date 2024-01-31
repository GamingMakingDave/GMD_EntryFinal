Config = {}

Config.Local = 'en' -- you local
Config.DebugMode = true -- DebugMode true for Debugging

-- config cutscenesettings
Config.UseEsxHUD = true -- if false go in loops-cl.lua line 66 & 84 and place here you HUD export or event
Config.UseEsxStatusBar = true -- if false go in loops-cl.lua line 71 & 90 and place here you statusbar export or event, if statusbar in HUD ignore that and set it false

-- Bantime in DAY,HOUR,MINUTES,SECONDS Format
Config.BanTime = {
    day = 7,
    hours = 24,
    minutes = 60,
    seconds = 60
}

-- entry dimension
Config.BasicEntryDimension = 1 -- If another script uses dimensions (SetPlayerRoutingBucket), it must be changed to a free dimension.

-- illegal settings
Config.EnableCayo = true -- enable/disable Cayo Perico via code

Config.SpawnIllegalEntry = vector3(5210.907, -5123.304, 5.156) -- player spawn coordinates after cutscene
Config.SpawnIllegalEntryHeading = 180.943 -- player spawn heading after cutscene

Config.PlayerIllegalEntrySpawn = vector3(5108.070, -5141.627, 1.936) -- player spawn coordinates after accept admin whitelist /enterplayer [ID]
Config.PlayerIllegalEntrySpawnHeading = 183.809 -- player spawn heading after accept admin whitelist /enterplayer [ID]

Config.IllegalEntryNotifyNPC = vector3(5204.057, -5123.559, 4.751) -- admin notifications NPC coordinates
Config.IllegalEntryNotifyNPCHeading = 253.61 -- admin notifications NPC Heading

Config.ReUseIllegalNotifyTimer = 300000 -- in ms, 300000 its 5 minutes

-- illegal cutscene settings
Config.UseIllegalCutscene = true
Config.OwnIllegalCutscene = function()
    -- here you own cutscene
end

Config.IllegalPed = 's_m_y_blackops_01'
Config.IllegalVehicle = 'squaddie'

-- don´t touch this if you don´t understand what you do / here can you add xSound Voicelines
-- illegal cutscnes text
Config.IllegalCutSceneText1 = function()
    Wait(5000)
    DoScreenFadeIn(2500)
    Wait(500)
    showsubtitle("Hey, how are you doing, buddy? I hope you made the right decision.", 5500)
    Wait(5500)
    showsubtitle("Now, things are about to get real. Just don't ask any questions...", 5000)
    Wait(5000)
    DoScreenFadeOut(2000)
    Wait(3000)
end

Config.IllegalCutSceneText2 = function()
    Wait(2000)
    DoScreenFadeIn(3000)
    Wait(2500)
    showsubtitle("Welcome to the beautiful Cayo Perico. Let's see what the boss has in store for you.", 6000)
    Wait(6500)
    showsubtitle("Let me have a quick smoke, and then we can continue.", 5000)
    Wait(7500)
    showsubtitle("Follow me, guys. You too, you wanker!", 5000)
    Wait(4500)
end

Config.IllegalCutSceneText3 = function()
    Wait(5000)
    showsubtitle("Mount up, boys. Let's go!!!", 3000)
    Wait(1000)
    showsubtitle("You get in the back!", 2000)
end

Config.IllegalCutSceneText4 = function()
    Wait(6000)
    showsubtitle("We're heading to your new home. You're gonna love it, you rat.", 3500)
    Wait(5000)
    showsubtitle("Use this time to prepare yourself for what's coming!", 2000)
    Wait(5000)
    DoScreenFadeOut(1500)
    Wait(2000)
end

Config.IllegalCutSceneText5 = function()
    DoScreenFadeIn(1500)
    showsubtitle("So, here we are. Just don't constantly annoy me, okay?", 3500)
    Wait(2000)
end

Config.IllegalCutSceneText6 = function()
    Wait(1500)
    showsubtitle("We're waiting here for our boss!", 2000)
    Wait(3000)
    DoScreenFadeOut(1500)
end

-- legal settings
Config.SpawnLegalEntry = vector3(-1241.369, -2996.042, -42.888) -- player coords after custom cutscenes
Config.SpawnLegalEntryHeading = 179.00 -- player heading after custom cutscenes

Config.PlayerLegalEntrySpawn = vector3(-1036.572, -2736.480, 13.756) -- player spawn coordinates after accept admin whitelist /enterplayer [ID]
Config.PlayerLegalEntrySpawnHeading = 327.51 -- player spawn heading after accept admin whitelist /enterplayer [ID]

Config.LegalEntryNotifyNPC = vector3(-1240.802, -2999.700, -43.888) -- admin notifications NPC coordinates
Config.LegalEntryNotifyNPCHeading = 3.814 -- admin notifications NPC Heading

Config.ReUseLegalNotifyTimer = 300000 -- in ms, 300000 its 5 minutes

-- legal cutscene settings
Config.UseLegalCutscene = true
Config.OwnLegalCutscene = function()
    -- here you own cutscene
end

Config.LegalPedPilot = 's_m_m_pilot_01'
Config.LegalPedFiller = 'a_f_y_tourist_01'
Config.LegalPedFiller2 = 'a_f_y_tourist_01'

-- legal cutscnes text
Config.LegalCutsceneText1 = function()
    DoScreenFadeIn(5000)
    Wait(3000)
    showsubtitle("Ladies and gentlemen, we want to inform you that we are on final approach", 6000)
    Wait(6500)
    showsubtitle("to Los Santos, please follow the instructions of the stewardess!", 5000)
    Wait(5500)
    showsubtitle("Your pilot GMD_Scripts", 1500)
    Wait(2000)
    DoScreenFadeOut(1500)
end

Config.LegalCutsceneText2 = function()
    showsubtitle("I am Rosi, your flight attendant. Please check your seat belts and make sure", 5000)
    Wait(5100)
    showsubtitle("your smartphones are turned off.", 3000)
    Wait(3500)
    showsubtitle("Also, I kindly ask you to put away your drinks and food.", 4000)
    Wait(4500)
    showsubtitle("So, welcome to Los Santos. Your flight attendant, Rosi", 4500)
    Wait(4000)
    showsubtitle("Please leave me a review with the airport staff if you would like to.", 3500)
    Wait(4000)
    DoScreenFadeOut(2000)
end

Config.LegalCutsceneText3 = function()
    DoScreenFadeIn(1000)
        Wait(1500)
        showsubtitle("Unfortunately, the border control has not given us the OK yet.", 4000)
        Wait(4500)
        showsubtitle("I'm going to the office to sort this out. Follow me, but don't bother me every 2 minutes.", 6000)
        Wait(6500)
end






-- entry admin settings
Config.EntryGroupLegalSpawn = vector3(-1238.061, -3067.243, -49.000) -- admin spawn coords after /enterentry [illegal/legal] [SkinID]
Config.EntryGroupLegalSpawnHeading = 3.608 -- admin spawn heading after /enterentry [illegal/legal] [SkinID]

Config.LegalAdminSkins = {
    admin1 ={
        male = {
            ['tshirt_1'] = 31, ['tshirt_2'] = 0,
            ['torso_1'] = 31, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 4,
            ['pants_1'] = 28, ['pants_2'] = 0,
            ['shoes_1'] = 10, ['shoes_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = 2, ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 31, ['tshirt_2'] = 0,
            ['torso_1'] = 31, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 4,
            ['pants_1'] = 28, ['pants_2'] = 0,
            ['shoes_1'] = 10, ['shoes_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = 2, ['ears_2'] = 0
        }
    },
    admin2 ={
        male = {
            ['tshirt_1'] = 69, ['tshirt_2'] = 1,
            ['torso_1'] = 55, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 25, ['pants_2'] = 2,
            ['shoes_1'] = 25, ['shoes_2'] = 0,
            ['helmet_1'] = 46, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = 2, ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 36, ['tshirt_2'] = 1,
            ['torso_1'] = 48, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 44,
            ['pants_1'] = 34, ['pants_2'] = 0,
            ['shoes_1'] = 27, ['shoes_2'] = 0,
            ['helmet_1'] = 45, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = 2, ['ears_2'] = 0
        }
    }
}

Config.EntryGroupIllegalSpawn = vector3(5193.630, -5134.656, 3.345) -- admin spawn coords after /enterentry [illegal/legal] [SkinID]
Config.EntryGroupIllegalSpawnHeading = 70.243 -- admin spawn heading after /enterentry [illegal/legal] [SkinID]

Config.IllegalAdminSkins = {
    admin1 ={
        male = {
			['tshirt_1'] = 16,	['tshirt_2'] = 0,
			['torso_1'] = 221,   ['torso_2'] = 3,
			['arms'] = 17,
			['decals_1'] = 0,
			['pants_1'] = 87,	['pants_2'] = 3,
			['shoes_1'] = 25,	['shoes_2'] = 0,
			['mask_1'] = 35,	['mask_2'] = 0,
			['helmet_1'] = 107,	['helmet_2'] = 3,
			['bproof_1'] = 16,	['bproof_2'] = 2
		},
		female = {
			['tshirt_1'] = 7,	['tshirt_2'] = 0,
			['torso_1'] = 223,  ['torso_2'] = 3,
			['arms'] = 18,
			['decals_1'] = 0,
			['pants_1'] = 90,	['pants_2'] = 3,
			['shoes_1'] = 25,	['shoes_2'] = 0,
			['mask_1'] = 35,	['mask_2'] = 0,
			['helmet_1'] = 106,	['helmet_2'] = 3,
			['bproof_1'] = 18,	['bproof_2'] = 2
		}
    },
    admin2 ={
        male = {
            ['tshirt_1'] = 59, ['tshirt_2'] = 1,
            ['torso_1'] = 55, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 25, ['pants_2'] = 2,
            ['shoes_1'] = 25, ['shoes_2'] = 0,
            ['helmet_1'] = 46, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = 2, ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 36, ['tshirt_2'] = 1,
            ['torso_1'] = 48, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 44,
            ['pants_1'] = 34, ['pants_2'] = 0,
            ['shoes_1'] = 27, ['shoes_2'] = 0,
            ['helmet_1'] = 45, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = 2, ['ears_2'] = 0
        }
    }
}

-- locals
Config.Language = {
    ['de'] = {
        -- FiveM-Verbindungsfenster
        ['check_ban_state'] = "Überprüfe Banstatus...",
        ['fail_entry_ban'] = "Du hast die Einreisefragen verkackt, deshalb bist du noch: %d Tage, %d Stunden, %d Minuten, %d Sekunden gebannt",
        ['restart_fivem'] = "Starte dein FiveM neu, dies ist ein Datenbankfehler. Sollte dieser bestehen bleiben, wende dich an den Support auf unserem Discord: www.GMDScripts.gg",
        ['ban_field'] = "Bangrund: Fehlerhafte Einreisefragen",
        ['set_unban_msg'] = "Du wurdest nun wieder entbannt, nutze die neue Chance",
        -- Benachrichtigungen
        ['player_not_online'] = "Es ist kein Spieler mit dieser ID online!",
        ['no_outfit'] = "Dieser Befehl hat kein passendes Outfit. Versuche es mit einem anderen.",
        ['npc_helptext'] = "Drücke ~INPUT_CONTEXT~, um mit dem NPC zu interagieren.",
        ['npc_pressed'] = "Ein Admin wurde benachrichtigt, warte nun einen Moment",
        ['db_colum_insert'] = "^1GMD_Entry^2: Datenbankspalte wurde eingefügt^7",
        ['db_edit'] = "Datenbank wurde aktualisiert",
        ['db_error'] = "Datenbank wurde nicht aktualisiert",
        ['db_type_error'] = "^1GMD_Entry^2: Datenbank-Fehler in entry_type^7",
        ['db_type_nil'] = "^1GMD_Entry^2: Datenbank-Fehler entry_type ist null^7",

    },
    ['en'] = {
        -- FiveM connection window
        ['check_ban_state'] = "Checking ban status...",
        ['fail_entry_ban'] = "You messed up the entry questions, so you're still banned for: %d days, %d hours, %d minutes, %d seconds",
        ['restart_fivem'] = "Restart your FiveM, this is a database error. If it persists, contact support on our Discord: www.GMDScripts.gg",
        ['ban_field'] = "Ban reason: Faulty entry questions",
        ['set_unban_msg'] = "You have been unbanned now, make good use of this new chance",
        -- Notifications
        ['player_not_online'] = "There is no player online with this ID!",
        ['no_outfit'] = "This command has no suitable outfit. Try another one.",
        ['npc_helptext'] = "Press ~INPUT_CONTEXT~ to interact with the NPC.",
        ['npc_pressed'] = "An admin has been notified. Please wait a moment",
        ['db_colum_insert'] = "^1GMD_Entry^2: Database column has been inserted^7",
        ['db_edit'] = "Database has been updated",
        ['db_error'] = "Database has not been updated",
        ['db_type_error'] = "^1GMD_Entry^2: Database ERROR in entry_type^7",
        ['db_type_nil'] = "^1GMD_Entry^2: Database ERROR - entry_type is null^7",

    }
}

