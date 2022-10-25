--[[---------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

LIFT SCRIPT
Made By Sarish#8939 For Patoche#4702

Sarish#8939 :
Discover all my creation on AURORA-RP : https://discord.gg/me9w4wS
Feel free to use / modify / share this script but please credit me


Patoche : bisou sur le pétou


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------]]
local isReady = false
-- local prevframes, prevtime, curtime, curframes, fps, RateAdjsuter = 0, 0, 0, 0, 0, 0

function DisplayHelpText(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end




local liftData = {
	["789456"] = {
		code = "789456",
		
		InteriorId = 3330, --GetInteriorFromEntity(ped)
		
		controlup = {x=-1074.7889404297,y=-252.78123474121,z=44.021064758301}, --(Inter de control murale pour appeler la cabine)
		controldown = {x=-1074.7200927734,y=-252.8878326416,z=37.763286590576}, 
		
		up = {x=-1074.8277587891,y=-254.590279099609,z=42.99}, --(position cabine)
		down = {x=-1074.8277587891,y=-254.590279099609,z=36.73},
		
		controlCabineUp = {x=-1075.8618164063,y=-254.42388916016,z=44.02}, --(Inter de control dans la cabine)
		controlCabineDown = {x=-1075.8618164063,y=-254.42388916016,z=37.734912872314},
		
		downRoomId = -1711658181, --Gestion des portal (useless now)
		upRoomId = -266971274,
		
		
		Zelevate=42.99-36.73, --Hauteur d'élévation Zmax - Zmin (flemme de calculer)
		
		isUp = true,
		
		isInUse = false,
		
		currentCoords = {x=-1074.8277587891,y=-254.590279099609,z=36.73}, --useless
		
		elevateProps = "patoche_elevator", --Cabine props
		rotation = {a=0.0,b=0.0,c=0.0},
		elevateHeading = 27.649951934814, --Heading de l'ascenceur (World relative)
		elevateID = 0, -- ID du props spawn
		
		
		downDoorIsOpen = false,
		
		doorDownL = "v_ilev_fib_doore_l",
		doorDownLCoords = {x=-1075.2545,y=-253.5753,z=36.7732},
		doorDownLOpenCoords = {x=-1074.701, y=-253.2831, z=36.7732},
		doorDownLHeading = 27.649951934814,
		doorDownLID = 0, -- ID du props spawn
		
		doorDownR = "v_ilev_fib_doore_r",
		doorDownRCoords = {x=-1075.2634,y=-253.5800,z=36.7732},
		doorDownROpenCoords = {x=-1075.817, y=-253.8722, z=36.7732},
		doorDownRHeading = 27.649951934814,
		doorDownRID = 0, -- ID du props spawn
		
		
		
		upDoorIsOpen = false,
		
		doorUpL = "v_ilev_fib_doore_l",
		doorUpLCoords = {x=-1075.2545,y=-253.5753,z=43.025},
		doorUpLOpenCoords = {x=-1074.701, y=-253.2831, z=43.025},
		doorUpLHeading = 27.649951934814,
		doorUpLID = 0,-- ID du props spawn
		
		doorUpR = "v_ilev_fib_doore_r",
		doorUpRCoords = {x=-1075.2634,y=-253.5800,z=43.025},
		doorUpROpenCoords = {x=-1075.817, y=-253.8722, z=43.025},
		doorUpRHeading = 27.649951934814,
		doorUpRID = 0,-- ID du props spawn
		
		
		cabineDoorIsOpen = false,
		
		cabineDoorL = "v_ilev_fib_doore_l",
		cabineDoorLCoords = {x=-0.665,y=1.015,z=0.05}, --pos et h relative a la cabine
		cabineDoorLOpenCoords = {x=-1.365,y=1.015,z=0.025}, --1.025
		cabineDoorLHeading = 27.649951934814,
		cabineDoorLID = 0,-- ID du props spawn
		
		cabineDoorR = "v_ilev_fib_doore_l",
		cabineDoorRCoords = {x=0.09,y=1.015,z=0.05}, --pos et h relative a la cabine
		cabineDoorROpenCoords = {x=0.79,y=1.015,z=0.025},
		cabineDoorRHeading = 27.649951934814,
		cabineDoorRID = 0,-- ID du props spawn
		
	}
}

incircle = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if isReady then
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			local pedDetailedCoords = {}
			pedDetailedCoords.x,pedDetailedCoords.y,pedDetailedCoords.z = table.unpack(pedCoords)
			for k,v in pairs(liftData) do
				if Vdist(pedCoords,v.controldown.x,v.controldown.y,v.controldown.z) < 30.0 or Vdist(pedCoords,v.controlup.x,v.controlup.y,v.controlup.z) < 30.0 then
					--DrawMarker(1, v.controldown.x,v.controldown.y,v.controldown.z-1.1, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.2001, 0, 0, 155,165, 0, 0, 0,0)
					--DrawMarker(1, v.controlup.x,v.controlup.y,v.controlup.z-1.1, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.2001, 0, 0, 155,165, 0, 0, 0,0)
					
					if not v.isInUse then
						--DrawMarker(1, v.controlCabineDown.x,v.controlCabineDown.y,v.controlCabineDown.z-1.1, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.2001, 0, 0, 155,165, 0, 0, 0,0)
						
						--DrawMarker(1, v.controlCabineUp.x,v.controlCabineUp.y,v.controlCabineUp.z-1.1, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.2001, 0, 0, 155,165, 0, 0, 0,0)
						
						local ExistElevator = false
						if DoesEntityExist(v.elevateID) then 
							ExistElevator = true 
							SetEntityVisible(v.elevateID,true)
						end
						if not ExistElevator then
							if not v.isUp then
								localElevateId = GetClosestObjectOfType(v.down.x,v.down.y,v.down.z,3.0,GetHashKey(v.elevateProps),false,false,false)
							else
								localElevateId = GetClosestObjectOfType(v.up.x,v.up.y,v.up.z,3.0,GetHashKey(v.elevateProps),false,false,false)
							end
							
							if localElevateId ~= 0 then 
								v.elevateID = localElevateId
							end
						end
						
						local ExistDownDoorL = false
						local ExistDownDoorR= false
						if DoesEntityExist(v.doorDownLID) then 
							ExistDownDoorL = true 
							SetEntityVisible(v.doorDownLID,true)
						end
						if DoesEntityExist(v.doorDownRID) then 
							ExistDownDoorR = true 
							SetEntityVisible(v.doorDownRID,true)
						end
						
						if not downDoorIsOpen then
							if not ExistDownDoorL then
								localDownDoorL = GetClosestObjectOfType(v.doorDownLCoords.x,v.doorDownLCoords.y,v.doorDownLCoords.z,1.0,GetHashKey(v.doorDownL),false,false,false)
								if localDownDoorL ~= 0 then 
									v.doorDownLID = localDownDoorL
								end
							end
							if not ExistDownDoorR then
								localDownDoorR = GetClosestObjectOfType(v.doorDownRCoords.x,v.doorDownRCoords.y,v.doorDownRCoords.z,1.0,GetHashKey(v.doorDownR),false,false,false)
								if localDownDoorR ~= 0 then 
									v.doorDownRID = localDownDoorR
								end
							end
						else
							if not ExistDownDoorL then
								localDownDoorL = GetClosestObjectOfType(v.doorDownLOpenCoords.x,v.doorDownLOpenCoords.y,v.doorDownLOpenCoords.z,1.0,GetHashKey(v.doorDownL),false,false,false)
								if localDownDoorL ~= 0 then 
									v.doorDownLID = localDownDoorL
								end
							end
							if not ExistDownDoorR then
								localDownDoorR = GetClosestObjectOfType(v.doorDownROpenCoords.x,v.doorDownROpenCoords.y,v.doorDownROpenCoords.z,1.0,GetHashKey(v.doorDownR),false,false,false)
								if localDownDoorR ~= 0 then 
									v.doorDownRID = localDownDoorR
								end
							end
						end
						
						
						local ExistUpDoorL = false
						local ExistUpDoorR = false
						if DoesEntityExist(v.doorUpLID) then 
							ExistUpDoorL = true 
							SetEntityVisible(v.doorUpLID,true)
						end
						if DoesEntityExist(v.doorUpRID) then 
							ExistUpDoorR = true 
							SetEntityVisible(v.doorUpRID,true)
						end
						
						if not upDoorIsOpen then
							if not ExistUpDoorL then
								localUpDoorL = GetClosestObjectOfType(v.doorUpLCoords.x,v.doorUpLCoords.y,v.doorUpLCoords.z,1.0,GetHashKey(v.doorUpL),false,false,false)
								if localUpDoorL ~= 0 then 
									v.doorUpLID = localUpDoorL
								end
							end
							if not ExistUpDoorR then
								localUpDoorR = GetClosestObjectOfType(v.doorUpRCoords.x,v.doorUpRCoords.y,v.doorUpRCoords.z,1.0,GetHashKey(v.doorUpR),false,false,false)
								if localUpDoorR ~= 0 then 
									v.doorUpRID = localUpDoorR
								end
							end
						else
							if not ExistUpDoorL then
								localUpDoorL = GetClosestObjectOfType(v.doorUpLOpenCoords.x,v.doorUpLOpenCoords.y,v.doorUpLOpenCoords.z,1.0,GetHashKey(v.doorUpL),false,false,false)
								if localUpDoorL ~= 0 then 
									v.doorUpLID = localUpDoorL
								end
							end
							if not ExistUpDoorR then
								localUpDoorR = GetClosestObjectOfType(v.doorUpROpenCoords.x,v.doorUpROpenCoords.y,v.doorUpROpenCoords.z,1.0,GetHashKey(v.doorUpR),false,false,false)
								if localUpDoorR ~= 0 then 
									v.doorUpRID = localUpDoorR
								end
							end
						end
						
						
						if v.elevateID == 0 then 
							tempmodel = GetHashKey(v.elevateProps)
							RequestModel(tempmodel)
							while not HasModelLoaded(tempmodel) do
								RequestModel(tempmodel)
								Citizen.Wait(0)
							end
							
							if not v.isUp then
								v.elevateID = CreateObject(tempmodel,v.down.x,v.down.y,v.down.z ,false,false,true)
							else
								v.elevateID = CreateObject(tempmodel,v.up.x,v.up.y,v.up.z ,false,false,true)
							end
							
							v.cabineDoorLID=CreateObject(GetHashKey(v.cabineDoorL),v.up.x,v.up.y,v.up.z ,false,false,true)
							AttachEntityToEntity(v.cabineDoorLID,v.elevateID,0, v.cabineDoorLCoords.x,v.cabineDoorLCoords.y,v.cabineDoorLCoords.z, 0,0,0.0, false, false, true, false, 0, true)
							-- print("v.cabineDoorLID : "..tostring(v.cabineDoorLID).." "..tostring(GetEntityModel(v.cabineDoorLID)).." "..tostring(v.cabineDoorLCoords.x).." "..tostring(v.cabineDoorLCoords.y).." "..tostring(v.cabineDoorLCoords.z))
							v.cabineDoorRID=CreateObject(GetHashKey(v.cabineDoorR),v.up.x,v.up.y,v.up.z ,false,false,true)
							AttachEntityToEntity(v.cabineDoorRID,v.elevateID,0, v.cabineDoorRCoords.x,v.cabineDoorRCoords.y,v.cabineDoorRCoords.z, 0,0,0.0, false, false, true, false, 0, true)
							-- print("v.cabineDoorRID : "..tostring(v.cabineDoorRID))
							-- print("v.cabineDoorRID : "..tostring(v.cabineDoorRID).." "..tostring(GetEntityModel(v.cabineDoorRID)).." "..tostring(v.cabineDoorRCoords.x).." "..tostring(v.cabineDoorRCoords.y).." "..tostring(v.cabineDoorRCoords.z))
							FreezeEntityPosition(v.elevateID,true)
							SetEntityRotation(v.elevateID,v.rotation.a,v.rotation.b,v.rotation.c,0,false)
							SetEntityHeading(v.elevateID,v.elevateHeading)
						end
						
						if v.doorDownLID == 0 then 
							tempmodel = GetHashKey(v.doorDownL)
							RequestModel(tempmodel)
							while not HasModelLoaded(tempmodel) do
								RequestModel(tempmodel)
								Citizen.Wait(0)
							end
							
							v.doorDownLID=CreateObject(tempmodel,v.doorDownLCoords.x,v.doorDownLCoords.y,v.doorDownLCoords.z ,false,false,true)
							FreezeEntityPosition(v.doorDownLID,true)
							--SetEntityRotation(v.doorDownLID,v.rotation.a,v.rotation.b,v.rotation.c,0,false)
							SetEntityHeading(v.doorDownLID,v.doorDownLHeading)
						end
						
						if v.doorDownRID == 0 then 
							tempmodel = GetHashKey(v.doorDownR)
							RequestModel(tempmodel)
							while not HasModelLoaded(tempmodel) do
								RequestModel(tempmodel)
								Citizen.Wait(0)
							end
							
							v.doorDownRID=CreateObject(tempmodel,v.doorDownRCoords.x,v.doorDownRCoords.y,v.doorDownRCoords.z ,false,false,true)
							FreezeEntityPosition(v.doorDownRID,true)
							-- SetEntityRotation(v.elevateID,v.rotation.a,v.rotation.b,v.rotation.c,0,false)
							SetEntityHeading(v.doorDownRID,v.doorDownRHeading)
						end
						
						if v.doorUpLID == 0 then 
							tempmodel = GetHashKey(v.doorUpL)
							RequestModel(tempmodel)
							while not HasModelLoaded(tempmodel) do
								RequestModel(tempmodel)
								Citizen.Wait(0)
							end
							
							v.doorUpLID=CreateObject(tempmodel,v.doorUpLCoords.x,v.doorUpLCoords.y,v.doorUpLCoords.z ,false,false,true)
							FreezeEntityPosition(v.doorUpLID,true)
							-- SetEntityRotation(v.doorUpLID,v.rotation.a,v.rotation.b,v.rotation.c,0,false)
							SetEntityHeading(v.doorUpLID,v.doorUpLHeading)
						end
						
						if v.doorUpRID == 0 then 
							tempmodel = GetHashKey(v.doorUpR)
							RequestModel(tempmodel)
							while not HasModelLoaded(tempmodel) do
								RequestModel(tempmodel)
								Citizen.Wait(0)
							end
							
							v.doorUpRID=CreateObject(tempmodel,v.doorUpRCoords.x,v.doorUpRCoords.y,v.doorUpRCoords.z ,false,false,true)
							FreezeEntityPosition(v.doorUpRID,true)
							-- SetEntityRotation(v.elevateID,v.rotation.a,v.rotation.b,v.rotation.c,0,false)
							SetEntityHeading(v.doorUpRID,v.doorUpRHeading)
						end
					
					
					
						if Vdist(pedCoords,v.controldown.x,v.controldown.y,v.controldown.z) < 1.0  then
							if (incircle == false) then
								DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour appeler l'ascenseur.")
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent("lift:askDown",v.code)
							end
							
						elseif Vdist(pedCoords,v.controlup.x,v.controlup.y,v.controlup.z) < 1.0 then
							if (incircle == false) then
								DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour appeler l'ascenseur.")
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent("lift:askUp",v.code)
							end
							
						elseif Vdist(pedCoords,v.controlCabineDown.x,v.controlCabineDown.y,v.controlCabineDown.z) < 0.7 and not v.isInUse then
							if (incircle == false) then
								DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour monter.")
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent("lift:liftup",v.code,v.Zelevate)
							end
						elseif Vdist(pedCoords,v.controlCabineUp.x,v.controlCabineUp.y,v.controlCabineUp.z) < 0.7 and not v.isInUse then
							if (incircle == false) then
								DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour descendre.")
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent("lift:liftdown",v.code,v.Zelevate)
							end
						else
							incircle = false
						end
					end
				end
			end
		end
	end
end)


