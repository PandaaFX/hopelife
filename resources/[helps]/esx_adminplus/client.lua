ESX = nil
local Licenses = {}
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)
----------------------------------------------------------------------------------
RegisterNetEvent("esx_admin:killPlayer")
AddEventHandler("esx_admin:killPlayer", function()
  SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("esx_admin:freezePlayer")
AddEventHandler("esx_admin:freezePlayer", function(input)
    local player = PlayerId()
	local ped = PlayerPedId()
    if input == 'freeze' then
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
    elseif input == 'unfreeze' then
        SetEntityCollision(ped, true)
	    FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    end
end)

-------------EINREISE------------



exports["bt-polyzone"]:AddCircleZone("Einreise", vector3(-1070.782, -2791.174, 21.30994), 140.0, {
	name="Einreise",
    --debugPoly=true,
    minZ=15.92,
    maxZ=27.72
})

AddEventHandler('bt-polyzone:enter', function(name)
    if name == "Einreise" then
		TriggerServerEvent('esx_adminplus:ServerLoadLicenses')
    end
end)


AddEventHandler('bt-polyzone:exit', function(name)
	local player = PlayerId()
	local ped = PlayerPedId()
	local Time = 5
    if name == "Einreise" then
		TriggerServerEvent('esx_adminplus:ServerLoadLicenses')
		local ownedLicenses = {}

		for i=1, #Licenses, 1 do
			ownedLicenses[Licenses[i].type] = true
		end
		if ownedLicenses['einreise'] then
			--exports['okokNotify']:Alert("Willkommen", "bei HopeLife", Time, "info")
		end
		if not ownedLicenses['einreise'] then
			exports['okokNotify']:Alert("Willkommen", "bei HopeLife", Time, "warning")
			SetEntityCoords(ped, vector3(-1050.185, -2756.229, 21.30))
		end
    end
end)

RegisterNetEvent('esx_adminplus:loadLicenses')
AddEventHandler('esx_adminplus:loadLicenses', function(licenses)
	Licenses = licenses
end)



--Thanks to qalle for this code | https://github.com/qalle-fivem/esx_marker
RegisterNetEvent("esx_admin:rein")
AddEventHandler("esx_admin:rein", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
	SetEntityCoords(playerPed, -1085.01, -2773.48, 21.32)
	SetEntityHeading(playerPed, 146.78)
end)

RegisterNetEvent("esx_admin:raus")
AddEventHandler("esx_admin:raus", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
	SetEntityCoords(playerPed, -1038.0, -2737.54, 20.17)
	SetEntityHeading(playerPed, 344.19)
end)

RegisterNetEvent("esx_admin:raus2") --WP Ostseite
AddEventHandler("esx_admin:raus2", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
	SetEntityCoords(playerPed, 252.6, -898.44, 29.1)
	SetEntityHeading(playerPed, 248.57)
end)

RegisterNetEvent("esx_admin:raus3") -- Paleto Bay
AddEventHandler("esx_admin:raus3", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
	SetEntityCoords(playerPed, -406.91, 6062.52, 31.5)
	SetEntityHeading(playerPed, 136.45)
end)

RegisterNetEvent("esx_admin:bauamt")
AddEventHandler("esx_admin:bauamt", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
	SetEntityCoords(playerPed, -77.472527, -829.213196, 243.373657)
	SetEntityHeading(playerPed, 340.157471)
end)


RegisterNetEvent("esx_admin:bauamt2")
AddEventHandler("esx_admin:bauamt2", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
	SetEntityCoords(playerPed, -82.048347, -837.665955, 40.552368)
	SetEntityHeading(playerPed, 175.748032)
end)

-----EINREISESPOT-----

local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local npcspawn = false
local status= false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if not npcspawn then
            RequestModel( GetHashKey( "s_f_y_airhostess_01" ) )
            while ( not HasModelLoaded( GetHashKey( "s_f_y_airhostess_01" ) ) ) do
                Citizen.Wait(1)
            end
            npc = CreatePed(4, "s_f_y_airhostess_01", -1062.68,  -2783.23,  20.32 , 156.69, false, false)
            FreezeEntityPosition(npc, true)
            SetEntityHeading(npc, 156.69)
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
            npcspawn = true
        end
        
        if (GetDistanceBetweenCoords(playerCoords, -1062.68,  -2783.23,  20.32, false) < 2) then
            ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um einen Einreisebeamten zu rufen')
            if IsControlJustPressed(0, 38) and not status then
                status= true
                ESX.Progressbar("Anfrage gesendet, Warte bitte", 10000,{
                    FreezePlayer = false, 
                    onFinish = function()
                    TriggerServerEvent('einreise:anfrage', playerPed)
                end})
                Citizen.Wait(60000)
                status = false
            end
        else
            Citizen.Wait(500)
        end
    end
end)


RegisterNetEvent('einreise:einreise')
AddEventHandler('einreise:einreise', function(playername,playerid)
	TriggerEvent("EasyAdmin:showNotification", 'EINREISE! ' .. playername .. '\nmöchte Einreisen')
end)


RegisterNetEvent('einreise:einreisefail')
AddEventHandler('einreise:einreisefail', function()
	TriggerEvent("EasyAdmin:showNotification", 'Aktuell ist kein Supporter Online! Dein Anliegen wurde aber in den Discord weitergeleitet')
end)
