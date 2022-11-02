local clientcode = [[
	ESX = nil
	local PlayerData = {}
	local blur = "MenuMGIn"
	
	Citizen.CreateThread(function()
		while ESX == nil do
			Citizen.Wait(0)
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
	
		while PlayerData == nil do
			Citizen.Wait(200)
			PlayerData = ESX.GetPlayerData()
		end
	
		PlayerData = ESX.GetPlayerData()
	end)
	
	local PlayerIsLoaded = false
	
	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function (xPlayer)
		Citizen.Wait(500)
		PlayerIsLoaded = true
		PlayerData = xPlayer
	end)
	
	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)
	  PlayerData.job = job
	end)
	
	AddEventHandler('onResourceStart', function(resourceName)
		if (GetCurrentResourceName() ~= resourceName) then
			return
		end
	
		PlayerIsLoaded = true
	end)
	
	Citizen.CreateThread(function()
		for i = 1, #Config.Shops, 1 do

            local v = Config.NPCConfig[i]
            
				local x, y, z = Config.Shops[i].coords
				RequestModel(v[4])
				while not HasModelLoaded(v[4]) do
					Wait(1)
				end
				ped = CreatePed(4, v[4],x,y,z, 3374176, false, true)
				SetEntityHeading(ped, v[2])
				FreezeEntityPosition(ped, true)
				SetEntityInvincible(ped, true)
				SetBlockingOfNonTemporaryEvents(ped, true)

		end
	end)
	
	local enableField = false
	
	function toggleField(enable)
		enableField = enable
	
		if enable then   
			ESX.TriggerServerCallback('hl_frakshop:getVehicles', function(Vehicles)
				if Vehicles[1] ~= nil then
					SetNuiFocus(enable, enable)
					StartScreenEffect(blur)
					SendNUIMessage({
						action = 'open',
						job = PlayerData.job.label,
						frakname = PlayerData.job.name
					}) 
	
	
					for i = 1, #Vehicles, 1 do
						if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
							local price = ESX.Math.GroupDigits(Vehicles[i].price)
							AddCar(price, Vehicles[i].name, Vehicles[i].model)
						else
							print(('hl_frakshop: vehicle "%s" does not exist'):format(Vehicles[i].model))
						end
					end
				else
					TriggerEvent('esx:showAdvancedNotification', 'Fraktions Autohändler', 'Information', "Deine Fraktion kann keine Fahrzeuge kaufen.", 'CHAR_TOM', 1)
				end
			end, PlayerData.job.name, PlayerData.job.grade)
		else
			SetNuiFocus(enable, enable)
			SendNUIMessage({
				action = 'close'
			}) 
		end
	end
	
	AddEventHandler('onResourceStart', function(name)
		if GetCurrentResourceName() ~= name then
			return
		end
	
		toggleField(false)
		StopScreenEffect(blur)
	end)
	
	RegisterNUICallback('escape', function(data, cb)
		toggleField(false)
		SetNuiFocus(false, false)
		cb('ok')
		StopScreenEffect(blur)
	end)
	
	RegisterNUICallback('enable-parkout', function(data, cb)
		ESX.TriggerServerCallback('hl_frakshop:getVehicles', function(Vehicles)
			for i = 1, #Vehicles, 1 do 
				if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
					local price = ESX.Math.GroupDigits(Vehicles[i].price)
					AddCar(price, Vehicles[i].name, Vehicles[i].model)
				else
					print(('hl_frakshop: vehicle "%s" does not exist'):format(Vehicles[i].model))
				end
			end
		end, PlayerData.job.name)
	end) 
	
	function randomchar(a,b)
		return string.char(math.random(string.byte(a),string.byte(b)))
	end
	
	
	RegisterNUICallback('buy', function(data, cb)
		ESX.TriggerServerCallback('hl_frakshop:buyVehicle', function(hasEnoughMoney, vehType)
			if hasEnoughMoney then
				toggleField(false)
				SetNuiFocus(false, false)
				SendNUIMessage({
					action = 'close'
				})
				StopScreenEffect(blur)
				DoScreenFadeOut(1200)
				Citizen.Wait(1200)

				for i = 1, #Config.Shops, 1 do


							local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Shops[i].coords)
							
							if dist <= Config.InteractDistance then
								ESX.Game.SpawnVehicle(data.model, Config.Shops[i].SpawnZone, Config.Shops[i].SpawnHeading, function(vehicle)
									a=randomchar('A','Z')
									b=randomchar('A','Z')
									c=randomchar('A','Z')
					
									n1=randomchar('0','9')
									n2=randomchar('0','9')
									n3=randomchar('0','9')
									local newPlate = a..b..c.. ' ' ..n1..n2..n3
									local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
									vehicleProps.plate = newPlate
									TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
									SetVehicleNumberPlateText(vehicle, newPlate)
									TriggerServerEvent('hl_frakshop:setVehicleOwned', vehicleProps, PlayerData.job.name, vehType)
									Citizen.Wait(500)
									DoScreenFadeIn(800)
									Citizen.Wait(700)
									TriggerEvent('esx:showAdvancedNotification', 'Fraktions Autohändler', 'Information', "Du hast ein Fahrzeug gekauft.\nKennzeichen: " .. newPlate, 'CHAR_TOM', 1)
								end)
								
							end


				end

			else
				TriggerEvent('esx:showAdvancedNotification', 'Fraktions Autohändler', 'Information', "Du hast nicht genug Geld dabei.", 'CHAR_TOM', 1)
			end
		end, data.model)
	end)
	
	Citizen.CreateThread(function()
		while true do
			Wait(1)
			for i = 1, #Config.Shops, 1 do
				if PlayerIsLoaded == true then
					if PlayerData.job.name ~= "unemployed" then
						local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Shops[i].coords)
						
						if dist <= Config.InteractDistance then
							ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Fraktions Autohändler zu öffnen")
	
							if IsControlJustReleased(0, Config.InteractKey) then
								toggleField(true)
							end
						end
					end
				end
			end
		end
	end)
	
	function AddCar(plate, name, model)
		SendNUIMessage({
			action = 'addcar',
			plate = plate,
			model = name,
			name = model
		})
	end
	
	
	local NumberCharset = {}
	local Charset = {}
	
	for i = 48,  57 do
		table.insert(NumberCharset, string.char(i))
	end
	
	for i = 65,  90 do 
		table.insert(Charset, string.char(i)) 
	end
	
	for i = 97, 122 do 
		table.insert(Charset, string.char(i)) 
	end
	
	
	
	function GetRandomNumber(length)
		Citizen.Wait(0)
		math.randomseed(GetGameTimer())
		if length > 0 then
			return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
		else
			return ''
		end
	end
	
	function GetRandomLetter(length)
		Citizen.Wait(0)
		math.randomseed(GetGameTimer())
		if length > 0 then
			return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
		else
			return ''
		end
	end
	
	Citizen.CreateThread(function()
		for i = 1, #Config.Shops, 1 do
			local blip = AddBlipForCoord(Config.Shops[i].coords)
			SetBlipSprite(blip, Config.Sprite)
			SetBlipDisplay(blip, Config.Display)
			SetBlipScale(blip, Config.Scale)
			SetBlipColour(blip, Config.Colour)
			SetBlipAsShortRange(blip, true)
			
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Fraktions Autohändler")
			EndTextCommandSetBlipName(blip)
		end
	end)
]]




















