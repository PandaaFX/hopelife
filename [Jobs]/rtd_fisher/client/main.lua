local x = false
local y = nil
local z = nil
local v = false
local u = RTD.nombrepez
local i = RTD.cantidad
local d = RTD.Etapa1
local f = RTD.Etapa2
local s =  RTD.SpawnAuto
local t = false
local e = false
local p = ""
local k = RTD.pescados

RegisterNetEvent('rtd_fisher:caña')
AddEventHandler('rtd_fisher:caña', function()
	Ped = PlayerPedId()
	local pos = GetEntityCoords(PlayerPedId())
	if IsPedInAnyVehicle(Ped) then
        ESX.ShowNotification("Sie können nicht von einem Fahrzeug aus fischen")
	else
		if Water() then
			if x then
				ClearPedTasks(PlayerPedId())
				x = false
			else
				x = true
				ClearPedTasks(PlayerPedId())
				TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, false)


				
				local modelo = nil
				modelo= GetHashKey('a_c_fish')
				RequestModel(modelo)
				while not HasModelLoaded(modelo) do
					Wait(1)
				end
				Citizen.Wait(10000)
				local SacarPez = CreatePed(2, modelo, y, 90.0, false, true)
				Citizen.Wait(1)
				SetModelAsNoLongerNeeded(modelo)
				Citizen.Wait(1)
				TaskSetBlockingOfNonTemporaryEvents(SacarPez, true)
				Citizen.Wait(1000)
				TaskGoToCoordAnyMeans(SacarPez, y.x, y.y+1, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(1000)
				TaskGoToCoordAnyMeans(SacarPez, y.x, y.y, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(1000)
				TaskGoToCoordAnyMeans(SacarPez, y.x+1, y.y, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(1000)
				TaskGoToCoordAnyMeans(SacarPez, y.x, y.y, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(1000)
				TaskGoToCoordAnyMeans(SacarPez, y.x, y.y+1, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(1000)
				TaskGoToCoordAnyMeans(SacarPez, y.x, y.y, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(1000)
				TaskGoToCoordAnyMeans(SacarPez, y.x+1, y.y, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(1000)
				TaskGoToCoordAnyMeans(SacarPez, y.x, y.y, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(1000)
				TaskGoToCoordAnyMeans(SacarPez, y.x, y.y+1, y.z, 1.0, 0, 0, 786603, 1.0)

				local correct = math.random(1,4)
				local tecla = {"hoch", "runter", "links", "rechts"}
				ESX.ShowNotification("Der Fisch hat in den Haken gebissen, drücken " .. tecla[correct] .. "(Pfeiltasten) ihn zu fangen")
				v = false
				atrapame()

				Citizen.Wait(3000)
				TaskGoToCoordAnyMeans(SacarPez, y.x, y.y, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(3000)
				TaskGoToCoordAnyMeans(SacarPez, y.x+1, y.y, y.z, 1.0, 0, 0, 786603, 1.0)
				Citizen.Wait(3000)
				TaskGoToCoordAnyMeans(SacarPez, y.x, y.y, y.z, 1.0, 0, 0, 786603, 1.0)

				SetEntityAsMissionEntity(SacarPez, true, true)
				DeleteEntity(SacarPez)
				v = true

				

				ClearPedTasks(PlayerPedId())
				if z == correct then
					TriggerServerEvent("rtd_fisher:daritem", u, i)
					ESX.ShowNotification("Sie haben frischen Fisch")
				else
					local breaking = math.random(0,100)
					ESX.ShowNotification("der Fisch ist entkommen")
					if breaking <= 50 then
						TriggerServerEvent("breaking")
						ESX.ShowNotification("Die Angel ist zerbrochen")
					end
					
				end
				x = false
			end
		else
            ESX.ShowNotification("Du musst vor dem Wasser sein")
		end
	end
	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPedPos = GetEntityCoords(GetPlayerPed(-1), true)
		local fishingRod = GetClosestObjectOfType(playerPedPos, 2.0, GetHashKey("prop_fishing_rod_01"), false, false, false)
		
		if (IsPedActiveInScenario(GetPlayerPed(-1)) == false) then
			SetEntityAsMissionEntity(fishingRod, 1, 1)
			DeleteEntity(fishingRod)
		end
	end
end)

function atrapame()
	Citizen.CreateThread(function()
		z = 6
		while true do
			Citizen.Wait(5)
			if v then
				break
			end
			
			if x then
				if IsControlJustReleased(0, 27) then
					z = 1
				end
				if IsControlJustReleased(0, 173) then
					z = 2
				end
				if IsControlJustReleased(0, 174) then
					z = 3
				end
				if IsControlJustReleased(0, 175) then
					z = 4
				end
			end
		end
	end)
end

function Water()
	local ped = PlayerPedId()
	local rV, fV, uV, pos = GetEntityMatrix(ped)

	nV = rV * 10.0;

	

	local hitWater = TestProbeAgainstWater(pos.x + rV.x, pos.y + rV.y, pos.z + rV.z, pos.x + nV.x, pos.y + nV.y, pos.z + nV.z - 10.0)
	local rayHandle = StartShapeTestRay(pos.x + rV.x, pos.y + rV.y, pos.z + rV.z, pos.x + nV.x, pos.y + nV.y, pos.z + nV.z - 10.0, -1, ped)
	local _, hit, coords, _, materialHash = GetShapeTestResultIncludingMaterial(rayHandle)

	y = coords

	local underWater = StartShapeTestRay(coords.x, coords.y, coords.z - 0.1, coords.x, coords.y, coords.z - 10.0, -1, ped)
	local _, underHit, coords, _, underMaterialHash = GetShapeTestResultIncludingMaterial(underWater)

	return ((materialHash == 435688960 and k[tostring(underMaterialHash)]) or hitWater) and true or false
end

Citizen.CreateThread(function()
    local modelodepd= RTD.pedmodel
    modelodehash = GetHashKey(modelodepd)
    RequestModel(modelodehash)
    while not HasModelLoaded(modelodehash) do
           Citizen.Wait(100)
    end
    crearnpc()  
	crearnpc2()
end)

function crearnpc()
	local coords = RTD.coords
	local modelodepd= RTD.pedmodel
	
    crear_ped = CreatePed(5, GetHashKey(modelodepd) , coords.x, coords.y, coords.z-1, coords.h, false, true)
    FreezeEntityPosition(crear_ped, true)
    SetEntityInvincible(crear_ped, true)
    SetBlockingOfNonTemporaryEvents(crear_ped, true)
    TaskStartScenarioInPlace(crear_ped, "WORLD_HUMAN_DRINKING", 0, true)
end

function crearnpc2()
	local coords = RTD.tienda
	local modelodepd= RTD.pedmodel
	
    crear_ped = CreatePed(5, GetHashKey(modelodepd) , coords.x, coords.y, coords.z-1, coords.h, false, true)
    FreezeEntityPosition(crear_ped, true)
    SetEntityInvincible(crear_ped, true)
    SetBlockingOfNonTemporaryEvents(crear_ped, true)
    TaskStartScenarioInPlace(crear_ped, "WORLD_HUMAN_DRINKING", 0, true)
end

Citizen.CreateThread(function()
    while true do
		Wait(0)

		local Ped = PlayerPedId()
		local coords = RTD.coords

        if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, GetEntityCoords(Ped, true)) <= 1 then
            ESX.ShowHelpNotification('Drücke ~INPUT_PICKUP~ um mit Alex zu sprechen')
            if IsControlJustPressed(0, 38) then
                VP()
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
		Wait(0)

		local Ped = PlayerPedId()
		local tienda = RTD.tienda

        if GetDistanceBetweenCoords(tienda.x, tienda.y, tienda.z, GetEntityCoords(Ped, true)) <= 2 then
            ESX.ShowHelpNotification('Drücke ~INPUT_PICKUP~ um mit Raul zu sprechen')
            if IsControlJustPressed(0, 38) then
				TC()
            end
        end
    end
end)

function VP()
	local elementos = {}
    local t = table.insert

	t(elementos, {label = '🐟 Fisch Verkaufen', value = 'vp'})
	t(elementos, {label = 'Nein danke!', value = 'no'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'abrir_venta', {
		title    = "Sie wollen Ihren Fisch verkaufen? ?",
        align    = 'right',
        elements = elementos
	}, function(data, menu)
		local v = data.current.value

		if v == 'vp' then
			CPS()
			menu.close()
		elseif v == 'no' then
			ESX.ShowNotification("Verschwende nicht meine Zeit, Arschloch.!")
			menu.close()
		end
	 end, function(data, menu)
		menu.close()
	end)
end

function CPS()

    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cps_pescados', {
        title = 'Wie viele Fische hast du?'
    }, function(data, menu)
        local cantidad = tonumber(data.value)

        if cantidad == nil then
            ESX.ShowNotification('unzureichende Menge')
		elseif cantidad <= 10 then
			TriggerServerEvent('rtd_fisher:vendermenos10', cantidad)
            menu.close()
		elseif cantidad >  10 then
			if t == false then
				local e =  true
				local t = true
				IMP(cantidad, e, t)	
				ESX.ShowNotification('Wow! und es ist eine Menge Ware, die Sie selbst ausliefern müssen')
			else
				ESX.ShowNotification('Schließen Sie zuerst Ihre erste Bestellung ab !')
			end
			menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function IMP(cantidad, e, t)
	Citizen.CreateThread(function ()
		sacar_auto()
		blip = AddBlipForCoord(d.x,d.y,d.z)
		SetBlipRoute(blip, true)
		while true do
			Citizen.Wait(0)
			if e == true then
				if GetDistanceBetweenCoords(d.x,d.y,d.z,GetEntityCoords(PlayerPedId(), true)) < 50 then
					DrawMarker(20, d.x,d.y,d.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,0,0, 200, 0, 0, 0, 0)
					if GetDistanceBetweenCoords(d.x,d.y,d.z,GetEntityCoords(PlayerPedId(), true)) < 3 then
                        ESX.ShowHelpNotification('Drücke ~INPUT_PICKUP~ um das Paket abzuladen')
						if IsControlJustPressed(1,38) then
							if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey("mule"))  then
								local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
								SetEntityAsMissionEntity(vehicle, true, true)		
								local platecaissei = GetVehicleNumberPlateText(vehicle)
								Citizen.Trace(p.."m")
								Citizen.Trace(platecaissei.."m")
								if platecaissei == p.." " then
									e = false
									ESX.ShowNotification('Ich lade deine Ladung ab...')
									FreezeEntityPosition(vehicle,true)
									Citizen.Wait(5000)
									FreezeEntityPosition(vehicle,false)
									ESX.ShowNotification('Sie können diese Bestellung jetzt zurücksenden.')
									RemoveBlip(blip)
									blip = AddBlipForCoord(f.x,f.y,f.z)
									SetBlipRoute(blip, true)
								else
									ESX.ShowNotification('Das ist nicht dein Fahrzeug.')
								end
							else
								ESX.ShowNotification('Das Auto ist mir egal.')
							end
						end
					end
				end
			elseif e == false then
				if GetDistanceBetweenCoords(f.x,f.y,f.z,GetEntityCoords(PlayerPedId(), true)) < 50 then
					DrawMarker(20, f.x,f.y,f.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,0,0, 200, 0, 0, 0, 0)
					if GetDistanceBetweenCoords(f.x,f.y,f.z,GetEntityCoords(PlayerPedId(), true)) < 3 then
                        ESX.ShowHelpNotification('Drücke ~INPUT_PICKUP~ zum Verlassen.')
						if IsControlJustPressed(1,38) then
							if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey("mule"))  then
								local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
								TriggerServerEvent('rtd_fisher:terminarmision', cantidad)
								RemoveBlip(blip)
								deleteCar(vehicle)
								t = false
								break
							end
						end
					end
				end
			end
		end
	end)
end

function sacar_auto()
	Citizen.Wait(100)

	local myPed = PlayerPedId()
	local player = PlayerId()
	local vehicle = GetHashKey('mule')

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end
	local sacar_auto = CreateVehicle(vehicle, s.x,s.y,s.z, s.h, - 996.786, 25.1887, true, false)

	p = "CTZN"..math.random(100, 900)
	Citizen.Trace(p)
    SetVehicleNumberPlateText(sacar_auto, p)
	SetVehicleOnGroundProperly(sacar_auto)
	SetVehicleLivery(sacar_auto, 2)
	--exports["LegacyFuel"]:SetFuel(vehicle, 100)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(sacar_auto))
	Citizen.Trace(p)
end

function deleteCar(vehicle)
	local ped = PlayerPedId()

	TaskLeaveVehicle(ped, vehicle, 0)
	Citizen.Wait(3000)
	NetworkFadeOutEntity(vehicle, false, true)
	Citizen.Wait(1000)
	exports["AdvancedParking"]:DeleteVehicle(vehicle)
	DeleteVehicle(vehicle)
end

-- [[ Tienda de Cañas ]] --

function TC()
	local elementos = {}
	local t = table.insert

	t(elementos, {label = '🎣 Angel kaufen 5000$', value = 'comprar'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'abrir_tienda', {
		title    = "Möchten Sie eine Angel kaufen? ?",
        align    = 'right',
        elements = elementos
	}, function(data, menu)
		local v = data.current.value

		if v == 'comprar' then
			CDC()
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function CDC()

	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cps_pescados', {
        title = 'Wie viele willst du ?'
    }, function(data, menu)
        local cantidad = tonumber(data.value)

        if cantidad == nil then
            ESX.ShowNotification('unzureichende Menge')
		elseif cantidad >= 1 then
			TriggerServerEvent('rtd_fisher:comprarobjeto', cantidad)
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

--[[ BLIP ]]--

local blips = RTD.Blips
	
Citizen.CreateThread(function()

	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.8)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)
