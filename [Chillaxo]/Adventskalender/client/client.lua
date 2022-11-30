ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end
local treespawn = false
local tree

local pickup = false

local function CheckDistanz(pos, day)
	local distanz = Vdist(pos, Config.Days[day].treeposition)
	if distanz <= 10 then
		return true
	else
		return false
	end
end

Citizen.CreateThread(function ()
	while true do
		local year --[[ integer ]], month --[[ integer ]], day --[[ integer ]], hour --[[ integer ]], minute --[[ integer ]], second --[[ integer ]] =
		GetLocalTime()

		local treeposition = vector3(Config.Days[day].treeposition.x, Config.Days[day].treeposition.y, Config.Days[day].treeposition.z-1.8);

		local player = PlayerPedId()
		local pos =  GetEntityCoords(player)
		if month == Config.Month then
			if treespawn == false then
				if tree == nil then
					if Config.ShowBlips == true then
							local blip = AddBlipForCoord(treeposition)
							SetBlipSprite(blip, 469)
							SetBlipDisplay(blip, 4)
							SetBlipScale(blip, 0.5)
					  
					  
							
							SetBlipColour(blip, 25)
							SetBlipAsShortRange(blip, true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString("AdventsBaum")
							EndTextCommandSetBlipName(blip)
						  
					end
					local modelHash = Config.treeObj
					if not HasModelLoaded(modelHash) then
						RequestModel(modelHash)
					
						while not HasModelLoaded(modelHash) do
							Citizen.Wait(1)
						end
					end
	
					tree = 	CreateObject(
						modelHash --[[ Hash ]], 
						treeposition--[[ number ]], 
						true
					)
					treespawn = true
				end
			end
			if IsControlPressed(0,38) and pickup == false  then
				if CheckDistanz(pos, day) then

					TriggerServerEvent('ChillKalender:Check', day)

				end
			end
		end

		Citizen.Wait(500)
	end
end)

RegisterNetEvent('ChillKalender:PlayAnimation', function(day)
	local player = PlayerPedId()
	if not IsEntityPlayingAnim(player, Config.Animname, Config.Animdirect, 3) then
		LoadAnim(Config.Animname)
	end 
	day = tonumber(day)
	TaskPlayAnim(player, Config.Animname, Config.Animdirect, 8.0, 1.0, 5000, 1, 1, false, false, false)
	pickup = true
	SetTimeout(5000, function ()
		pickup = false
		local r = math.random(1, #Config.Days[day].Items)
		local itemname = Config.Days[day].Items[r].ItemName
		local amount = Config.Days[day].Items[r].count 
		local isMoney = Config.Days[day].Items[r].ItemIsMoney
		TriggerServerEvent('ChillKalender:GiveItem', itemname, amount, isMoney, day)

	end)
end)