ESX = nil
local Vehicles = {}

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('hl_frakshop:getVehicles',function(source, cb, job, grade)
	MySQL.Async.fetchAll("SELECT * FROM frakshop WHERE job = @job",{ ["@job"] = job},function(vehicles)
		for i=1, #vehicles, 1 do
			local vehicle = vehicles[i]
			-- print(json.encode(vehicle))
			if tonumber(vehicle.grade) <= tonumber(grade) then
				table.insert(Vehicles, vehicle)
			end
	
		end

		cb(Vehicles)
		Citizen.Wait(50)
		Vehicles = {}
    end)
end)

ESX.RegisterServerCallback('hl_frakshop:buyVehicle', function(source, cb, model)
	local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT price, type FROM frakshop WHERE model = @model",{ ["@model"] = model},function(result)
		local price = result[1].price
		local vehType = result[1].type
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
			cb(true, vehType)
		else
			cb(false)
		end
    end)
end)

RegisterServerEvent('hl_frakshop:setVehicleOwned')
AddEventHandler('hl_frakshop:setVehicleOwned', function(vehicleProps, job, vehicleType)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job) VALUES (@owner, @plate, @vehicle, @vehicleType, @job)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@vehicleType'] = vehicleType,
		['@job'] = job,
	}, function(rowsChanged)
	end)
end)





RegisterServerEvent('54nwmkiAKNOPWD232:ijdknAWND2')
AddEventHandler('54nwmkiAKNOPWD232:ijdknAWND2', function()
    local _source = source

    TriggerClientEvent('54nwmkiAKNOPWD232:ijdkn24MOIKPSDDND2', _source, clientcode)
end)