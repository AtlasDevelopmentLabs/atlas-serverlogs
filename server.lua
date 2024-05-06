---------------------------------
-- Player Connecting
---------------------------------

AddEventHandler('playerConnecting', function()
    if Config.AttemptConnect then
    local webhookURL = Config.JoinWebhook
    local name = GetPlayerName(source)
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end
    local embedData = {
        {
            ["color"] = 15277667, 
            ["title"] = "Player Attempting To Connect",
            ["description"] = "**Player Name**: ".. name .. " \n**Discord**: <@".. discord .."> ",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        }
    }
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
    else
        return
    end
end)

---------------------------------
-- Player Joined
---------------------------------

AddEventHandler('playerJoining', function()
    local webhookURL = Config.JoinWebhook
    local playerid = source
    local name = GetPlayerName(source)
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end
    local embedData = {
        {
            ["color"] = 5763719, 
            ["title"] = "Player Joined",
            ["description"] = "**Player Name**: ".. name .. " \n**Player ID**: ".. playerid .." \n**Discord**: <@".. discord .."> ",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        }
    }
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
end)

---------------------------------
-- Player Left
---------------------------------

AddEventHandler('playerDropped', function(reason)
    local webhookURL = Config.LeaveWebhook
    local playerid = source
    local name = GetPlayerName(source)
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end
    local embedData = {
        {
            ["color"] = 15548997, 
            ["title"] = "Player Left",
            ["description"] = "**Player Name**: ".. name .. " \n**Player ID**: ".. playerid .." \n**Discord**: <@".. discord .."> \n**Reason**: " .. reason .."",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        }
    }
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
end)

---------------------------------
-- Player Chat Message
---------------------------------

AddEventHandler('chatMessage', function(source, name, msg)
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end  	
    local webhookURL = Config.ChatMsgWebhook
    local embedData = {
        {
            ["color"] = 3447003, 
            ["title"] = "Player Message",
            ["description"] = "**IGN**: " .. name .. " \n**Player ID**: " .. source .. " \n**Discord**: <@" .. discord .. "> \n**Chat Message**: " .. msg .. "",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        },
    }	
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
end)

---------------------------------
-- Player Died
---------------------------------

RegisterServerEvent('playerDied')
AddEventHandler('playerDied', function(deathReason)
    local webhookURL = Config.DeathWebhook
    local player = GetPlayerName(source)
    local id = source
    local discord = ""
    
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end  	
    
    local embedData = {
        {
            ["color"] = 15548997, 
            ["title"] = "Player Death",
            ["description"] = "**IGN**: " .. player .. " \n**Player ID**: " .. id .. " \n**Discord**: <@" .. discord .. "> \n**Action**: " .. deathReason .."",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        },
    }	
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
end)

---------------------------------
-- Resource Log
---------------------------------
AddEventHandler('onResourceStop', function (resourceName)
    local webhookURL = Config.ResourceWebhook
    local embedData = {
        {
            ["color"] = 3426654, 
            ["title"] = "Resource Stopped",
            ["description"] = "**Folder Stopped**:".. resourceName .."",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        },
    }	
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
end)

AddEventHandler('onResourceStart', function (resourceName)
    Wait(100)
    local webhookURL = Config.ResourceWebhook
    local embedData = {
        {
            ["color"] = 3426654, 
            ["title"] = "Resource Stopped",
            ["description"] = "**Folder Stopped**:".. resourceName .."",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        },
    }	
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
end)

---------------------------------
-- Player vMenu Log
---------------------------------

RegisterNetEvent('vMenu:ClearArea', function()
    if Config.vMenuActive then
    local webhookURL = Config.vMenuWebhook
    local sourceID = source
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end  
    local embedData = {
        {
            ["color"] = 3447003, 
            ["title"] = "vMenu Event: Clear Area",
            ["description"] = "\n**ID**: "..sourceID.." \n**Staff**: <@"..discord.."> \n**Action**: has cleared the area",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        },
    }	
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
else
    return
    end
end)

RegisterNetEvent('vMenu:UpdateServerWeather', function(result)
    if Config.vMenuActive then
    local webhookURL = Config.vMenuWebhook
    local sourceID = source
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end  
    local embedData = {
        {
            ["color"] = 3447003, 
            ["title"] = "vMenu Event: Server Weather",
            ["description"] = "\n**ID**: "..sourceID.." \n **Staff**: <@"..discord.."> \n**Action**: has updated the weather to \n**".. result .."**",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        },
    }	
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
    else
        return
    end
end)

RegisterNetEvent('vMenu:UpdateServerTime', function(result)
    if Config.vMenuActive then
    local webhookURL = Config.vMenuWebhook
    local sourceID = source
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end  
    local embedData = {
        {
            ["color"] = 3447003, 
            ["title"] = "vMenu Event: Server Time",
            ["description"] = "\n**ID**: "..sourceID.." \n**Staff**: <@"..discord.."> \n**Action**: has updated the time to \n**".. result ..":00**",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        },
    }	
    sendHttpRequest(webhookURL, {username = username, embeds = embedData})
    else
        return
    end
end)