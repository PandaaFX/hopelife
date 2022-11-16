PLT = plt_plants
Plants = PLT.Plants
U = PLT.U
PlantList = 0
CloseWeeds = {}
NearPlants = {}
playerPedId = 0
playerCoord = vector3(0.0,0.0,0.0)
Now = 0
MyIdent = 0
DisableActions = false
activePlantID = false
NuiFocus = false
waitForNewFocus = false
inVehicle = true
Citizen.CreateThread(function()
	while PlantList == 0 do Citizen.Wait(1000) end local dist = 0 local bekle = 0 local playerToPlant = 1000 local onPlant = false 
	while true do bekle = 1000
		playerCoord = GetEntityCoords(playerPedId)
		onPlant = false
		if inVehicle == false then
			for k,v in pairs(CloseWeeds) do 
				kapat = true
				playerToPlant = GetDistanceBetweenCoords(playerCoord, v.x, v.y, v.z, false)
				if playerToPlant < PLT.MarkerDistance then bekle = 0
					dist = Plants[v.type].width
					--DrawMarker(6,v.x, v.y, v.z  ,0.0, 0.0, 0.0,-90,-90,-90, dist*2,dist*2,dist*2,PLT.MarkerColour.r,PLT.MarkerColour.g,PLT.MarkerColour.b,PLT.MarkerColour.alpha,false, true, 2, false, false, false, false) 
					if playerToPlant < dist  and math.max(v.z,playerCoord.z) - math.min(v.z,playerCoord.z) < 2  then
						if playerToPlant < dist and not DisableActions and not waitForNewFocus then
							onPlant = true
							if activePlantID ~= k then activePlantID = k RefreshNui() end
							SpammingNotify(U["press_action"]..k)
							if IsControlPressed(0,46)  and not v.onAction then
								NuiFocus = true
								RefreshNui()
								SetNuiFocus(true, true)
							end
						end
					end
				end
			end
		end
		if onPlant == false and activePlantID ~= false then  activePlantID = false  SendNUIMessage({show = false})  if NuiFocus then setNuiFocusFalse() end RefreshNui() end
		Citizen.Wait(bekle)
	end
end)  
RegisterNetEvent('plt_plants:CanNewPlants')
AddEventHandler('plt_plants:CanNewPlants', function(plantName)
	playerCoord = GetEntityCoords(playerPedId)
	local groundZ = playerCoord.z-GetEntityHeightAboveGround(playerPedId)
	if not IsPedOnFoot(playerPedId) then singleNotify("error",U["cant_like_on_foot"]) return end
	if IsEntityInWater(playerPedId) then singleNotify("error",U["cant_inwater"]) return end
	if PLT.Plants[plantName].OnlyOutOfCity and closeToCity(playerCoord) then singleNotify("error", U["go_outof_city"]) return end
	if (math.max(playerCoord.z,groundZ) - math.min(playerCoord.z,groundZ)) > 2 then singleNotify("error", U["cant_here_z"]) return end
	if IsPointOnRoad(playerCoord.x, playerCoord.y, groundZ, false) then singleNotify("error",U["cant_on_way"]) return end
	if type(PLT.Plants[plantName].InsideTheAreas) == "table" then
		local plyrInsideArea = false
		local anycoord = false
		for k,v in pairs(PLT.Plants[plantName].InsideTheAreas) do
			if v.coord and v.distance then anycoord = true if GetDistanceBetweenCoords(playerCoord, v.coord, true) < v.distance then plyrInsideArea = true	end	end
		end
		if plyrInsideArea == false and anycoord == true then if PLT.Plants[plantName].InsideTheAreas.notify then singleNotify("error",PLT.Plants[plantName].InsideTheAreas.notify) end return end
	end
	if type(PLT.Plants[plantName].OutsideTheAreas) == "table" then
		local plyrOutsideArea = false
		for k,v in pairs(PLT.Plants[plantName].OutsideTheAreas) do
			if v.coord and v.distance then if GetDistanceBetweenCoords(playerCoord, v.coord, true) < v.distance then plyrOutsideArea = true	end	end
		end
		if plyrOutsideArea == true then if PLT.Plants[plantName].OutsideTheAreas.notify then singleNotify("error",PLT.Plants[plantName].OutsideTheAreas.notify) end return end
	end
	TriggerServerEvent("plt_plants:NewPlant",plantName,vector3(playerCoord.x,playerCoord.y,groundZ))
end)
RegisterNetEvent('plt_plants:DoAnim')
AddEventHandler('plt_plants:DoAnim', function(islem,info,id)
   	while DisableActions do Citizen.Wait(math.random(1000,1500)) end
	DisableActions = true
	playerCoord = GetEntityCoords(playerPedId)
	local actionCoords
	actionCoords =vector3(info.x ,info.y,info.z)
	if islem == "addPlant" or islem == "addFertilizer" then 
		actionCoords =vector3(info.x ,info.y+0.75,info.z)
	else
		SetEntityHeading(PlantList[id].objeId, GetHeadingFromVector_2d(playerCoord.x-info.x,playerCoord.y-info.y))
		actionCoords = vector3(GetEntityCoords(PlantList[id].objeId)["x"] +  GetEntityForwardVector(PlantList[id].objeId)["x"] * 0.8, GetEntityCoords(PlantList[id].objeId)["y"] +  GetEntityForwardVector(PlantList[id].objeId)["y"] * 0.8, info.z) 
	end 
	TaskGoStraightToCoord(playerPedId, actionCoords.x ,actionCoords.y,actionCoords.z, 0.5, 5000, 0.0, 0.5)
	playerCoord = GetEntityCoords(playerPedId)
	rNum = 0 while not (GetDistanceBetweenCoords(playerCoord, actionCoords.x ,actionCoords.y,actionCoords.z, false) < 0.2 ) do Citizen.Wait(10)  
	playerCoord = GetEntityCoords(playerPedId)  rNum = rNum + 1 if rNum > 300 then  SetEntityCoords(GetPlayerPed(-1), actionCoords.x ,actionCoords.y,actionCoords.z, 1,0,0,1) break end end Citizen.Wait(200)
	ClearPedTasks(playerPedId)
	local h = GetHeadingFromVector_2d(info.x-playerCoord.x,info.y-playerCoord.y)
	TaskAchieveHeading(playerPedId,h)
	Citizen.Wait(1250)
	SetEntityHeading(playerPedId, h)
	if islem == "addPlant" then
		animPlant(id)
	elseif islem == "addWater" then
		animWater(id,info)
	elseif islem == "addFertilizer" then
		animFertilizer(id,info,actionCoords)
	elseif islem == "fire" then	
		animFire(id,info)
	elseif islem == "harvest" then	
		animHarvest(id,info)
	end 
	DisableActions = false   
end)
function animPlant(id)
	TaskStartScenarioInPlace(playerPedId, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
	FreezeEntityPosition(playerPedId,true)
	local durum = true 
	Citizen.CreateThread(function()	Citizen.Wait(10000) durum = false end)
	while durum do Citizen.Wait(0) if CancelAnim() == true then durum = "cancel" break end  end
	if durum == "cancel" then TriggerServerEvent("plt_plants:SetAction",id,"delete") end
	ClearPedTasks(playerPedId)
	FreezeEntityPosition(playerPedId,false)
end
function animWater(id,info)
	playerPedId = PlayerPedId()
	playerCoord = GetEntityCoords(playerPedId)
	objeCoords  = vector3(GetEntityCoords(playerPedId)["x"] +  GetEntityForwardVector(playerPedId)["x"] * 0.5, GetEntityCoords(playerPedId)["y"] +  GetEntityForwardVector(playerPedId)["y"] * 0.5, info.z) 
	FreezeEntityPosition(playerPedId,true)
	local bottleObj = CreateObject(GetHashKey("prop_wateringcan"), objeCoords.x , objeCoords.y , objeCoords.z , true, true, true)
	loadAnimDict("random@domestic") 
	TaskPlayAnim(playerPedId, "random@domestic", "pickup_low", 1.0, 1.0, -1, 0, 0, false, false, false)
	Citizen.Wait(750)
	AttachEntityToEntity(bottleObj, playerPedId, GetPedBoneIndex(playerPedId, 28422), 0.07, 0.0, -0.22, 0.0, 30.0, -0.0, 1, 1, 0, 1, 0, 1)
	loadAnimDict("missarmenian3_gardener")
	TaskPlayAnim(playerPedId, "missarmenian3_gardener", "blower_idle_a", 1.0, 1.0, -1, 16, 0, false, false, false)
	local durum = true
	Citizen.CreateThread(function() Citizen.Wait(14000) durum = false end)
 	Citizen.CreateThread(function()
		local ccc RequestNamedPtfxAsset("scr_exile3")	while not HasNamedPtfxAssetLoaded("scr_exile3") do Citizen.Wait(0)end
		while durum == true do 
		 	if not IsEntityPlayingAnim(playerPedId, "missarmenian3_gardener", "blower_idle_a", 3) then 
				loadAnimDict("missarmenian3_gardener")
				TaskPlayAnim(playerPedId, "missarmenian3_gardener", "blower_idle_a", 1.0, 1.0, -1, 16, 0, false, false, false)
			end 
			ccc = GetOffsetFromEntityInWorldCoords(bottleObj, 0.35, 0.0, 0.20)
			UseParticleFxAssetNextCall("scr_exile3")
			StartNetworkedParticleFxNonLoopedAtCoord("water_splash_ped", ccc.x , ccc.y , ccc.z, 0.0, 0.0, 0.0, 0.2, false, false, false)
			Citizen.Wait(50)
		end
	end) 
	while durum do Citizen.Wait(0)
		if HasEntityBeenDamagedByAnyPed(bottleObj) then  durum = "cancel"  break end
		if HasEntityBeenDamagedByAnyPed(playerPedId) then durum = "cancel"  break end
		if CancelAnim() == true then durum = "cancel"  break end
	end
	if durum == false then 	TriggerServerEvent("plt_plants:SetAction",id,"water") ClearPedTasks(playerPedId)
	else TriggerServerEvent("plt_plants:SetFalseOnAction",id) ClearPedTasksImmediately(playerPedId) end	
	DeleteEntity(bottleObj)
	FreezeEntityPosition(playerPedId,false)
end
function animFertilizer(id,info,actCoord)
	playerCoord = GetEntityCoords(playerPedId)
	local actPos = actCoord - vector3(-4.88,-1.95,-0.6)
	actPos =  vector3(actPos.x,actPos.y,playerCoord.z-0.4)
	local scissorsNetID
	local dictBase = "anim@amb@business@meth@meth_monitoring_cooking@cooking@"
	local scissorsModel = GetHashKey("bkr_prop_meth_sacid")
	RequestModel(scissorsModel) while not HasModelLoaded(scissorsModel) do Wait(0) end
	local fertilizerObj = CreateObject(scissorsModel, actCoord.x, actCoord.y, actCoord.z-2, true, true, false)
	DisableCamCollisionForEntity(fertilizerObj)
	SetEntityCollision(fertilizerObj, false, true)
	SetModelAsNoLongerNeeded(scissorsModel)
	scissorsNetID = ObjToNet(fertilizerObj)
	SetNetworkIdExistsOnAllMachines(scissorsNetID, true)
	RequestAnimDict(dictBase)
	while not HasAnimDictLoaded(dictBase) do Wait(0) end
	local netScene = NetworkCreateSynchronisedScene(actPos, 0.0, 0.0, 0.0, 2, 1, 0, 1.0, 0.0, 1.0)
	local netScene2 = NetworkAddPedToSynchronisedScene(PlayerPedId(), netScene, dictBase, "chemical_pour_short_cooker", 1.0, 1.0, 0, 0, 1.0, 0)
	local netScene3 = NetworkAddEntityToSynchronisedScene(NetToEnt(scissorsNetID), netScene, dictBase, "chemical_pour_short_sacid", 1.0, 1.0, 1)
	NetworkStartSynchronisedScene(netScene)
	local durum = true
	Citizen.CreateThread(function()	Citizen.Wait(39000)	durum = false end)
 	Citizen.CreateThread(function()
		local ccc RequestNamedPtfxAsset("des_bigjobdrill")	while not HasNamedPtfxAssetLoaded("des_bigjobdrill") do Citizen.Wait(0)end
		while DisableActions do ccc  = GetOffsetFromEntityInWorldCoords(fertilizerObj, -0.20, 0.0, 0.40)
			if math.abs(GetEntityRotation(fertilizerObj).x) > 80  or math.abs(GetEntityRotation(fertilizerObj).y) > 80 then 
				UseParticleFxAssetNextCall("des_bigjobdrill")
				StartNetworkedParticleFxNonLoopedAtCoord("ent_ray_big_drill_trail", ccc.x , ccc.y , ccc.z, 0.0, 0.0, 0.0, 0.2, false, false, false)
			end Citizen.Wait(150)
		end
	end) 
	while durum do Citizen.Wait(0)
		if HasEntityBeenDamagedByAnyPed(fertilizerObj) then  durum = "cancel"  break end
		if HasEntityBeenDamagedByAnyPed(playerPedId) then durum = "cancel"  break end
		if CancelAnim() == true then durum = "cancel"  break end
	end
	NetworkStartSynchronisedScene(netScene)
	NetworkStartSynchronisedScene(netScene2)
	NetworkStartSynchronisedScene(netScene3)
	DeleteEntity(fertilizerObj)
	if durum == false then 	TriggerServerEvent("plt_plants:SetAction",id,"fertilizer")	ClearPedTasks(playerPedId)
	else TriggerServerEvent("plt_plants:SetFalseOnAction",id) ClearPedTasksImmediately(playerPedId) end	
end
function animFire(id,info)
	RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')  
	while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')do Citizen.Wait(0)	end
	TaskPlayAnim(playerPedId,"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0, 1.0, -1, 8, -1, true, true, true)
	FreezeEntityPosition(playerPedId,true) 
	local h = GetEntityHeading(playerPedId)
	Citizen.Wait(3500) 
	FreezeEntityPosition(playerPedId,false)
	ClearPedTasks(playerPedId)
	TaskAchieveHeading(playerPedId,h-180)
	Citizen.Wait(1250)
	SetEntityHeading(playerPedId, h-180)
	local newCoord  = vector3(GetEntityCoords(playerPedId)["x"] +  GetEntityForwardVector(playerPedId)["x"] * 3, GetEntityCoords(playerPedId)["y"] +  GetEntityForwardVector(playerPedId)["y"] * 3, info.z) 
	TaskGoStraightToCoord(playerPedId, newCoord.x ,newCoord.y,newCoord.z, 0.5, 5000, 0.0, 0.5)
	Citizen.Wait(2500)
	TaskAchieveHeading(playerPedId, h, 1000)
	DeleteEntity(model)
end
function effectFire(weedCoord)
	local dist = Plants[weedCoord.type].width dist = dist > 1.5 and 1.5 or dist
    RequestNamedPtfxAsset("core")  while not HasNamedPtfxAssetLoaded("core") do Citizen.Wait(1) RequestNamedPtfxAsset("core") end SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire",weedCoord.x, weedCoord.y, weedCoord.z , 0.0, 0.0, 0.0, dist/5, false, false, false, false)
	Citizen.Wait(60000) StopParticleFxLooped(fire, 0)
end
function animHarvest(id,info)
	TaskStartScenarioInPlace(playerPedId, "PROP_HUMAN_BUM_BIN", 0, true)
	FreezeEntityPosition(playerPedId,true) 
	local durum = true Citizen.CreateThread(function() Citizen.Wait(15000) durum = false end)
	while durum do Citizen.Wait(0) if CancelAnim() == true then durum = "cancel"  break end end
	if durum == false then TriggerServerEvent("plt_plants:SetAction",id,"harvest") ClearPedTasks(playerPedId)
	else TriggerServerEvent("plt_plants:SetFalseOnAction",id) ClearPedTasksImmediately(playerPedId) end	
	FreezeEntityPosition(playerPedId,false)
	DeleteEntity(model)
end
function CanIFire(coord) return false end--If you want, you can check whether there is a police officer here and make sure that the police can burn the objects in every situation.
function closeToCity(coord)	return GetDistanceBetweenCoords(coord,vector3(-800.00,-900.00,0),false) < 2000 end
function loadAnimDict(dict)	while (not HasAnimDictLoaded(dict)) do RequestAnimDict(dict) Citizen.Wait(0) end end
function loadModel(model)
	if IsModelValid(GetHashKey(model)) then 
		 while not HasModelLoaded(GetHashKey(model)) do	Citizen.Wait(10) RequestModel(model) end 
	else
		singleNotify("error",model.."' prop is not upload on the server. please upload first",25000)
	end
end
function SpammingNotify(msg)SetTextComponentFormat("STRING")AddTextComponentString(msg)DisplayHelpTextFromStringLabel(0,0,1,-1)end
Citizen.CreateThread(function()
	while true do Citizen.Wait(0)
		if DisableActions then 
			DisableControlAction(0, 30, true) -- disable left/right
			DisableControlAction(0, 31, true) -- disable forward/back
			DisableControlAction(0, 36, true) -- INPUT_DUCK
			DisableControlAction(0, 21, true) -- disable sprint
			DisableControlAction(0, 63, true) -- veh turn left
			DisableControlAction(0, 64, true) -- veh turn right
			DisableControlAction(0, 71, true) -- veh forward
			DisableControlAction(0, 72, true) -- veh backwards
			DisableControlAction(0, 75, true) -- disable exit vehicle
			DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(1, 37, true) -- disable weapon select
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 142, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
		else
			Citizen.Wait(1500)
		end
	end
end)
function CancelAnim() DrawTextCancel()
	if IsControlJustPressed(0, 73) then return true end
	return false
end
function DrawTextCancel()
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(U["press_x_cancel"])
	DrawText(0.4, 0.90)
end
RegisterNetEvent('plt_plants:SendNotify')
AddEventHandler('plt_plants:SendNotify', function(type, message, time)
	singleNotify(type, message, time)
end)
RegisterCommand("closeplantui", function(source, args, rawCommand)
	setNuiFocusFalse(false)
end, false)
function singleNotify(type, message, time)
	exports['mythic_notify']:DoCustomHudText(type, message, time)
end