RegisterNetEvent("lift:openCabinDoor")
AddEventHandler('lift:openCabinDoor', function(code)
	code = "789456"
	local leftDoor = liftData[code].cabineDoorLID
	local rightDoor = liftData[code].cabineDoorRID
	local elevate = liftData[code].elevateID
	
	if not liftData[code].cabineDoorIsOpen then
		liftData[code].cabineDoorIsOpen = true
		for i=0,139 do
			Wait(1)
			AttachEntityToEntity(rightDoor,elevate,0, liftData[code].cabineDoorRCoords.x+((i+1)*0.005),liftData[code].cabineDoorRCoords.y,liftData[code].cabineDoorRCoords.z, 0,0,0.0, false, false, true, false, 0, true)
			AttachEntityToEntity(leftDoor,elevate,0, liftData[code].cabineDoorLCoords.x+((i+1)*-0.005),liftData[code].cabineDoorLCoords.y,liftData[code].cabineDoorLCoords.z, 0,0,0.0, false, false, true, false, 0, true)
		end
		AttachEntityToEntity(rightDoor,elevate,0, liftData[code].cabineDoorROpenCoords.x,liftData[code].cabineDoorROpenCoords.y,liftData[code].cabineDoorROpenCoords.z, 0,0,0.0, false, false, true, false, 0, true)
		AttachEntityToEntity(leftDoor,elevate,0, liftData[code].cabineDoorLOpenCoords.x,liftData[code].cabineDoorLOpenCoords.y,liftData[code].cabineDoorLOpenCoords.z, 0,0,0.0, false, false, true, false, 0, true)
	end
end)

