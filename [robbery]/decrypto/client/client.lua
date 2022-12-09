local ESX = nil
local playerPed, playerCoords, Tablet
local PlayerJob = {}
local MiniGame ={}
local HackStatus = false
local NotifyMessage = ''
local NotifyType = 'primay'
local Hacked = {}
local playerPed = PlayerPedId()
local playerCoords = GetEntityCoords(playerPed, true)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleepThread = 500
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local atm =  GetClosestObjectOfType(pedCoords, 2.0, GetHashKey("prop_atm_01"), false, false,false)
		local atm2 =  GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_atm_02"), false, false,false)
		local atm3 =  GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_atm_03"), false, false,false)
		local atm4 =  GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_fleeca_atm"), false, false,false)
		if DoesEntityExist(atm) or DoesEntityExist(atm2) or DoesEntityExist(atm3) or DoesEntityExist(atm4) then
			sleepThread = 5
			local markerCoords = GetOffsetFromEntityInWorldCoords(atm, 0.0, -0.97, 0.05)
			local distanceCheck1 = #(pedCoords - markerCoords)
			local markerCoords2 = GetOffsetFromEntityInWorldCoords(atm2, 0.0, -0.97, 0.05)
			local distanceCheck2 = #(pedCoords - markerCoords2)
			local markerCoords3 = GetOffsetFromEntityInWorldCoords(atm3, 0.0, -0.97, 0.05)
			local distanceCheck3 = #(pedCoords - markerCoords3)
			local markerCoords4 = GetOffsetFromEntityInWorldCoords(atm4, 0.0, -0.97, 0.05)
			local distanceCheck4 = #(pedCoords - markerCoords4)
			if distanceCheck1 <= 2.0 then
				DrawText3D(GetEntityCoords(atm) + vector3(0.0, 0.0, 1.0), "Drücke ~r~G~w~ zum Hacken")
				if IsControlJustReleased(0, 58) then
					TriggerEvent("decrypto:client:starthack")
					while true do
						Wait(0)
						
						DrawText3D(GetEntityCoords(atm) + vector3(0.0, 0.0, 1.0), "Drücke ~r~X~w~ zum Abbrechen")
						if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
							break
						end
					end
				end
			elseif distanceCheck2 <= 2.0 then
				DrawText3D(GetEntityCoords(atm2) + vector3(0.0, 0.0, 1.0), "Drücke ~r~G~w~ zum Hacken")
				if IsControlJustReleased(0, 58) then
					TriggerEvent("decrypto:client:starthack")
					while true do
						Wait(0)
						
						DrawText3D(GetEntityCoords(atm2) + vector3(0.0, 0.0, 1.0), "Drücke ~r~X~w~ zum Abbrechen")
						if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
							break
						end
					end
				end
			elseif distanceCheck3 <= 2.0 then
				DrawText3D(GetEntityCoords(atm3) + vector3(0.0, 0.0, 1.0), "Drücke ~r~G~w~ zum Hacken")
				if IsControlJustReleased(0, 58) then
					TriggerEvent("decrypto:client:starthack")
					while true do
						Wait(0)
						
						DrawText3D(GetEntityCoords(atm3) + vector3(0.0, 0.0, 1.0), "Drücke ~r~X~w~ zum Abbrechen")
						if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
							break
						end
					end
				end
			elseif distanceCheck4 <= 2.0 then
				DrawText3D(GetEntityCoords(atm4) + vector3(0.0, 0.0, 1.0), "Drücke ~r~G~w~ zum Hacken")
				if IsControlJustReleased(0, 58) then
					TriggerEvent("decrypto:client:starthack")
					while true do
						Wait(0)
						
						DrawText3D(GetEntityCoords(atm4) + vector3(0.0, 0.0, 1.0), "Drücke ~r~X~w~ zum Abbrechen")
						if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
							break
						end
					end
				end
			end
		end
		Citizen.Wait(sleepThread)
	end
end)

