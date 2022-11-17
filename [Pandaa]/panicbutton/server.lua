ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local Config = {}
-- Time in secs between Panic Button activates
-- Set to 0 to impose no cooldown
Config.Cooldown = 120

local Panic = {}
Panic.Cooling = 0

RegisterServerEvent("Police-Panic:NewPanic")
AddEventHandler("Police-Panic:NewPanic", function(Officer)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local jobs = {"fib", "police", "lssd", "ambulance"}
	if Panic.Cooling == 0 then
		Panic.Cooling = Config.Cooldown
		for key, value in pairs(jobs) do
			for _key, _value in pairs(ESX.GetJobPlayers(value)) do
				local xPlayers = ESX.GetPlayerFromId(_value)
				if xPlayers.getJob().name == value then
					TriggerClientEvent("Pass-Alarm:Return:NewPanic", xPlayers.source, source, Officer) 
				end
			end
		end
	else
		TriggerClientEvent("Pass-Alarm:Return:Notify", _source, "~r~Panik-Button verfügbar in ".. Panic.Cooling .. " Sekunden.", true)
	end
end)

RegisterServerEvent("Police-Panic:HasItem")
AddEventHandler("Police-Panic:HasItem", function(Officer) 
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local itemCount = xPlayer.getInventoryItem("panicbutton").count
	if itemCount > 0 then
		TriggerClientEvent("Pass-Alarm:Return:HasItem", xPlayer.source, Officer)
	else
		TriggerClientEvent("Pass-Alarm:Return:Notify", xPlayer.source, "~r~Du hast keinen Panik-Button", true)
	end
end)

RegisterServerEvent("Police-Panic:Discord-Log")
AddEventHandler("Police-Panic:Discord-Log", function(Officer)
	local embed = {
		{
			["color"] = 15158332,
			["title"] = "**[Panik-Button]**",
			["description"] = string.format("**%s** hat den Panik-Button betätigt\n**JOB:** ".. Officer.Job, Officer.Name),
			["footer"] = {
				["text"] = os.date("%c")
			}
		}
	}
	PerformHttpRequest("https://discord.com/api/webhooks/1013497781631062096/Ph2rr4BlEbWxN2p8G-PUfQ_gkYNeUwso3CHjl2d4BtJlu_Bn-MG-xMzqrdqUhwBhhnVX", function(err, text, headers) end, 'POST', json.encode({username = "Panik Button" ,embeds = embed}), { ['Content-Type']= 'application/json' })
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if Panic.Cooling ~= 0 then
			Citizen.Wait(1000)
			Panic.Cooling = Panic.Cooling - 1
		end
	end
end)