RegisterNetEvent("lift:closeCabinDoor")
AddEventHandler('lift:closeCabinDoor', function(code)
	code = "789456"
	local leftDoor = liftData[code].cabineDoorLID
	local rightDoor = liftData[code].cabineDoorRID
	local elevate = liftData[code].elevateID
	
	if liftData[code].cabineDoorIsOpen then
		liftData[code].cabineDoorIsOpen = false
		for i=0,139 do
			Wait(1)
			AttachEntityToEntity(rightDoor,elevate,0, liftData[code].cabineDoorROpenCoords.x+((i+1)*-0.005),liftData[code].cabineDoorROpenCoords.y,liftData[code].cabineDoorROpenCoords.z, 0,0,0.0, false, false, true, false, 0, true)
			AttachEntityToEntity(leftDoor,elevate,0, liftData[code].cabineDoorLOpenCoords.x+((i+1)*0.005),liftData[code].cabineDoorLOpenCoords.y,liftData[code].cabineDoorLOpenCoords.z, 0,0,0.0, false, false, true, false, 0, true)
		end
		AttachEntityToEntity(rightDoor,elevate,0, liftData[code].cabineDoorRCoords.x,liftData[code].cabineDoorRCoords.y,liftData[code].cabineDoorRCoords.z, 0,0,0.0, false, false, true, false, 0, true)
		AttachEntityToEntity(leftDoor,elevate,0, liftData[code].cabineDoorLCoords.x,liftData[code].cabineDoorLCoords.y,liftData[code].cabineDoorLCoords.z, 0,0,0.0, false, false, true, false, 0, true)
	end
end)