DrawTxt3D = function(coords, text, sound, force)
    if not Config.Use3DText and not force then
        HelpText(text, (sound == true))
        return
    end

    local str = text

    local start, stop = string.find(text, "~([^~]+)~")
    if start then
        start = start - 2
        stop = stop + 2
        str = ""
        str = str .. string.sub(text, 0, start) .. "   " .. string.sub(text, start+2, stop-2) .. string.sub(text, stop, #text)
    end

    AddTextEntry(GetCurrentResourceName(), str)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)

	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
end

HelpText = function(text, sound)
    AddTextEntry(GetCurrentResourceName(), text)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(0, 0, (sound == true), -1)
end

DrawText3D = function(coords, text)
    SetDrawOrigin(coords)

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.015 + text:gsub("~.-~", ""):len() / 370, 0.03, 45, 45, 45, 150)

    ClearDrawOrigin()
end


-- NUI

MiniGame.Open = function()
	SendNUIMessage({
		action = "open",
		base = Config.MingameBase, 
		timeLimit = Config.MinigameTimeLimit,
		attemptLimit = Config.MingameAttemptLimit 
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback('close', function(data, cb)
	cb('ok')
	HackStatus = data
	Citizen.Wait(500)
	ClearPedTasks(PlayerPedId())
	Citizen.Wait(500)
	DeleteObject(Tablet)
	if HackStatus then
		NotifyMessage = 'Hack Successful!'
		NotifyType = 'success'
		TriggerServerEvent("decrypto:server:givecash")
		local chance = math.random()
		if chance < Config.Chance then
			TriggerServerEvent('robatm:notifyPolice', playerCoords)
		end
	else
		NotifyMessage = 'Hack Failed!'
		NotifyType = 'error'
		
	end
	ESX.ShowNotification(NotifyMessage)
	SetNuiFocus(false, false)
	ClearPedTasks(PlayerPedId())
	DeleteObject(tablet)
	TriggerServerEvent("decrypto:server:removeitem", "hackcard")
	TriggerServerEvent('robatm:notifyPolice', playerCoords)
end)


-- Events

RegisterNetEvent('decrypto:client:starthack')
AddEventHandler('decrypto:client:starthack', function()
	ATMHack()
end)


-- Functions

function ATMHack()
	playerPed = PlayerPedId()
	playerCoords = GetEntityCoords(playerPed, true)
	local nearATM = false
	local hackStarted = false
	local beenHacked = false
	ESX.TriggerServerCallback("decrypto:server:hasitem", function(hasItem)
		if(hasItem) then
			for k, v in pairs(Config.ATMModelsString) do
				print(v)
				local hash = GetHashKey(v)
				print(hash)
				Citizen.Wait(50)
				nearATM = IsObjectNearPoint(hash, playerCoords.x, playerCoords.y, playerCoords.z, 1.5)
				print(nearATM)
				Citizen.Wait(50)
				if nearATM then
					hackStarted = true
					local ATM = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 1.5, hash, false, false, false)
					for i = 1, #Hacked do
						if Hacked[i] == ATM then
							beenHacked = true
						end
					end
					if not beenHacked then
						local chance = math.random()
						if chance < Config.Chance then
							TriggerServerEvent('robatm:notifyPolice', playerCoords)
						end
						RequestAnimDict('amb@prop_human_atm@male@enter')
						while not HasAnimDictLoaded('amb@prop_human_atm@male@enter') do
							Citizen.Wait(5)
						end
						if HasAnimDictLoaded('amb@prop_human_atm@male@enter') then
							TaskPlayAnim(playerPed, 'amb@prop_human_atm@male@enter', "enter", 1.0,-1.0, 3000, 1, 1, true, true, true)
							Citizen.Wait(1000)
							Tablet = CreateObject(GetHashKey("hei_prop_dlc_tablet"), 0, 0, 0, true, true, true)
							AttachEntityToEntity(Tablet, playerPed, GetPedBoneIndex(GetPlayerPed(-1), 18905), 0.20, 0.12, 0.05, 58.0, 122.0, 180.0, true, true, false, true, 1, true)
							RequestAnimDict('missfam4')
							while not HasAnimDictLoaded('missfam4') do
								Citizen.Wait(5)
							end
							if HasAnimDictLoaded('missfam4') then
								TaskPlayAnim(playerPed, "missfam4", "base", 1.0, 4.0, -1, 33, 0.0, false, false, false)
								Citizen.Wait(2000)
							end
						end
						table.insert(Hacked, ATM)
						MiniGame.Open()
						for i=1, Config.AlarmTime, 1 do
							if Config.useSound then
								PlaySoundFromCoord(-1, "scanner_alarm_os", playerCoords.x, playerCoords.y, playerCoords.z, "dlc_xm_iaa_player_facility_sounds", 1, 50, 0)
							end
							Citizen.Wait(1000)
						end
					else
						ESX.ShowNotification('Already hacked!')
					end
				else
					if not hackStarted and k == #Config.ATMModelsString then
						ESX.ShowNotification('You cannot do that here.')
					end
				end
			end
		else
			ESX.ShowNotification('Dir fehlt etwas dafür!')
		end
	end,'hackcard')
end






----------------------


local NPCPosition = {x = 59.301098, y = 41.512093, z = 73.510620, heading = 280.629913}

local isNearPed = false
local isAtPed = false
local isPedLoaded = false
local pedModel = GetHashKey('a_m_m_og_boss_01')
local npc

Citizen.CreateThread(function()

    while true do

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local distance = Vdist(playerCoords, NPCPosition.x, NPCPosition.y, NPCPosition.z)
        isNearPed = false
        isAtPed = false

        if distance < 20.0 then
            isNearPed = true
            if not isPedLoaded then
                RequestModel(pedModel)
                while not HasModelLoaded(pedModel) do
                    Wait(10)
                end

                npc = CreatePed(4, pedModel, NPCPosition.x, NPCPosition.y, NPCPosition.z - 1.0, NPCPosition.Heading, false, false)
                FreezeEntityPosition(npc, true)
                SetEntityHeading(npc, NPCPosition.rot)
                SetEntityInvincible(npc, true)
                SetBlockingOfNonTemporaryEvents(npc, true)

                isPedLoaded = true
            end
        end

        if isPedLoaded and not isNearPed then
            DeleteEntity(npc)
            SetModelAsNoLongerNeeded(pedModel)
            isPedLoaded = false
        end

        if distance < 2.0 then
            isAtPed = true
        end
        Citizen.Wait(500)
    end

end)

Citizen.CreateThread(function()
    local playerPed = PlayerPedId()
    while true do
        sleep = 1500
        if isAtPed then
            sleep = 0
            showInfobar(Config.PressEToBuyKey)
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent('robatm:giveItem', playerPed)
            end
        end
        Citizen.Wait(sleep)
    end
end)


function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end

--Event für das Notify erstellen
RegisterNetEvent('robatm:showNotify')
AddEventHandler('robatm:showNotify', function(text)
    ShowNotification(text)
end)

function showInfobar(msg)
	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('robatm:callPolice')
AddEventHandler('robatm:callPolice', function(coords)

    local streetlabel = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local street = GetStreetNameFromHashKey(streetlabel)
    showPictureNotification('CHAR_MP_MERRYWEATHER', Translation[Config.Locale]['cop_notify'] .. street .. Translation[Config.Locale]['cop_notify2'], Translation[Config.Locale]['cop_atm'], Translation[Config.Locale]['cop_heading'])


    local Blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local transT = 600

    SetBlipSprite(Blip, 10)
    SetBlipColour(Blip,  2)
    SetBlipAlpha(Blip,  transT)
    SetBlipAsShortRange(Blip, 1)

    while transT ~= 0 do
        Wait(100)
        transT = transT - 1
        SetBlipAlpha(Blip, transT)
        if transT == 0 then
            SetBlipSprite(Blip, 2)
            return
        end
    end

end)

RegisterNetEvent('robatm:notifyPoliceAbort')
AddEventHandler('robatm:notifyPoliceAbort', function()
	showPictureNotification('CHAR_MP_MERRYWEATHER', Translation[Config.Locale]['rob_aborted_chat'], Translation[Config.Locale]['cop_atm'], Translation[Config.Locale]['rob_abort_title'])
end)

function showPictureNotification(icon, msg, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg);
    SetNotificationMessage(icon, icon, true, 1, title, subtitle);
    DrawNotification(false, true);
end
