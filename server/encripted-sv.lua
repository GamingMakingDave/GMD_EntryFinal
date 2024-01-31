ESX = exports['es_extended']:getSharedObject()
Dimension = Config.BasicEntryDimension

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local source = source
    local license = GetPlayerIdentifierByType(source, 'license')
    license = string.gsub(license, "license:", "")
    MySQL.query("SELECT `entry_ban`, `entry_duration`, `entry_dimension` FROM `users` WHERE SUBSTRING_INDEX(`identifier`, ':', -1) = ? LIMIT 1", { license }, function(result)
        if Config.DebugMode then
        print(ESX.DumpTable(result))
        end
        if #result == 0 then
            deferrals.update((Config.Language[Config.Local]['check_ban_state']))
            Wait(1500)
            deferrals.done()
        else
            local row = result[1]
                if row.entry_ban == true then
                    deferrals.defer()
                    deferrals.update((Config.Language[Config.Local]['check_ban_state']))
                    Wait(1500)
                    local given_timestamp = row.entry_duration / 1000
                    local current_timestamp = os.time()
                    local time_difference = os.difftime(current_timestamp, given_timestamp)
                    local ban_duration = Config.BanTime.day * Config.BanTime.hours * Config.BanTime.minutes * Config.BanTime.seconds
                    Wait(1000)
                    if time_difference >= ban_duration then
                        MySQL.execute("UPDATE `users` SET `entry_ban` = 0, `entry_duration` = NULL WHERE SUBSTRING_INDEX(`identifier`, ':', -1) = ?", { license }, function()end)
                        deferrals.defer()
                        deferrals.update((Config.Language[Config.Local]['set_unban_msg']))
                        Wait(1500)
                        deferrals.done()
                    else
                        local remaining_seconds = ban_duration - time_difference
                        local remaining_days = math.floor(remaining_seconds / (24 * 60 * 60))
                        local remaining_hours = math.floor((remaining_seconds % (24 * 60 * 60)) / (60 * 60))
                        local remaining_minutes = math.floor((remaining_seconds % (60 * 60)) / 60)
                        remaining_seconds = math.floor(remaining_seconds % 60)
                        deferrals.done((Config.Language[Config.Local]['fail_entry_ban']):format(remaining_days, remaining_hours, remaining_minutes, remaining_seconds))
                    end
                end
                if row.entry_dimension == Config.BasicEntryDimension then
                    local Dimension = row.entry_dimension
                    SetPlayerRoutingBucket(source, Dimension)
                    if Config.DebugMode then
                    print(Dimension)
                    end
                end
            deferrals.done()
        end
    end)
end)

CreateThread(function()
    MySQL.query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'users' AND COLUMN_NAME = 'entry_isnew';", {}, function(response)
        if next(response) == nil then
            local SQLStatemant = [[
                ALTER TABLE users
                ADD COLUMN entry_isnew TINYINT(1) NOT NULL DEFAULT 0,
                ADD COLUMN entry_ban TINYINT(1) DEFAULT 0,
                ADD COLUMN entry_duration TIMESTAMP NULL DEFAULT NULL,
                ADD COLUMN entry_dimension SMALLINT(10) NOT NULL DEFAULT 0,
                ADD COLUMN entry_type TINYINT(1) DEFAULT NULL;
            ]]
            MySQL.query(SQLStatemant, {}, function(response)
            end)
        end
    end)
end)

function CheckCommandValid(CorrectCommands, UserInput)
    local UserInput = UserInput
    if UserInput == nil or UserInput == '' then
       return false 
    end

    if CorrectCommands == {} then
        return false
    end

    UserInput = (UserInput:gsub("^%s+", ""):gsub("%s+$", ""))
    UserInput = string.lower(UserInput)
    
    for k, v in pairs(CorrectCommands) do
        if v == UserInput then
            return true
        end
    end

    return false
end