RegisterNetEvent("lift:openDoorDown")
AddEventHandler('lift:openDoorDown', function(code)

	-- DEBUG
	-- code = "789456"
	------------------
	local leftDoor = liftData[code].doorDownLID
	local rightDoor = liftData[code].doorDownRID
	
	
	if not liftData[code].downDoorIsOpen then
		liftData[code].downDoorIsOpen = true
		TriggerEvent("lift:openCabinDoor",code)
		for i=0,125 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,0.005,0,0))
			SetEntityCoords(rightDoor,GetOffsetFromEntityInWorldCoords(rightDoor,-0.005,0,0))
		end
		SetEntityCoords(leftDoor,liftData[code].doorDownLOpenCoords.x,liftData[code].doorDownLOpenCoords.y,liftData[code].doorDownLOpenCoords.z)
		SetEntityCoords(rightDoor,liftData[code].doorDownROpenCoords.x,liftData[code].doorDownROpenCoords.y,liftData[code].doorDownROpenCoords.z)
	end
end)

RegisterNetEvent("lift:closeDoorDown")
AddEventHandler('lift:closeDoorDown', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local leftDoor = liftData[code].doorDownLID
	local rightDoor = liftData[code].doorDownRID
	
	
	if liftData[code].downDoorIsOpen then
		TriggerEvent("lift:closeCabinDoor")
		liftData[code].downDoorIsOpen = false
		for i=0,125 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,-0.005,0,0))
			SetEntityCoords(rightDoor,GetOffsetFromEntityInWorldCoords(rightDoor,0.005,0,0))
		end
		SetEntityCoords(leftDoor,liftData[code].doorDownLCoords.x,liftData[code].doorDownLCoords.y,liftData[code].doorDownLCoords.z)
		SetEntityCoords(rightDoor,liftData[code].doorDownRCoords.x,liftData[code].doorDownRCoords.y,liftData[code].doorDownRCoords.z)
	end
