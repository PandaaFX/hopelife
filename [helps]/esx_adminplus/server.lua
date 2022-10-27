ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onTimer       = {}
local savedCoords   = {}
local warnedPlayers = {}
local deadPlayers   = {}

RegisterCommand("rein", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent("esx_admin:rein", xPlayer.source)
		end
	end
end, false)

RegisterCommand("raus", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent("esx_admin:raus", xPlayer.source)
		end
	end
end, false)

RegisterCommand("raus2", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent("esx_admin:raus2", xPlayer.source)
		end
	end
end, false)

RegisterCommand("raus3", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent("esx_admin:raus3", xPlayer.source)
		end
	end
end, false)

RegisterCommand("bauamt", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent("esx_admin:bauamt", xPlayer.source)
		end
	end
end, false)

RegisterCommand("bauamtraus", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent("esx_admin:bauamt2", xPlayer.source)
		end
	end
end, false)

RegisterCommand("playerskin", function(source, args, rawCommand)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
        		local targetId = tonumber(args[1])
        		local xTarget = ESX.GetPlayerFromId(targetId)
        		if xTarget then
            		xTarget.triggerEvent('esx_skin:openSaveableMenu')
        			TriggerClientEvent('chat:addMessage', source, {args = {'^1SYSTEM: ', _U('opened_playerskin', targetId)}})
        		else
            		TriggerClientEvent('chat:addMessage', source, {args = {'^1SYSTEM: ', _U('not_online', targetId)}})
        		end
    		else
    			TriggerClientEvent('chat:addMessage', source, {args = {'^1SYSTEM: ', _U('invalid_input', 'PLAYERSKIN')}})
			end
		end
    end
end, true)
------------EINREISE------------

RegisterCommand('purge', function(source, args, showError)
	local xPlayer = ESX.GetPlayerFromId(source)
	if havePermission2(xPlayer) then
		TriggerClientEvent("hopelife:purgecmd", xPlayer.source)
	end

end)

RegisterCommand("einreise", function(source, args, rawCommand)	-- /goto [ID]
    if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
		  	if args[1] and tonumber(args[1]) then
				local targetId = tonumber(args[1])
				local xTarget = ESX.GetPlayerFromId(targetId)
				local name = GetPlayerName(source)
    			local name2 = GetPlayerName(targetId)
    			local src = source
    			local xPlayer = ESX.GetPlayerFromId(source)
    			local player_id = src
    			local ids = ExtractIdentifiers(player_id)
    			local id = ExtractIdentifiers(targetId)
				if xTarget then
					TriggerEvent('esx_license:addLicense', xTarget.source, 'einreise', function ()
					end)
					discordlogs('Adminmenü', '**' .. name .. ' hat ' ..name2.. ' die Einreise bewilligt.**\n\n **Geber Details:**\nGroup: ' ..xPlayer.getGroup().. '\nSteam: ' ..ids.steam.."\nDiscord: " ..ids.discord.. "\nLizenz: " ..ids.license.. "\nIP: " ..ids.ip.. '\n\n **Ziel Details:**\nGroup: ' ..xTarget.getGroup().. '\nSteam: ' ..id.steam.."\nDiscord: " ..id.discord.. "\nLizenz: " ..id.license.. "\nIP: " ..id.ip.. '', 3863105)
					TriggerClientEvent("introCinematic:start", xTarget.source)
				else
        			TriggerClientEvent("chatMessage", xPlayer.source, "Spieler nicht online")
      			end
		  	else
				TriggerClientEvent("chatMessage", xPlayer, _U('invalid_input', 'GOTO'))
		  	end
		end
  	end
end, false)





--------------ADMIN CHAT--------------
RegisterCommand("a", function(source, args, rawCommand)	-- /a command for adminchat
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		local playerId = GetPlayerName(source)
		if havePermission(xPlayer) then
			if args[1] then
				local message = string.sub(rawCommand, 3)
				local xAll = ESX.GetPlayers()
				for i=1, #xAll, 1 do
					local xTarget = ESX.GetPlayerFromId(xAll[i])
					if havePermission(xTarget) then
						TriggerClientEvent('chatMessage', xTarget.source, _U('adminchat', playerId, xPlayer.getGroup(), message))
					end
				end
			else
				TriggerClientEvent('chatMessage', xPlayer.source, _U('invalid_input', 'AdminChat'))
			end
		end
	end
end, false)


AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_adminplus:loadLicenses', source, licenses)
	end)
end)


function LoadLicenses(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_adminplus:loadLicenses', source, licenses)
	end)
end

RegisterServerEvent('esx_adminplus:ServerLoadLicenses')
AddEventHandler('esx_adminplus:ServerLoadLicenses', function()
	local _source = source
	LoadLicenses(_source)
end)

------------ functions and events ------------
RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = data
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	-- empty tables when player no longer online
	if onTimer[playerId] then
		onTimer[playerId] = nil
	end
    if savedCoords[playerId] then
    	savedCoords[playerId] = nil
    end
	if warnedPlayers[playerId] then
		warnedPlayers[playerId] = nil
	end
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
	end
end)

function havePermission(xPlayer, exclude)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end	-- will prevent from errors if you pass wrong argument

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Config.adminRanks) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end

function havePermission2(xPlayer, exclude)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end	-- will prevent from errors if you pass wrong argument

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Config.adminRanks2) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end

RegisterServerEvent('waffen:log')
AddEventHandler('waffen:log', function(waffe,ammo)
	local xPlayerSender = ESX.GetPlayerFromId(source)
	local name = GetPlayerName(source)
	local ids = ExtractIdentifiers(source)
	discordlogs('Waffenlog', '**' .. name .. ' hat sich eine Waffe gegeben\n\n ** Details:**\nGroup: ' ..xPlayerSender.getGroup().. '\nWaffe: ' ..waffe.. 'Ammo: '..ammo.. '\nSteam: ' ..ids.steam.."\nDiscord: " ..ids.discord.. "\nLizenz: " ..ids.license.. "\nIP: " ..ids.ip , 3863105)
end)

local allowedGroups = {"mod", "admin", "support", "guide"}
RegisterServerEvent('einreise:anfrage')
AddEventHandler('einreise:anfrage', function()
	local xPlayerSender = ESX.GetPlayerFromId(source)
	local name = GetPlayerName(source)
	local ids = ExtractIdentifiers(source)
	local xPlayerTarget = ESX.GetPlayerFromId(v)
	local players = ESX.GetGroupPlayers(allowedGroups[i])
	for i=1, #allowedGroups do
		local players = ESX.GetGroupPlayers(allowedGroups[i])
		for j=1, #players do
			TriggerClientEvent('esx:showNotification', players[j], 'EINREISE! ' .. xPlayerSender.name .. '\njemand möchte Einreisen')
			discordlogs('Einreise', '**' .. name .. ' hat eine EINREISE angefordert\n\n ** Details:**\nGroup: ' ..xPlayerSender.getGroup().. '\nSteam: ' ..ids.steam.."\nDiscord: " ..ids.discord.. "\nLizenz: " ..ids.license.. "\nIP: " ..ids.ip , 3863105)
		end
	end
end)


local Webhook = "https://discord.com/api/webhooks/988743612298850374/EBU5ROXAPrph4kTeKPeep1EZuxrQI4yB36Mtu6Si0b3DoMxSXgLvenlWlZit5MtLrUbK"

function discordlogs (title,message,color)
    local DiscordWebHook = Webhook
    
    local embeds = {
        {
            ["title"]= title,
            ["description"] = message,              
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "Einreise - "..os.date("%x %X %p"),
            ["icon_url"]= "https://media.discordapp.net/attachments/963513110205988894/963513492504215552/sr_mod_2.png?width=676&height=676",
           },
        }
    }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds, avatar_url = "https://media.discordapp.net/attachments/963513110205988894/963513492504215552/sr_mod_2.png?width=676&height=676"}), { ['Content-Type'] = 'application/json' })
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "not found",
        ip = "not found",
        discord = "not found",
        license = "not found",
        xbl = "not found",
        live = "not found"
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function sendToDiscord(msg)
    if Webhook~=nil then
        PerformHttpRequest(Webhook, function(a,b,c)end, "POST", json.encode({embeds={{title="Ban - Logs",description=msg:gsub("%^%d",""),color=65280,}}}), {["Content-Type"]="application/json"})
    end
end

