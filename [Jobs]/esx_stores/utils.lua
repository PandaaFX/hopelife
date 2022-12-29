RegisterNetEvent("stores:Notify")
AddEventHandler("stores:Notify", function(type,msg)
	-- You can change your notification here
	SendNUIMessage({ 
		notification = msg,
		notification_type = type,
	})
end)

function DrawMarker_blip(x,y,z)
	DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
end
function DrawMarker_truck(x,y,z)
	DrawMarker(39,x,y,z-0.6,0,0,0,0.0,0,0,1.0,1.0,1.0,255,0,0,50,0,0,0,1)
end

function DrawText3D2(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = #(vector3(px,py,pz) - vector3(x,y,z))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.35*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- spawnVehicle
-----------------------------------------------------------------------------------------------------------------------------------------

function spawnVehicle(name,x,y,z,h)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local veh = CreateVehicle(mhash,x,y,z+0.5,h,true,false)
		local netid = NetworkGetNetworkIdFromEntity(veh)
		SetVehicleHasBeenOwnedByPlayer(veh, true)
		SetNetworkIdCanMigrate(netid, true)
		SetVehicleNeedsToBeHotwired(veh, false)
		SetVehRadioStation(veh, 'OFF')
		SetModelAsNoLongerNeeded(model)

        SetVehicleNumberPlateText(veh, Lang[Config.lang]['truck_plate']..tostring(math.random(1000, 9999)))
		-- Put here your vehicle keys function

		SetVehicleFuelLevel(veh,100.0)
		DecorSetFloat(veh, "_FUEL_LEVEL", GetVehicleFuelLevel(veh))

		local blip = AddBlipForEntity(veh)
		SetBlipSprite(blip,477)
		SetBlipColour(blip,26)
		SetBlipAsShortRange(blip,false)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Lang[Config.lang]['truck_blip'])
		EndTextCommandSetBlipName(blip)

		return veh,blip
	end
end