end)


RegisterNetEvent("lift:closeDoorDownIfnotBusy")
AddEventHandler('lift:closeDoorDownIfnotBusy', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	if not liftData[code].isInUse then
		TriggerEvent("lift:closeCabinDoor")
		local leftDoor = liftData[code].doorDownLID
		local rightDoor = liftData[code].doorDownRID
		liftData[code].downDoorIsOpen = false
		
		for i=0,125 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,-0.005,0,0))
			SetEntityCoords(rightDoor,GetOffsetFromEntityInWorldCoords(rightDoor,0.005,0,0))
		end
		SetEntityCoords(leftDoor,liftData[code].doorDownLCoords.x,liftData[code].doorDownLCoords.y,liftData[code].doorDownLCoords.z)
		SetEntityCoords(rightDoor,liftData[code].doorDownRCoords.x,liftData[code].doorDownRCoords.y,liftData[code].doorDownRCoords.z)
	end
end)


RegisterNetEvent("lift:openDoorUp")
AddEventHandler('lift:openDoorUp', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local leftDoor = liftData[code].doorUpLID
	local rightDoor = liftData[code].doorUpRID
	
	if not liftData[code].upDoorIsOpen then
		liftData[code].upDoorIsOpen = true
		TriggerEvent("lift:openCabinDoor",code)
		for i=0,125 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,0.005,0,0))
			SetEntityCoords(rightDoor,GetOffsetFromEntityInWorldCoords(rightDoor,-0.005,0,0))
		end
		SetEntityCoords(leftDoor,liftData[code].doorUpLOpenCoords.x,liftData[code].doorUpLOpenCoords.y,liftData[code].doorUpLOpenCoords.z)
		SetEntityCoords(rightDoor,liftData[code].doorUpROpenCoords.x,liftData[code].doorUpROpenCoords.y,liftData[code].doorUpROpenCoords.z)
	end
