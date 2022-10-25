ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

do
	local origRegisterServerEvent = RegisterServerEvent
	local origEsxRegisterServerCallback = ESX.RegisterServerCallback

	--[[
		If you are a server developer and you have some players kicked seeing this message :

		Server detected a potentially abusive behaviour.
		If you're not an abuser please contact the server owner so he can fix the underlying issue.


		- DEBUG INFO -
		Resource Name : ?
		Event Name : ?

		This means you probably have resources which are using `krz_personalmenu` old network event names prefix.
		Please update the event names prefix from `KorioZ-PersonalMenu` to `krz_personalmenu`.
	]]

	RegisterServerEvent = function(eventName, ...)
		local endIdx = ('krz_personalmenu:'):len()

		if eventName:sub(1, endIdx) == 'krz_personalmenu' then
			local oldEventName = ('KorioZ-PersonalMenu:%s'):format(eventName:sub(endIdx + 1))

			origRegisterServerEvent(oldEventName)
			AddEventHandler(oldEventName, function()
				DropPlayer(source,
					(
						"Server detected a potentially abusive behaviour.\n"
						.. "If you're not an abuser please contact the server owner so he can fix the underlying issue.\n\n"
						.. "- DEBUG INFO -\n"
						.. "Resource Name : %s\n"
						.. "Event Name : %s"
					):format(
						GetCurrentResourceName(),
						oldEventName
					)
				)
			end)
		end

		return origRegisterServerEvent(eventName, ...)
	end

	ESX.RegisterServerCallback = function(eventName, ...)
		local endIdx = ('krz_personalmenu:'):len()

		if eventName:sub(1, endIdx) == 'krz_personalmenu' then
			local oldEventName = ('KorioZ-PersonalMenu:%s'):format(eventName:sub(endIdx + 1))

			origEsxRegisterServerCallback(oldEventName, function(source)
				DropPlayer(source,
					(
						"Server detected a potentially abusive behaviour.\n"
						.. "If you're not an abuser please contact the server owner so he can fix the underlying issue.\n\n"
						.. "- DEBUG INFO -\n"
						.. "Resource Name : %s\n"
						.. "Event Name : %s"
					):format(
						GetCurrentResourceName(),
						oldEventName
					)
				)
			end)
		end

		return origEsxRegisterServerCallback(eventName, ...)
	end
end

function getMaximumGrade(jobName)
	local p = promise.new()

	MySQL.Async.fetchScalar('SELECT grade FROM job_grades WHERE job_name = @job_name ORDER BY `grade` DESC', { ['@job_name'] = jobName }, function(result)
		p:resolve(result)
	end)

	local queryResult = Citizen.Await(p)

	return tonumber(queryResult)
end

function getAdminCommand(name)
	for i = 1, #Config.Admin do
		if Config.Admin[i].name == name then
			return i
		end
	end

	return false
end

function isAuthorized(index, group)
	for i = 1, #Config.Admin[index].groups do
		if Config.Admin[index].groups[i] == group then
			return true
		end
	end

	return false
end

ESX.RegisterServerCallback('krz_personalmenu:Bill_getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local bills = {}

		for i = 1, #result do
			bills[#bills + 1] = {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			}
		end

		cb(bills)
	end)
end)

ESX.RegisterServerCallback('krz_personalmenu:Admin_getUsergroup', function(source, cb)
	cb(ESX.GetPlayerFromId(source).getGroup() or 'user')
end)

local function makeTargetedEventFunction(fn)
	return function(target, ...)
		if tonumber(target) == -1 then return end
		fn(target, ...)
	end
end

-- Weapon Menu --
RegisterServerEvent('krz_personalmenu:Weapon_addAmmoToPedS')
AddEventHandler('krz_personalmenu:Weapon_addAmmoToPedS', makeTargetedEventFunction(function(target, value, quantity)
	if #(GetEntityCoords(source, false) - GetEntityCoords(target, false)) <= 3.0 then
		TriggerClientEvent('krz_personalmenu:Weapon_addAmmoToPedC', target, value, quantity)
	end
end))

