ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()


	local Config = {}
	-- Time in secs between Panic Button activates PER client
	-- Set to 0 to impose no cooldown
	Config.Cooldown = 120
	-- Time in secs blip flashes and map route appears on tuned
	-- clients screens before disappearing
	Config.BlipTime = 120


	local Panic = {}
	Panic.Cooling = 0

	Citizen.CreateThread(function()
		while true do
			if IsControlPressed(1, 21) and IsControlPressed(1, 19) and IsControlJustPressed(1, 194) then -- Shift + LALT + Backspace
				if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'fib' or ESX.PlayerData.job.name == 'lssd' or ESX.PlayerData.job.name == 'ambulance' then
					if Panic.Cooling == 0 then
						local Officer = {}
						Officer.Ped = PlayerPedId()
						Officer.Job = ESX.PlayerData.job.name
						Officer.Name = GetPlayerName(PlayerId())
						Officer.Coords = GetEntityCoords(Officer.Ped)
						Officer.Location = {}
						Officer.Location.Street, Officer.Location.CrossStreet = GetStreetNameAtCoord(Officer.Coords.x, Officer.Coords.y, Officer.Coords.z)
						Officer.Location.Street = GetStreetNameFromHashKey(Officer.Location.Street)
						if Officer.Location.CrossStreet ~= 0 then
							Officer.Location.CrossStreet = GetStreetNameFromHashKey(Officer.Location.CrossStreet)
							Officer.Location = Officer.Location.Street .. " X " .. Officer.Location.CrossStreet
						else
							Officer.Location = Officer.Location.Street
						end
		
						TriggerServerEvent("Police-Panic:HasItem", Officer)
		
					else
						NewNoti("~r~Panik-Button verfügbar in ".. Panic.Cooling .. " Sekunden.", true)
					end
				else
					NewNoti("~r~Du hast keinen Staatlichen Job.", true)
				end
			end
			Citizen.Wait(0)
		end
	end)

	RegisterNetEvent("Pass-Alarm:Return:HasItem")
	AddEventHandler("Pass-Alarm:Return:HasItem", function(Officer)
		Panic.Cooling = Config.Cooldown
		TriggerServerEvent("Police-Panic:NewPanic", Officer)
	end) 

	RegisterNetEvent("Pass-Alarm:Return:Notify")
	AddEventHandler("Pass-Alarm:Return:Notify", function(Text, Flash)
		NewNoti(Text, Flash)
	end)


	RegisterNetEvent("Pass-Alarm:Return:NewPanic")
	AddEventHandler("Pass-Alarm:Return:NewPanic", function(source, Officer)

		local department = ""

		SendNUIMessage({
			PayloadType	= {"Panic", "LocalPanic"},
			Payload	= source
		})
		if Officer.Ped == PlayerPedId() then
			TriggerServerEvent("Police-Panic:Discord-Log", Officer)
		end

		if Officer.Job == "police" then
			department = "Los Santos Police Department"
		elseif Officer.Job == "fib" then
			department = "Federal Investigation Bureau"
		elseif Officer.Job == "lssd" then
			department = "Los Santos Sherrif Department"
		elseif Officer.Job == "ambulance" then
			department = "Los Santos Medical Department"
		end

		TriggerEvent('esx:showAdvancedNotification', department, 'Information', 'Panicbutton gedrückt | ' ..Officer.Location, 'CHAR_CALL911', 1)

		Citizen.CreateThread(function()
			local Blip = AddBlipForRadius(Officer.Coords.x, Officer.Coords.y, Officer.Coords.z, 100.0)

			SetBlipRoute(Blip, true)

			Citizen.CreateThread(function()
				while Blip do
					SetBlipRouteColour(Blip, 1)
					Citizen.Wait(150)
					SetBlipRouteColour(Blip, 6)
					Citizen.Wait(150)
					SetBlipRouteColour(Blip, 35)
					Citizen.Wait(150)
					SetBlipRouteColour(Blip, 6)
				end
			end)

			SetBlipAlpha(Blip, 60)
			SetBlipColour(Blip, 1)
			SetBlipFlashes(Blip, true)
			SetBlipFlashInterval(Blip, 200)

			Citizen.Wait(Config.BlipTime * 1000)

			RemoveBlip(Blip)
			Blip = nil
		end)
	end)

	function NewNoti(Text, Flash)
		SetNotificationTextEntry("STRING")
		AddTextComponentString(Text)
		DrawNotification(Flash, true)
	end

Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			if Panic.Cooling ~= 0 then
				Citizen.Wait(1000)
				Panic.Cooling = Panic.Cooling - 1
			end
		end
	end)
end)