end)

RegisterNetEvent("lift:closeDoorUp")
AddEventHandler('lift:closeDoorUp', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local leftDoor = liftData[code].doorUpLID
	local rightDoor = liftData[code].doorUpRID
	
	if liftData[code].upDoorIsOpen then
		TriggerEvent("lift:closeCabinDoor")
		liftData[code].upDoorIsOpen = false
		for i=0,125 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,-0.005,0,0))
			SetEntityCoords(rightDoor,GetOffsetFromEntityInWorldCoords(rightDoor,0.005,0,0))
		end
		SetEntityCoords(leftDoor,liftData[code].doorUpLCoords.x,liftData[code].doorUpLCoords.y,liftData[code].doorUpLCoords.z)
		SetEntityCoords(rightDoor,liftData[code].doorUpRCoords.x,liftData[code].doorUpRCoords.y,liftData[code].doorUpRCoords.z)
	end
end)

RegisterNetEvent("lift:closeDoorUpIfnotBusy")
AddEventHandler('lift:closeDoorUpIfnotBusy', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	if not liftData[code].isInUse then
		TriggerEvent("lift:closeCabinDoor")
		local leftDoor = liftData[code].doorUpLID
		local rightDoor = liftData[code].doorUpRID
		liftData[code].upDoorIsOpen = false
		
		for i=0,125 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,-0.005,0,0))
			SetEntityCoords(rightDoor,GetOffsetFromEntityInWorldCoords(rightDoor,0.005,0,0))
		end
		SetEntityCoords(leftDoor,liftData[code].doorUpLCoords.x,liftData[code].doorUpLCoords.y,liftData[code].doorUpLCoords.z)
		SetEntityCoords(rightDoor,liftData[code].doorUpRCoords.x,liftData[code].doorUpRCoords.y,liftData[code].doorUpRCoords.z)
	end