-- Admin Menu --
RegisterServerEvent('krz_personalmenu:Admin_BringS')
AddEventHandler('krz_personalmenu:Admin_BringS', makeTargetedEventFunction(function(playerId, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyGroup = xPlayer.getGroup()

	if isAuthorized(getAdminCommand('bring'), plyGroup) or isAuthorized(getAdminCommand('goto'), plyGroup) then
		TriggerClientEvent('krz_personalmenu:Admin_BringC', playerId, GetEntityCoords(GetPlayerPed(target)))
	end
end))

RegisterServerEvent('krz_personalmenu:Admin_aduty')
AddEventHandler('krz_personalmenu:Admin_aduty', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyGroup = xPlayer.getGroup()
	local name = GetPlayerName(source)
    local src = source
    local player_id = src
    local ids = ExtractIdentifiers(player_id)
	if isAuthorized(getAdminCommand('aduty')) then
		TriggerClientEvent("toggleDuty", source)
		TriggerClientEvent("adminhl:c_godmodexyz", source)
	end
	discordlogs('Adminmenü', '**' .. name .. ' ist in den Admindienst gegangen\n**\n\n **Geber Details:**\nGroup: ' ..xPlayer.getGroup().. '\nSteam: ' ..ids.steam.."\nDiscord: " ..ids.discord.. "\nLizenz: " ..ids.license.. "\nIP: " ..ids.ip.. '\n', 3863105)
end)


RegisterServerEvent('krz_personalmenu:Admin_giveCash')
AddEventHandler('krz_personalmenu:Admin_giveCash', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyGroup = xPlayer.getGroup()
	local name = GetPlayerName(source)
    local src = source
    local player_id = src
    local ids = ExtractIdentifiers(player_id)
	if isAuthorized(getAdminCommand('givemoney'), plyGroup) then
		xPlayer.addAccountMoney('cash', amount)
		TriggerClientEvent('esx:showNotification', xPlayer.source, ('GIVE de %i$'):format(amount))
	end
	discordlogs('Adminmenü', '**' .. name .. ' hat sich Geld(Cash) gegeben\nMenge: ' ..amount..'**\n\n **Geber Details:**\nGroup: ' ..xPlayer.getGroup().. '\nSteam: ' ..ids.steam.."\nDiscord: " ..ids.discord.. "\nLizenz: " ..ids.license.. "\nIP: " ..ids.ip.. '\n', 3863105)
end)

RegisterServerEvent('krz_personalmenu:Admin_giveBank')
AddEventHandler('krz_personalmenu:Admin_giveBank', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyGroup = xPlayer.getGroup()

	if isAuthorized(getAdminCommand('givebank'), plyGroup) then
		xPlayer.addAccountMoney('bank', amount)
		TriggerClientEvent('esx:showNotification', xPlayer.source, ('GIVE de %i$ en banque'):format(amount))
	end
end)

RegisterServerEvent('krz_personalmenu:Admin_giveDirtyMoney')
AddEventHandler('krz_personalmenu:Admin_giveDirtyMoney', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyGroup = xPlayer.getGroup()

	if isAuthorized(getAdminCommand('givedirtymoney'), plyGroup) then
		xPlayer.addAccountMoney('black_money', amount)
		TriggerClientEvent('esx:showNotification', xPlayer.source, ('GIVE de %i$ sale'):format(amount))
	end
end)

-- Grade Menu --
RegisterServerEvent('krz_personalmenu:Boss_promouvoirplayer')
AddEventHandler('krz_personalmenu:Boss_promouvoirplayer', makeTargetedEventFunction(function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local sourceJob = sourceXPlayer.getJob()

	if sourceJob.grade_name == 'boss' then
		local targetXPlayer = ESX.GetPlayerFromId(target)
		local targetJob = targetXPlayer.getJob()

		if sourceJob.name == targetJob.name then
			local newGrade = tonumber(targetJob.grade) + 1

			if newGrade ~= getMaximumGrade(targetJob.name) then
				targetXPlayer.setJob(targetJob.name, newGrade)

				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~g~promu %s~w~.'):format(targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~promu par %s~w~.'):format(sourceXPlayer.name))
			else
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation ~r~Gouvernementale~w~.')
			end
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre entreprise.')
		end
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
	end
end))

RegisterServerEvent('krz_personalmenu:Boss_destituerplayer')
AddEventHandler('krz_personalmenu:Boss_destituerplayer', makeTargetedEventFunction(function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local sourceJob = sourceXPlayer.getJob()

	if sourceJob.grade_name == 'boss' then
		local targetXPlayer = ESX.GetPlayerFromId(target)
		local targetJob = targetXPlayer.getJob()

		if sourceJob.name == targetJob.name then
			local newGrade = tonumber(targetJob.grade) - 1

			if newGrade >= 0 then
				targetXPlayer.setJob(targetJob.name, newGrade)

				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~r~rétrogradé %s~w~.'):format(targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~r~rétrogradé par %s~w~.'):format(sourceXPlayer.name))
			else
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas ~r~rétrograder~w~ d\'avantage.')
			end
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre organisation.')
		end
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
	end
end))

RegisterServerEvent('krz_personalmenu:Boss_recruterplayer')
AddEventHandler('krz_personalmenu:Boss_recruterplayer', makeTargetedEventFunction(function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local sourceJob = sourceXPlayer.getJob()

	if sourceJob.grade_name == 'boss' then
		local targetXPlayer = ESX.GetPlayerFromId(target)

		targetXPlayer.setJob(sourceJob.name, 0)
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~g~recruté %s~w~.'):format(targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~embauché par %s~w~.'):format(sourceXPlayer.name))
	end
end))

RegisterServerEvent('krz_personalmenu:Boss_virerplayer')
AddEventHandler('krz_personalmenu:Boss_virerplayer', makeTargetedEventFunction(function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local sourceJob = sourceXPlayer.getJob()

	if sourceJob.grade_name == 'boss' then
		local targetXPlayer = ESX.GetPlayerFromId(target)
		local targetJob = targetXPlayer.getJob()

		if sourceJob.name == targetJob.name then
			targetXPlayer.setJob('unemployed', 0)
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~r~viré %s~w~.'):format(targetXPlayer.name))
			TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~viré par %s~w~.'):format(sourceXPlayer.name))
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre entreprise.')
		end
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
	end
end))