end)



----------LIFT


RegisterNetEvent("lift:up")
AddEventHandler('lift:up', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = elevateHeight * 50
	liftData[code].isUp = true
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(1)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z+0.02)
	end
	SetEntityCoords(ascenseur,liftData[code].up.x,liftData[code].up.y,liftData[code].up.z)
	liftData[code].isInUse = false
end)

RegisterNetEvent("lift:StepUp")
AddEventHandler('lift:StepUp', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/4
	-- liftData[code].isUp = true
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(5)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z+0.01)
	end
	-- liftData[code].isInUse = false
end)


RegisterNetEvent("lift:down")
AddEventHandler('lift:down', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = elevateHeight * 50
	liftData[code].isUp = false
	liftData[code].isInUse = true
	
	for i=0,nbStep do
		Wait(1)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z-0.02)
	end
	SetEntityCoords(ascenseur,liftData[code].down.x,liftData[code].down.y,liftData[code].down.z+0.02)
	liftData[code].isInUse = false
end)

RegisterNetEvent("lift:StepDown")
AddEventHandler('lift:StepDown', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/4
	-- liftData[code].isUp = false
	liftData[code].isInUse = true
	
	for i=0,nbStep do
		Wait(5)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z-0.01)
	end
	-- SetEntityCoords(ascenseur,liftData[code].down.x,liftData[code].down.y,liftData[code].down.z+0.02)
	-- liftData[code].isInUse = false
end)


RegisterNetEvent("lift:upAndDoor")
AddEventHandler('lift:upAndDoor', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local ascenseur = liftData[code].elevateID
	-- print("RateAdjsuter : "..tostring(RateAdjsuter))
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = elevateHeight * 50
	liftData[code].isUp = true
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(1)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z+0.02)
	end
	
	SetEntityCoords(ascenseur,liftData[code].up.x,liftData[code].up.y,liftData[code].up.z)
	Wait(500)
	TriggerEvent("lift:openDoorUp",code)
	Wait(2500)
	liftData[code].isInUse = false
end)

RegisterNetEvent("lift:StepUpAndDoor")
AddEventHandler('lift:StepUpAndDoor', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local ascenseur = liftData[code].elevateID
	-- print("RateAdjsuter : "..tostring(RateAdjsuter))
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/4
	liftData[code].isUp = true
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(5)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z+0.01)
	end
	
	SetEntityCoords(ascenseur,liftData[code].up.x,liftData[code].up.y,liftData[code].up.z)
	Wait(500)
	TriggerEvent("lift:openDoorUp",code)
	Wait(2500)
	liftData[code].isInUse = false
end)

RegisterNetEvent("lift:downAndDoor")
AddEventHandler('lift:downAndDoor', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = elevateHeight * 50
	liftData[code].isUp = false
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(1)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z-0.02)
	end
	SetEntityCoords(ascenseur,liftData[code].down.x,liftData[code].down.y,liftData[code].down.z)
	Wait(500)
	TriggerEvent("lift:openDoorDown",code)
	Wait(2500)
	liftData[code].isInUse = false
end)

RegisterNetEvent("lift:StepDownAndDoor")
AddEventHandler('lift:StepDownAndDoor', function(code)

	--DEBUG
	-- code = "789456"
	------------------
	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/4
	liftData[code].isUp = false
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(5)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z-0.01)
	end
	SetEntityCoords(ascenseur,liftData[code].down.x,liftData[code].down.y,liftData[code].down.z)
	Wait(500)
	TriggerEvent("lift:openDoorDown",code)
	Wait(2500)
	liftData[code].isInUse = false
end)

RegisterNetEvent("lift:sendStatus")
AddEventHandler('lift:sendStatus', function(data)

	for k,v in pairs(data) do
		for k2,v2 in pairs(liftData) do
			if k==k2 then
				-- print("k :"..tostring(k).." k2 :"..tostring(k2).." vUp : "..tostring(v.isUp))
				liftData[k].isUp = v.isUp
			end
		end
	end
	isReady = true
end)

AddEventHandler('playerSpawned', function()
	TriggerServerEvent("lift:GetStatus")
end)

TriggerServerEvent("lift:GetStatus")