RegisterServerEvent('krz_personalmenu:Boss_promouvoirplayer2')
AddEventHandler('krz_personalmenu:Boss_promouvoirplayer2', makeTargetedEventFunction(function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local sourceJob2 = sourceXPlayer.getJob2()

	if sourceJob2.grade_name == 'boss' then
		local targetXPlayer = ESX.GetPlayerFromId(target)
		local targetJob2 = targetXPlayer.getJob2()

		if sourceJob2.name == targetJob2.name then
			local newGrade = tonumber(targetJob2.grade) + 1

			if newGrade ~= getMaximumGrade(targetJob2.name) then
				targetXPlayer.setJob2(targetJob2.name, newGrade)

				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~g~promu %s~w~.'):format(targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~promu par %s~w~.'):format(sourceXPlayer.name))
			else
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation ~r~Gouvernementale~w~.')
			end
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre organisation.')
		end
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
	end
end))

RegisterServerEvent('krz_personalmenu:Boss_destituerplayer2')
AddEventHandler('krz_personalmenu:Boss_destituerplayer2', makeTargetedEventFunction(function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local sourceJob2 = sourceXPlayer.getJob2()

	if sourceJob2.grade_name == 'boss' then
		local targetXPlayer = ESX.GetPlayerFromId(target)
		local targetJob2 = targetXPlayer.getJob2()

		if sourceJob2.name == targetJob2.name then
			local newGrade = tonumber(targetJob2.grade) - 1

			if newGrade >= 0 then
				targetXPlayer.setJob2(targetJob2.name, newGrade)

				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~r~rétrogradé %s~w~.'):format(targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~r~rétrogradé par %s~w~.'):format(sourceXPlayer.name))
			else
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas ~r~rétrograder~w~ d\'avantage.')
			end
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre organisation.')
		end
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
	end
end))

RegisterServerEvent('krz_personalmenu:Boss_recruterplayer2')
AddEventHandler('krz_personalmenu:Boss_recruterplayer2', makeTargetedEventFunction(function(target, grade2)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local sourceJob2 = sourceXPlayer.getJob2()

	if sourceJob2.grade_name == 'boss' then
		local targetXPlayer = ESX.GetPlayerFromId(target)

		targetXPlayer.setJob2(sourceJob2.name, 0)
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~g~recruté %s~w~.'):format(targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~embauché par %s~w~.'):format(sourceXPlayer.name))
	end
end))

RegisterServerEvent('krz_personalmenu:Boss_virerplayer2')
AddEventHandler('krz_personalmenu:Boss_virerplayer2', makeTargetedEventFunction(function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local sourceJob2 = sourceXPlayer.getJob2()

	if sourceJob2.grade_name == 'boss' then
		local targetXPlayer = ESX.GetPlayerFromId(target)
		local targetJob2 = targetXPlayer.getJob2()

		if sourceJob2.name == targetJob2.name then
			targetXPlayer.setJob2('unemployed2', 0)
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, ('Vous avez ~r~viré %s~w~.'):format(targetXPlayer.name))
			TriggerClientEvent('esx:showNotification', target, ('Vous avez été ~g~viré par %s~w~.'):format(sourceXPlayer.name))
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Le joueur n\'es pas dans votre organisation.')
		end
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
	end
end))

function discordlogs (title,message,color)
    local DiscordWebHook = Config.Webhook
    
    local embeds = {
        {
            ["title"]= title,
            ["description"] = message,              
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "Adminmenü - "..os.date("%x %X %p"),
            ["icon_url"]= "https://cdn.discordapp.com/attachments/891656387917123634/955906604363051018/dnz_2.png",
           },
        }
    }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds, avatar_url = "https://cdn.discordapp.com/attachments/891656387917123634/955906604363051018/dnz_2.png"}), { ['Content-Type'] = 'application/json' })
end

function discordlogs2 (title,message,color)
    local DiscordWebHook = Config.Webhook
    
    local embeds = {
        {
            ["title"]= title,
            ["description"] = message,              
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "Adminmenü - "..os.date("%x %X %p"),
            ["icon_url"]= "https://cdn.discordapp.com/attachments/891656387917123634/955906604363051018/dnz_2.png",
           },
        }
    }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds, avatar_url = "https://cdn.discordapp.com/attachments/891656387917123634/955906604363051018/dnz_2.png"}), { ['Content-Type'] = 'application/json' })
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
    if Config.Webhook~=nil then
        PerformHttpRequest(Config.Webhook, function(a,b,c)end, "POST", json.encode({embeds={{title="Ban - Logs",description=msg:gsub("%^%d",""),color=65280,}}}), {["Content-Type"]="application/json"})
    end
end

ESX.RegisterServerCallback("Admin:getRankFromPlayer", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

RegisterServerEvent('aduty')
AddEventHandler('aduty',function(source)
	TriggerClientEvent("toggleDuty", source)
	TriggerClientEvent("adminhl:c_godmodexyz", source)
end)

